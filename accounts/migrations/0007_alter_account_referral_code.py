# Generated by Django 3.2.8 on 2021-12-05 11:56

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0006_alter_account_wallet'),
    ]

    operations = [
        migrations.AlterField(
            model_name='account',
            name='referral_code',
            field=models.CharField(blank=True, max_length=50, null=True),
        ),
    ]
