from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from .serializers import UserSerializer, VehicleSerializer
from .models import User, Vehicles
from rest_framework import status
# Create your views here.


class ProfileInfo(APIView):
    permission_classes = [IsAuthenticated]
    def get(self, request):
        user = request.user
        serializer = UserSerializer(user)
        return Response(serializer.data)
    
    def post(self, request):
        user = request.user 
        
        serializer = UserSerializer(user, data=request.data)
        
        if (serializer.is_valid()):
            updated_user = serializer.save()
            if updated_user:
                return Response(status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        
