from django.contrib import admin
from django.urls import path
from .views import ProfileInfo

app_name = 'users'
urlpatterns = [
    path('profile/', ProfileInfo.as_view(), name='profile'),
]
