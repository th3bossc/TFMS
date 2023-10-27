from rest_framework import serializers
from .models import IssuedFines, Transactions


class IssuedFineSerializer(serializers.ModelSerializer):
    fine_name = serializers.CharField(source='fine_type.fine_name')
    class Meta:
        model = IssuedFines
        fields = ('issue_id', 'date_issued', 'fine_name', 'status', 'deadline', 'fine_amount')
        
        
class TransactionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Transactions
        fields = ('transaction_id', 'date_paid', 'amount', 'fine_type.fine_name', 'payment_method')