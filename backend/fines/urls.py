from django.contrib import admin
from django.urls import path
from .views import FinesView, FinesDetailView, TransactionsView, TransactionsDetailView, FineMethods


app_name = 'fines'
urlpatterns = [
    path('', FinesView.as_view(), name='fines'),
    path('<int:pk>', FinesDetailView.as_view(), name='fines_detail'),
    path('transactions/', TransactionsView.as_view(), name='transactions'),
    path('transactions/<int:pk>', TransactionsDetailView.as_view(), name='transactions_detail'),
    path('update/<int:pk>', FineMethods.as_view(), name='pay_or_extend_fine'),
]
