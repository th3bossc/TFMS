from django.db import models
from django.db.models.query import QuerySet
from django.utils import timezone
from users.models import User
from datetime import timedelta

# Create your models here.
class FineClasses(models.Model):
    fine_id = models.AutoField(primary_key=True)
    fine_name = models.CharField(max_length=30)
    amount_percent = models.FloatField()
    description = models.CharField(max_length=100)
    
    def __str__(self):
        return self.fine_name
    
    class Meta:
        db_table = 'fine_classes'
        verbose_name = 'fine_class'
        verbose_name_plural = 'fine_classes'
    
    
class IssuedFines(models.Model):
    
    class FineObjects(models.Manager):
        def get_queryset(self) -> QuerySet:
            return super().get_queryset().filter(status='unpaid') | super().get_queryset().filter(status='overdue') 
    
    
    statuses = (
        ('unpaid', 'Unpaid'),
        ('paid', 'Paid'),
        ('overdue', 'Overdue'),
    )    
        
        
    issue_id = models.AutoField(primary_key=True)
    date_issued = models.DateTimeField(default=timezone.now)
    issued_to = models.ForeignKey(User, on_delete=models.CASCADE)
    fine_type = models.ForeignKey(FineClasses, on_delete=models.CASCADE)
    status = models.CharField(max_length=10, choices=statuses, default='unpaid')
    deadline = models.DateTimeField()
    
    def save(self, *args, **kwargs):
        self.deadline = self.date_issued + timedelta(days=30)
        super().save(*args, **kwargs)
        
    def update(self, *args, **kwargs):
        super().save(*args, **kwargs)
    
    @property
    def fine_amount(self):
        return (self.fine_type.amount_percent / 100) * (self.issued_to.salary)

    
    def __str__(self):
        return self.fine_type.fine_name + ' to ' + self.issued_to.aadhar_no
    
    objects = models.Manager()
    unpaid = FineObjects()
    
    
    class Meta:
        db_table = 'issued_fines'
        verbose_name = 'issued_fine'
        verbose_name_plural = 'issued_fines'
        


class Transactions(models.Model):
    methods = (
        ("card", "Debit / Credit card"),
        ("upi", "UPI"),
        ("netbanking", "Netbanking"),
        ("NEFT", "NEFT"),
    )
        
    transaction_id = models.AutoField(primary_key=True)
    date_paid = models.DateTimeField(default=timezone.now)
    payment_method = models.CharField(max_length=30, choices=methods)
    issued_fine = models.ForeignKey(IssuedFines, on_delete=models.PROTECT)
    paid_by = models.ForeignKey(User, on_delete=models.PROTECT, null=True)

    @property
    def amount(self):
        return self.issued_fine.fine_amount
    
    
    def __str__(self):
        return self.paid_by.aadhar_no + ' paid ' + str(self.amount) + ' for ' + self.issued_fine.fine_type.fine_name
    
    def save(self, *args, **kwargs):
        self.paid_by = self.issued_fine.issued_to
        self.issued_fine.status = 'paid'
        self.issued_fine.save()
        super().save(*args, **kwargs)
        
        
    class Meta:
        db_table = 'transactions'
        verbose_name = 'transaction'
        verbose_name_plural = 'transactions'