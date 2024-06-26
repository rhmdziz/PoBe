# Generated by Django 5.0.4 on 2024-06-25 04:44

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('drf', '0033_time_remove_waktu_waktu_alter_waktu_waktu_list'),
    ]

    operations = [
        migrations.AddField(
            model_name='waktu',
            name='waktu_id',
            field=models.CharField(max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='waktu',
            name='waktu_list',
            field=models.ManyToManyField(related_name='waktu_list', to='drf.time'),
        ),
    ]
