from django.contrib import admin
from drf import models
# Register your models here.
admin.site.register(models.Food)
admin.site.register(models.Entertain)
admin.site.register(models.Sport)
admin.site.register(models.Hospital)
admin.site.register(models.Mall)
admin.site.register(models.Shopping)

admin.site.register(models.News)
admin.site.register(models.CommentNews)