
from django.urls.conf import path
from . import views

urlpatterns = [
    path('signUp/', views.signUp, name='signUp'),
    path('signIn/', views.signIn, name='signIn'),
    path('signOut/', views.signOut, name='signOut'),
    path('otpLogin/', views.otpLogin, name='otpLogin'),
    path('userDashboard/', views.userDashboard, name='userDashboard'),
    path('userOrderDetails/<str:order_number>',
         views.userOrderDetails, name='userOrderDetails'),
    path('submitOtp/<str:phone_number>', views.submitOtp, name='submitOtp'),
    path('userDetailsEdit/', views.userDetailsEdit, name='userDetailsEdit'),
    path('userPasswordChange/', views.userPasswordChange,
         name='userPasswordChange'),

]
