# Generated by Django 5.0.4 on 2024-06-24 06:04

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('drf', '0022_remove_wakturute_halte_remove_wakturute_waktu_1_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='waktu',
            name='rute_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='list_waktu', to='drf.wakturute'),
        ),
        migrations.AlterField(
            model_name='wakturute',
            name='rute',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='drf.busroute'),
        ),
    ]
