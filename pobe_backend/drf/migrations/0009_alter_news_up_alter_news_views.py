# Generated by Django 5.0.4 on 2024-06-04 05:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('drf', '0008_alter_news_content'),
    ]

    operations = [
        migrations.AlterField(
            model_name='news',
            name='up',
            field=models.CharField(default=0, max_length=10),
        ),
        migrations.AlterField(
            model_name='news',
            name='views',
            field=models.CharField(default=0, max_length=10),
        ),
    ]
