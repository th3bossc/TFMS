from rest_framework import serializers
from .models import IssuedFines, Transactions
from users.models import Vehicles
from users.serializers import VehicleSerializer
class IssuedFineSerializer(serializers.ModelSerializer):
    fine_name = serializers.CharField(source='fine_type.fine_name')
    vehicle_issued_to = serializers.SerializerMethodField()
    class Meta:
        model = IssuedFines
        fields = ('issue_id', 'date_issued', 'fine_name', 'vehicle_issued_to', 'status', 'deadline', 'fine_amount')
        
    def get_vehicle_issued_to(self, obj):
        if (obj.vehicle_issued_to is None):
            return None
        data = VehicleSerializer(obj.vehicle_issued_to).data
        return data
        
        
class TransactionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Transactions
        fields = ('transaction_id', 'date_paid', 'amount', 'payment_method')