from rest_framework import serializers
from .models import IssuedFines, Transactions
from users.models import Vehicles
from users.serializers import VehicleSerializer
class IssuedFineSerializer(serializers.ModelSerializer):
    fine_name = serializers.CharField(source='fine_type.fine_name')
    fine_desc = serializers.CharField(source='fine_type.description')
    vehicle_issued_to = serializers.SerializerMethodField()
    class Meta:
        model = IssuedFines
        fields = ('issue_id', 'date_issued', 'fine_name', 'fine_desc', 'vehicle_issued_to', 'status', 'deadline', 'fine_amount')
        
    def get_vehicle_issued_to(self, obj):
        if (obj.vehicle_issued_to is None):
            return None
        data = VehicleSerializer(obj.vehicle_issued_to).data
        return data
        
        
    class TransactionSerializer(serializers.ModelSerializer):
        fine_type = serializers.CharField(source='issued_fine.fine_type.fine_name')
        class Meta:
            model = Transactions
            fields = ('transaction_id', 'date_paid', 'amount', 'fine_type', 'payment_method')