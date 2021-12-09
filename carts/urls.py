
from django.urls.conf import path
from . import views

urlpatterns = [
    path('', views.cart, name='cart'),
    path('add_cart/', views.add_cart, name='add_cart'),
    path('cart_increment/', views.cart_increment, name='cart_increment'),
    path('cart_decrement/', views.cart_decrement, name='cart_decrement'),
    path('input_cart/', views.input_cart, name='input_cart'),
    path('removeProduct/', views.removeProduct, name='removeProduct'),
    path('checkout/<checkout_identifier>', views.checkout, name='checkout'),
    path('razorpayPayment/<product_id>',
         views.razorpayPayment, name='razorpayPayment'),
    path('add_address/', views.add_address, name='add_address'),
    path('editAddress/<int:address_id>', views.editAddress, name='editAddress'),
    path('orderCancel/', views.orderCancel, name='orderCancel'),
    path('orderReturn/', views.orderReturn, name='orderReturn'),
    path('deleteAddress/',
         views.deleteAddress, name='deleteAddress'),
    path('couponApply/',
         views.couponApply, name='couponApply'),

]
