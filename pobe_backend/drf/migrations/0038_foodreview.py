# Generated by Django 5.0.4 on 2024-06-29 09:54

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('drf', '0037_delete_foodreview'),
    ]

    operations = [
        migrations.CreateModel(
            name='FoodReview',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('rating', models.CharField(choices=[('1', '1'), ('2', '2'), ('3', '3'), ('4', '4'), ('5', '5')], max_length=4)),
                ('name', models.CharField(default='user', max_length=40)),
                ('review', models.CharField(max_length=400)),
                ('foodId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='foodreview', to='drf.food')),
            ],
        ),
    ]