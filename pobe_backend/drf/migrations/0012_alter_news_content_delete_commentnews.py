# Generated by Django 5.0.4 on 2024-06-21 10:29

import ckeditor.fields
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('drf', '0011_entertain_latitude_entertain_longitude_food_latitude_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='news',
            name='content',
            field=ckeditor.fields.RichTextField(max_length=4000),
        ),
        migrations.DeleteModel(
            name='CommentNews',
        ),
    ]
