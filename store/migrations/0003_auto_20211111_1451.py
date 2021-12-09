# Generated by Django 3.2.9 on 2021-11-11 09:21

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('store', '0002_auto_20211110_1725'),
    ]

    operations = [
        migrations.CreateModel(
            name='ProductImages',
            fields=[
                ('id', models.BigAutoField(auto_created=True,
                 primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(upload_to='store/products')),
                ('product', models.ForeignKey(
                    default=None, on_delete=django.db.models.deletion.CASCADE, to='store.products')),
            ],
        ),
    ]
