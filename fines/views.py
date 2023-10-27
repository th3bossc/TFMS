from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, SAFE_METHODS
from .models import IssuedFines, Transactions
from .serializers import IssuedFineSerializer, TransactionSerializer
from rest_framework.exceptions import PermissionDenied
# Create your views here.


class FinesView(APIView):
    permission_classes = [IsAuthenticated]
    def get(self, request):
        unpaidFines = IssuedFines.unpaid.filter(issued_to = request.user.aadhar_no)
        serializer = IssuedFineSerializer(unpaidFines, many=True)
        return Response(serializer.data)
    
    

class FinesDetailView(APIView):
    permission_classes = [IsAuthenticated]
    def get(self, request, pk):
        fine = IssuedFines.objects.get(issue_id = pk)
        
        if (fine.issued_to != request.user):
            raise PermissionDenied()
        
        serializer = IssuedFineSerializer(fine)
        return Response(serializer.data)

class TransactionsView(APIView):
    permission_classes = [IsAuthenticated]
    def get(self, request):
        transactions = Transactions.objects.filter(user = request.user.aadhar_no)
        serializer = TransactionSerializer(transactions, many=True)
        return Response(serializer.data)
    
    

class TransactionsDetailView(APIView):
    permission_classes = [IsAuthenticated]
    def get(self, request, pk):
        transaction = Transactions.objects.get(transaction_id = pk)
        
        if transaction.paid_by != request.user:
            raise PermissionDenied()
        
        serializer = TransactionSerializer(transaction)
        return Response(serializer.data)



