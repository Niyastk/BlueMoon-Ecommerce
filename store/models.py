from django.db import models
from accounts.models import Account
from adminBluemoon.models import Offer
from category.models import SubCategory

# Create your models here.


class Products(models.Model):

    product_name = models.CharField(max_length=200)
    slug = models.CharField(max_length=250)
    description = models.TextField(blank=True)
    mrp = models.FloatField()
    sale_price = models.FloatField()
    image = models.ImageField(upload_to='photos/products')
    stock = models.IntegerField()
    size = models.CharField(max_length=20, blank=True)
    size_s = models.BooleanField(blank=True, null=True, default=False)
    size_m = models.BooleanField(blank=True, null=True, default=False)
    size_l = models.BooleanField(blank=True, null=True, default=False)
    size_xl = models.BooleanField(blank=True, null=True, default=False)
    is_available = models.BooleanField(default=True)
    category = models.ForeignKey(SubCategory, on_delete=models.CASCADE)
    created_date = models.DateTimeField(auto_now_add=True)
    modified_date = models.DateTimeField(auto_now_add=True)
    product_offer = models.ForeignKey(
        Offer, null=True, blank=True, on_delete=models.SET_NULL)
    offer_type = models.CharField(max_length=200, null=True)
    product_offer_price = models.IntegerField(null=True)

    def __str__(self):
        return self.product_name


class ProductImages(models.Model):
    product = models.ForeignKey(
        Products, default=None, on_delete=models.CASCADE)
    image = models.ImageField(upload_to='store/products')

    def __str__(self):
        return self.product.product_name


class Wishlist(models.Model):
    wishlist_id = models.CharField(max_length=250, blank=True, null=True)
    user = models.ForeignKey(
        Account, on_delete=models.CASCADE, null=True, blank=True)
    date_added = models.DateTimeField(auto_now_add=True)

    # def __str__(self):
    #     return self.user


class WishListItem(models.Model):
    product = models.ForeignKey(Products, on_delete=models.CASCADE)
    wishlist = models.ForeignKey(Wishlist, on_delete=models.CASCADE)
    quantity = models.IntegerField()
    is_active = models.BooleanField(default=True)
    variation = models.CharField(max_length=6, blank=True, default="size_m")

    def sub_total(self):
        if self.product.product_offer:

            return self.product.product_offer_price * self.quantity
        else:
            return self.product.sale_price * self.quantity


class Coupon(models.Model):
    coupon_code = models.UUIDField()
    minimum_rate = models.IntegerField()
    percentage = models.PositiveIntegerField()
    expiry_date = models.DateField()
    expiry_time = models.TimeField()


class UsedCoupon(models.Model):
    user = models.ForeignKey(Account, on_delete=models.CASCADE)
    coupon_code = models.CharField(max_length=100)


class Banner(models.Model):
    banner_image = models.ImageField(upload_to='photos/banners')
    tag_line = models.CharField(max_length=250, blank=True, null=True)
    heading = models.CharField(max_length=250, blank=True, null=True)
    offer_percentage = models.CharField(max_length=250, blank=True, null=True)
    starting_price = models.IntegerField(blank=True, null=True)
    button_url = models.CharField(max_length=250, blank=True, null=True)
