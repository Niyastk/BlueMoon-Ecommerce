# Generated by Django 3.2.8 on 2021-11-20 05:05

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('carts', '0003_order'),
    ]

    operations = [
        migrations.AddField(
            model_name='order',
            name='order_status',
            field=models.CharField(default='Order Placed', max_length=50),
        ),
    ]
