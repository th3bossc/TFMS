from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, SAFE_METHODS
from .models import IssuedFines, Transactions
from .serializers import IssuedFineSerializer, TransactionSerializer
from rest_framework.exceptions import PermissionDenied, NotFound
from datetime import timedelta
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
        try:
            fine = IssuedFines.objects.get(issue_id = pk)
        except:
            raise NotFound()
        
        if (fine.issued_to != request.user):
            raise PermissionDenied()
        
        serializer = IssuedFineSerializer(fine)
        return Response(serializer.data)

class TransactionsView(APIView):
    permission_classes = [IsAuthenticated]
    def get(self, request):
        transactions = Transactions.objects.filter(paid_by = request.user.aadhar_no)
        serializer = TransactionSerializer(transactions, many=True)
        return Response(serializer.data)
    
    

class TransactionsDetailView(APIView):
    permission_classes = [IsAuthenticated]
    def get(self, request, pk):
        try:
            transaction = Transactions.objects.get(transaction_id = pk)
        except:
            raise NotFound()
        
        if transaction.paid_by != request.user: 
            raise PermissionDenied()
        
        serializer = TransactionSerializer(transaction)
        return Response(serializer.data)



class FineMethods(APIView):
    permission_classes = [IsAuthenticated]
    def get(self, request, pk):
        try:
            fine = IssuedFines.objects.get(issue_id = pk)
        except:
            raise NotFound()
        
        if fine.issued_to != request.user or fine.status == 'paid':
            raise PermissionDenied()
        
        fine.status = 'paid'
        fine.update()
        
        return Response({'message': 'Fine paid successfully'})
        
    def post(self, request, pk):
        # {
        #     'extension': days,
        #     'reason' : reason
        # }
        
        if (request.data.get('extension') is None or request.data.get('reason') is None):
            return Response({
                'extension' : 'This field is required',
                'reason' : 'This field is required'
            })

        
        try:
            fine = IssuedFines.objects.get(issue_id = pk)
        except:
            raise NotFound()
        if fine.issued_to != request.user or fine.status != 'overdue':
            raise PermissionDenied()
        
        fine.deadline = fine.deadline + timedelta(days=request.data['extension'])
        fine.status = 'unpaid'
        fine.update()
        
        
        return Response({'message': 'Fine extended successfully'})
        