# Generated by Django 5.0.4 on 2024-06-21 12:50

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('drf', '0014_alter_news_content'),
    ]

    operations = [
        migrations.CreateModel(
            name='BusRoute',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nama_rute', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='Halte',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nama_halte', models.CharField(max_length=100, unique=True)),
            ],
        ),
        migrations.CreateModel(
            name='BusSchedule',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nomor_bis', models.IntegerField()),
                ('waktu_1', models.TimeField(blank=True, null=True)),
                ('waktu_2', models.TimeField(blank=True, null=True)),
                ('waktu_3', models.TimeField(blank=True, null=True)),
                ('waktu_4', models.TimeField(blank=True, null=True)),
                ('waktu_5', models.TimeField(blank=True, null=True)),
                ('waktu_6', models.TimeField(blank=True, null=True)),
                ('waktu_7', models.TimeField(blank=True, null=True)),
                ('rute', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='jadwal', to='drf.busroute')),
                ('halte', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='drf.halte')),
            ],
            options={
                'ordering': ['nomor_bis'],
            },
        ),
    ]
