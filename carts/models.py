from django.db import models
from accounts.models import Account, UserAddress

from store.models import Products

# Create your models here.


class Carts(models.Model):
    cart_id = models.CharField(max_length=250, blank=True)
    user = models.ForeignKey(Account, on_delete=models.CASCADE, blank=True)
    date_added = models.DateTimeField(auto_now_add=True)

    # def __str__(self):
    #     return self.user


class CartItem(models.Model):
    product = models.ForeignKey(Products, on_delete=models.CASCADE)
    cart = models.ForeignKey(Carts, on_delete=models.CASCADE)
    quantity = models.IntegerField()
    is_active = models.BooleanField(default=True)
    variation = models.CharField(max_length=6, blank=True, default="size_m")

    def sub_total(self):
        if self.product.product_offer:

            return self.product.product_offer_price * self.quantity
        else:
            return self.product.sale_price * self.quantity

    # def __str__(self):
    #     return self.product


class Order(models.Model):
    user = models.ForeignKey(Account, on_delete=models.CASCADE, null=True)
    product = models.ForeignKey(Products, on_delete=models.SET_NULL, null=True)
    address = models.CharField(max_length=2500)
    payment_method = models.CharField(max_length=250)
    total = models.PositiveIntegerField(null=True, blank=True)
    date = models.DateTimeField(auto_now_add=True)
    order_number = models.CharField(max_length=250)
    order_status = models.CharField(max_length=50, default="Order Placed")
    sub_total = models.PositiveIntegerField(blank=True, null=True)
    quantity = models.PositiveIntegerField(blank=True, null=True)
    variation = models.CharField(
        max_length=20, blank=True, default="size_m")
