# Generated by Django 5.0.4 on 2024-06-22 12:20

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('drf', '0017_report'),
    ]

    operations = [
        migrations.AddField(
            model_name='news',
            name='category',
            field=models.CharField(blank=True, max_length=40, null=True),
        ),
    ]