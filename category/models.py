from django.db import models
from django.db.models.deletion import SET_NULL
from django.urls import reverse
from adminBluemoon.models import Offer

# Create your models here.


class Category(models.Model):
    category_name = models.CharField(max_length=100)
    slug = models.CharField(max_length=100, unique=True)
    descrption = models.TextField(blank=True)
    category_image = models.ImageField(
        upload_to='photos/categories', blank=True)


class SubCategory(models.Model):
    category_name = models.CharField(max_length=100)
    category_id = models.ForeignKey(
        Category, on_delete=models.CASCADE, blank=True)
    slug = models.CharField(max_length=100, unique=True)
    descrption = models.TextField(blank=True)
    category_image = models.ImageField(
        upload_to='photos/categories', blank=True)
    subcategory_offer = models.ForeignKey(
        Offer, null=True, blank=True, on_delete=models.SET_NULL)

    def get_url(self):
        return reverse('products_by_category', args=[self.slug])

    def __str__(self):
        return self.category_name
