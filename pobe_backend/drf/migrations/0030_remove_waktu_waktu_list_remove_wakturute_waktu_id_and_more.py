# Generated by Django 5.0.4 on 2024-06-25 04:17

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('drf', '0029_waktu_wakturute_waktu_id'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='waktu',
            name='waktu_list',
        ),
        migrations.RemoveField(
            model_name='wakturute',
            name='waktu_id',
        ),
        migrations.DeleteModel(
            name='Time',
        ),
        migrations.DeleteModel(
            name='Waktu',
        ),
    ]
