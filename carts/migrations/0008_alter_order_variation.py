# Generated by Django 3.2.9 on 2021-11-23 12:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('carts', '0007_alter_order_variation'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='variation',
            field=models.CharField(blank=True, default='size_m', max_length=20, null=True),
        ),
    ]
