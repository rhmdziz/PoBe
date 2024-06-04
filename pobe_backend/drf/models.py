from django.db import models

# Create your models here.
operational_hour_list = [
        ('08:00 - 16:00 WIB','08:00 - 16:00 WIB'),
        ('08:00 - 22:00 WIB','08:00 - 22:00 WIB'),
        ('09:00 - 16:00 WIB','09:00 - 16:00 WIB'),
        ('09:00 - 22:00 WIB','09:00 - 22:00 WIB'),
        ('10:00 - 22:00 WIB','10:00 - 22:00 WIB'),
        ('13:00 - 22:00 WIB','13:00 - 22:00 WIB'),
        ('24 Hour','24 Hour'),
    ]
operational_day_list = [
        ('Senin - Minggu','Senin - Minggu'),
        ('Senin - Jumat','Senin - Jumat'),
        ('Sabtu - Minggu','Sabtu - Minggu'),
    ]
min_price_list = [
        ('Rp20.000,-', 'Rp20.000,-'),
        ('Rp50.000,-', 'Rp50.000,-'),
        ('Rp75.000,-', 'Rp75.000,-'),
        ('Rp100.000,-', 'Rp100.000,-'),
    ]
max_price_list = [
        ('Rp100.000,-', 'Rp100.000,-'),
        ('Rp200.000,-', 'Rp200.000,-'),
        ('Rp500.000,-', 'Rp500.000,-'),
        ('Rp750.000,-', 'Rp750.000,-'),
        ('Rp1000.000,-', 'Rp1000.000,-'),
    ]

class Food(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=40)
    desc = models.CharField(max_length=300)
    location = models.CharField(max_length=100)
    operational_hour = models.CharField(max_length=40, choices=operational_hour_list, default='08:00 - 22:00 WIB')
    operational_day = models.CharField(max_length=40, choices=operational_day_list, default='Senin - Minggu')
    phone = models.CharField(max_length=20)
    min_price = models.CharField(max_length=20, choices=min_price_list)
    max_price = models.CharField(max_length=20, choices=max_price_list)
    rating = models.CharField(max_length=4)
    review = models.CharField(max_length=6)
    image = models.ImageField(blank=True)

    def __str__(self):
        return self.name
class Entertain(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=40)
    desc = models.CharField(max_length=300)
    location = models.CharField(max_length=100)
    operational_hour = models.CharField(max_length=40, choices=operational_hour_list, default='08:00 - 22:00 WIB')
    operational_day = models.CharField(max_length=40, choices=operational_day_list, default='Senin - Minggu')
    phone = models.CharField(max_length=20)
    min_price = models.CharField(max_length=20, choices=min_price_list)
    max_price = models.CharField(max_length=20, choices=max_price_list)
    rating = models.CharField(max_length=4)
    review = models.CharField(max_length=6)
    image = models.ImageField(blank=True)

    def __str__(self):
        return self.name
class Sport(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=40)
    desc = models.CharField(max_length=300)
    location = models.CharField(max_length=100)
    operational_hour = models.CharField(max_length=40, choices=operational_hour_list, default='08:00 - 22:00 WIB')
    operational_day = models.CharField(max_length=40, choices=operational_day_list, default='Senin - Minggu')
    phone = models.CharField(max_length=20)
    min_price = models.CharField(max_length=20, choices=min_price_list)
    max_price = models.CharField(max_length=20, choices=max_price_list)
    rating = models.CharField(max_length=4)
    review = models.CharField(max_length=6)
    image = models.ImageField(blank=True)

    def __str__(self):
        return self.name
    
class Hospital(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=40)
    desc = models.CharField(max_length=300)
    location = models.CharField(max_length=100)
    operational_hour = models.CharField(max_length=40, choices=operational_hour_list, default='08:00 - 22:00 WIB')
    operational_day = models.CharField(max_length=40, choices=operational_day_list, default='Senin - Minggu')
    phone = models.CharField(max_length=20)
    min_price = models.CharField(max_length=20, choices=min_price_list)
    max_price = models.CharField(max_length=20, choices=max_price_list)
    rating = models.CharField(max_length=4)
    review = models.CharField(max_length=6)
    image = models.ImageField(blank=True)

    def __str__(self):
        return self.name
    
class Mall(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=40)
    desc = models.CharField(max_length=300)
    location = models.CharField(max_length=100)
    operational_hour = models.CharField(max_length=40, choices=operational_hour_list, default='08:00 - 22:00 WIB')
    operational_day = models.CharField(max_length=40, choices=operational_day_list, default='Senin - Minggu')
    phone = models.CharField(max_length=20)
    min_price = models.CharField(max_length=20, choices=min_price_list)
    max_price = models.CharField(max_length=20, choices=max_price_list)
    rating = models.CharField(max_length=4)
    review = models.CharField(max_length=6)
    image = models.ImageField(blank=True)

    def __str__(self):
        return self.name
    
class Shopping(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=40)
    desc = models.CharField(max_length=300)
    location = models.CharField(max_length=100)
    operational_hour = models.CharField(max_length=40, choices=operational_hour_list, default='08:00 - 22:00 WIB')
    operational_day = models.CharField(max_length=40, choices=operational_day_list, default='Senin - Minggu')
    phone = models.CharField(max_length=20)
    min_price = models.CharField(max_length=20, choices=min_price_list)
    max_price = models.CharField(max_length=20, choices=max_price_list)
    rating = models.CharField(max_length=4)
    review = models.CharField(max_length=6)
    image = models.ImageField(blank=True)

    def __str__(self):
        return self.name
    

# NEWSS
class News(models.Model):
    id = models.AutoField(primary_key=True)
    datetime = models.DateTimeField(auto_now=True)
    author = models.CharField(max_length=40, default='Azhira')
    content = models.CharField(max_length=3000)
    title = models.CharField(max_length=100, default='Title')
    views = models.CharField(max_length=10, default=0)
    up = models.CharField(max_length=10, default=0)
    image = models.ImageField(blank=True)

    def __str__(self):
        return self.name

class CommentNews(models.Model):
    id = models.AutoField(primary_key=True)
    news_id = models.ForeignKey(News, on_delete=models.CASCADE)
    datetime = models.DateTimeField(auto_now=True)
    content = models.CharField(max_length=200)
    avatar = models.ImageField(blank=True)
