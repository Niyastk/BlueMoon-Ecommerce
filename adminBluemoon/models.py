from django.db import models

# Create your models here.


class Offer(models.Model):
    offer_name = models.CharField(max_length=150, unique=True)
    percentage = models.FloatField()
    expiry_date = models.DateField()
    expiry_time = models.TimeField()
