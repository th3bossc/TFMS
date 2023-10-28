from rest_framework import serializers
from .models import User, Vehicles

class VehicleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Vehicles
        fields = ('reg_no', 'vehicle_type', 'color', 'vehicle_company', 'vehicle_model', 'owner')


class UserSerializer(serializers.ModelSerializer):
    vehicles = serializers.SerializerMethodField()
    class Meta:
        model = User
        fields = ('aadhar_no', 'phone_no', 'license_no', 'first_name', 'last_name', 'email', 'salary', 'vehicles')
        read_only_fields = ('aadhar_no', 'license_no', 'vehicles')
        
    def get_vehicles(self, obj):
        vehicles = Vehicles.objects.filter(owner=obj)
        data = VehicleSerializer(vehicles, many=True).data
        return data
 
