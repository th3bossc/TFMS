from django.contrib import admin
from users.models import User, Vehicles
from django.contrib.auth.admin import UserAdmin
from django.forms import TextInput, Textarea, CharField
from django import forms
from django.db import models
# Register your models here.


class UserAdminConfig(UserAdmin):
    model = User
    search_fields = ('aadhar_no', 'phone_no', 'email')
    list_filter = ('aadhar_no', 'phone_no', 'email', 'is_active', 'is_staff')
    ordering = ('-start_date',)
    list_display = ('aadhar_no', 'phone_no', 'license_no', 'first_name', 'last_name', 'email', 'is_active', 'is_staff')
    fieldsets = (
        (None, {'fields': ('aadhar_no', 'phone_no', 'license_no', 'first_name', 'last_name', 'email', 'salary', 'password')}),
        ('Permissions', {'fields': ('is_staff', 'is_active', 'user_permissions')},),
    )
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('aadhar_no', 'phone_no', 'license_no', 'first_name', 'last_name', 'email', 'salary', 'password1', 'password2', 'is_active', 'is_staff')}
        ),
    )
    
    
class VehicleAdminConfig(admin.ModelAdmin):
    model = Vehicles
    search_fields = ('reg_no', 'vehicle_type', 'color', 'vehicle_company', 'vehicle_model', 'owner')
    list_filter = ('reg_no', 'vehicle_type', 'color', 'vehicle_company', 'vehicle_model', 'owner')
    ordering = ('-reg_no',)
    list_display = ('reg_no', 'vehicle_type', 'color', 'vehicle_company', 'vehicle_model', 'owner')
    fieldsets = (
        (None, {'fields': ('reg_no', 'vehicle_type', 'color', 'vehicle_company', 'vehicle_model', 'owner')}),
    )
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('reg_no', 'vehicle_type', 'color', 'vehicle_company', 'vehicle_model', 'owner')}
        ),
    )
    
    
admin.site.register(User, UserAdminConfig)
admin.site.register(Vehicles, VehicleAdminConfig)
