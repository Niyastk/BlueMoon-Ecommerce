# Generated by Django 3.2.8 on 2021-12-05 11:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0004_account_referral_code'),
    ]

    operations = [
        migrations.AddField(
            model_name='account',
            name='wallet',
            field=models.IntegerField(blank=True, null=True),
        ),
    ]
