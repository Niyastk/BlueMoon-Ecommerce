# Generated by Django 3.2.8 on 2021-12-05 11:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0005_account_wallet'),
    ]

    operations = [
        migrations.AlterField(
            model_name='account',
            name='wallet',
            field=models.IntegerField(blank=True, default=0, null=True),
        ),
    ]
