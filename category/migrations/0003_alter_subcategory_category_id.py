# Generated by Django 3.2.9 on 2021-11-10 05:44

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('category', '0002_subcategory'),
    ]

    operations = [
        migrations.AlterField(
            model_name='subcategory',
            name='category_id',
            field=models.ForeignKey(blank=True, on_delete=django.db.models.deletion.CASCADE, to='category.category'),
        ),
    ]