# Generated by Django 3.2.8 on 2021-11-20 17:44

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('store', '0006_auto_20211116_1940'),
    ]

    operations = [
        migrations.AddField(
            model_name='products',
            name='size_l',
            field=models.BooleanField(blank=True, default=False, null=True),
        ),
        migrations.AddField(
            model_name='products',
            name='size_m',
            field=models.BooleanField(blank=True, default=False, null=True),
        ),
        migrations.AddField(
            model_name='products',
            name='size_s',
            field=models.BooleanField(blank=True, default=False, null=True),
        ),
        migrations.AddField(
            model_name='products',
            name='size_xl',
            field=models.BooleanField(blank=True, default=False, null=True),
        ),
    ]
