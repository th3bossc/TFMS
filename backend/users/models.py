from django.db import models
from django.utils import timezone
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin, BaseUserManager
# Create your models here.

class CustomAccountManager(BaseUserManager):
    def create_superuser(self, aadhar_no, phone_no, license_no, first_name, last_name, email, salary, password, **other_fields):
        other_fields.setdefault('is_staff', True)
        other_fields.setdefault('is_superuser', True)
        other_fields.setdefault('is_active', True)
        
        if other_fields.get('is_staff') is not True:
            raise ValueError('Superuser must be assigned to is_staff=True.')
        if other_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must be assigned to is_superuser=True.')
        
        return self.create_user(aadhar_no, phone_no, license_no, first_name, last_name, email, salary, password, **other_fields)
    
    def create_user(self, aadhar_no, phone_no, license_no, first_name, last_name, email, salary, password, **other_fields):
        if not phone_no:
            raise ValueError(_('You must provide a phone number'))
        
        email = self.normalize_email(email)
        user = self.model(aadhar_no=aadhar_no, phone_no=phone_no, license_no=license_no, first_name=first_name, last_name=last_name, email=email, salary=salary, **other_fields)
        user.set_password(password)
        user.save()
        return user
    
    
class User(AbstractBaseUser, PermissionsMixin):
    aadhar_no = models.CharField(max_length=12, unique=True, primary_key=True)
    phone_no = models.CharField(max_length=10, unique=True)
    license_no = models.CharField(max_length=12, unique=True)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    start_date = models.DateTimeField(default=timezone.now)
    email = models.EmailField(_("Email address"), blank=True, unique=True)
    salary = models.FloatField(default=0)
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    objects = CustomAccountManager()
    
    USERNAME_FIELD = 'phone_no'
    REQUIRED_FIELDS = ['aadhar_no', 'license_no', 'first_name', 'last_name', 'email', 'salary']
    
    
    
    def __str__(self):
        if (self.is_superuser):
            return f"{self.first_name} {self.last_name} (Admin)"
        else:
            return f"{self.first_name} {self.last_name}"
    
    def get_full_name(self):
        return self.first_name + ' ' + self.last_name
    
    def get_short_name(self):
        return self.first_name
    
    class Meta:
        db_table = 'user'
        verbose_name = 'user'
        verbose_name_plural = 'users'
    
class Vehicles(models.Model):
    types = (
        ("MCWOG", "Motorcycle without gear"),
        ("MCWG", "Motorcycle with gear"),
        ("LMV", "Light Motor Vehicle"),
        ("HMV", "Heavy Motor Vehicle"),
    )
    
    reg_no = models.CharField(max_length=10, unique=True, primary_key=True)
    reg_date = models.DateTimeField(default=timezone.now)
    color = models.CharField(max_length=20)
    vehicle_type = models.CharField(max_length=5, choices=types)
    owner = models.ForeignKey(User, on_delete=models.CASCADE)
    
    def __str__(self):
        return f"{self.reg_no} - {self.owner}"
    
    
    class Meta:
        db_table = 'vehicles'
        verbose_name = 'vehicle'
        verbose_name_plural = 'vehicles'