from django.contrib import admin
from django.contrib.admin import ModelAdmin
from .models import FineClasses, IssuedFines, Transactions
# Register your models here.

class FineClassesAdminConfig(ModelAdmin):
    model = FineClasses
    search_fields = ('fine_name',)
    list_filter = ('fine_name',)
    ordering = ('fine_name', '-amount_percent')
    list_display = ('fine_name', 'amount_percent', 'description')
    fieldsets = (
        (None, {'fields': ('fine_name', 'amount_percent', 'description')}),
    )
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('fine_name', 'amount_percent', 'description')}
        ),
    )
    
    
class IssuedFinesAdminConfig(ModelAdmin):
    model = IssuedFines
    search_fields = ('issued_to', 'fine_type')
    list_filter = ('issued_to', 'fine_type', 'status')
    ordering = ('issued_to', '-date_issued')
    list_display = ('issued_to', 'fine_type', 'fine_amount', 'status')
    fieldsets = (
        (None, {'fields': ('issued_to', 'fine_type', 'status')}),
    )
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('issued_to', 'fine_type', 'status')}
        ),
    )
    

class TransactionAdminConfig(ModelAdmin):
    model = Transactions
    search_fields = ('issued_fine', 'paid_by')
    list_filter = ('issued_fine',)
    ordering = ('issued_fine', '-date_paid')
    list_display = ('issued_fine', 'paid_by', 'amount', 'payment_method')
    fieldsets = (
        (None, {'fields': ('issued_fine', 'payment_method')}),
    )
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('issued_fine', 'payment_method')}
        ),
    )
    
admin.site.register(FineClasses, FineClassesAdminConfig)
admin.site.register(IssuedFines, IssuedFinesAdminConfig)
admin.site.register(Transactions, TransactionAdminConfig)