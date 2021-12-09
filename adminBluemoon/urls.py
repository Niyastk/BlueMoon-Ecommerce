
from os import name
from django.urls.conf import path
from . import views

urlpatterns = [
    path('', views.adminLogin, name='adminLogin'),
    path('adminPanel/', views.adminPanel, name='adminPanel'),
    path('adminLogout/', views.adminLogout, name='adminLogout'),
    path('customerList/', views.customerList, name='customerList'),
    path('activeStatus/<int:status_id>',
         views.activeStatus, name='activeStatus'),
    path('orderList/', views.orderList, name="orderList"),
    #     path('offerList/', views.offerList, name="offerList"),
    path('offerAdd/', views.offerAdd, name="offerAdd"),
    path('offerEdit/<int:offer_id>', views.offerEdit, name="offerEdit"),
    path('offerDelete/<int:offer_id>', views.offerDelete, name="offerDelete"),
    path('orderDetails/<order_number>', views.orderDetails, name="orderDetails"),
    path('AdminOrderStatus/<order_number>',
         views.AdminOrderStatus, name="AdminOrderStatus"),
    path('dailySales/', views.dailySales, name='dailySales'),
    path('weeklySales/', views.weeklySales, name='weeklySales'),
    path('yearlySales/', views.yearlySales, name='yearlySales'),
    path('couponList/', views.couponList, name='couponList'),
    path('couponEdit/<int:coupon_id>', views.couponEdit, name="couponEdit"),
    path('couponDelete/<int:coupon_id>',
         views.couponDelete, name="couponDelete"),
    path('bannerEdit/', views.bannerEdit, name='bannerEdit'),
    path('OrderCancelReport/', views.OrderCancelReport, name='OrderCancelReport'),
]
