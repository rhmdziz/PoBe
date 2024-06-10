from django.urls import path

app_name = 'drf'

from django.urls import path
from .views import UserCreate, ProfileUpdate, Login

urlpatterns = [
    path('signup/', UserCreate.as_view(), name='signup'),
    path('login/', Login.as_view(), name='login'),
    path('profile/', ProfileUpdate.as_view(), name='profile'),
]