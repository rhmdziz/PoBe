from django.db import models
from django_ckeditor_5.fields import CKEditor5Field

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
rating_list = [
    ('1','1'),
    ('2','2'),
    ('3','3'),
    ('4','4'),
    ('5','5'),
]
price_list = [
    ('1','1'),
    ('2','2'),
    ('3','3'),
    ('4','4'),
    ('5','5'),
]

class Food(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=40)
    desc = models.CharField(max_length=500)
    location = models.CharField(max_length=100)
    operational_hour = models.CharField(max_length=40, choices=operational_hour_list, default='08:00 - 22:00 WIB')
    operational_day = models.CharField(max_length=40, choices=operational_day_list, default='Senin - Minggu')
    phone = models.CharField(max_length=20)
    min_price = models.CharField(max_length=20, choices=min_price_list)
    max_price = models.CharField(max_length=20, choices=max_price_list)
    rating = models.CharField(max_length=4, choices=rating_list)
    price = models.CharField(max_length=4, choices=price_list, default=2)
    review = models.CharField(max_length=6)
    image = models.ImageField(blank=True)
    latitude = models.FloatField(blank=True, default=-6.300136)
    longitude = models.FloatField(blank=True, default=106.639061)

    def __str__(self):
        return self.name
class Entertain(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=40)
    desc = models.CharField(max_length=500)
    location = models.CharField(max_length=100)
    operational_hour = models.CharField(max_length=40, choices=operational_hour_list, default='08:00 - 22:00 WIB')
    operational_day = models.CharField(max_length=40, choices=operational_day_list, default='Senin - Minggu')
    phone = models.CharField(max_length=20)
    min_price = models.CharField(max_length=20, choices=min_price_list)
    max_price = models.CharField(max_length=20, choices=max_price_list)
    rating = models.CharField(max_length=4, choices=rating_list)
    price = models.CharField(max_length=4, choices=price_list, default=2)
    review = models.CharField(max_length=6)
    image = models.ImageField(blank=True)
    latitude = models.FloatField(blank=True, default=-6.300136)
    longitude = models.FloatField(blank=True, default=106.639061)

    def __str__(self):
        return self.name
class Sport(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=40)
    desc = models.CharField(max_length=500)
    location = models.CharField(max_length=100)
    operational_hour = models.CharField(max_length=40, choices=operational_hour_list, default='08:00 - 22:00 WIB')
    operational_day = models.CharField(max_length=40, choices=operational_day_list, default='Senin - Minggu')
    phone = models.CharField(max_length=20)
    min_price = models.CharField(max_length=20, choices=min_price_list)
    max_price = models.CharField(max_length=20, choices=max_price_list)
    rating = models.CharField(max_length=4, choices=rating_list)
    price = models.CharField(max_length=4, choices=price_list, default=2)
    review = models.CharField(max_length=6)
    image = models.ImageField(blank=True)
    latitude = models.FloatField(blank=True, default=-6.300136)
    longitude = models.FloatField(blank=True, default=106.639061)

    def __str__(self):
        return self.name
    
class Hospital(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=40)
    desc = models.CharField(max_length=500)
    location = models.CharField(max_length=100)
    operational_hour = models.CharField(max_length=40, choices=operational_hour_list, default='08:00 - 22:00 WIB')
    operational_day = models.CharField(max_length=40, choices=operational_day_list, default='Senin - Minggu')
    phone = models.CharField(max_length=20)
    min_price = models.CharField(max_length=20, choices=min_price_list)
    max_price = models.CharField(max_length=20, choices=max_price_list)
    rating = models.CharField(max_length=4, choices=rating_list)
    price = models.CharField(max_length=4, choices=price_list, default=2)
    review = models.CharField(max_length=6)
    image = models.ImageField(blank=True)
    latitude = models.FloatField(blank=True, default=-6.300136)
    longitude = models.FloatField(blank=True, default=106.639061)

    def __str__(self):
        return self.name
    
class Mall(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=40)
    desc = models.CharField(max_length=500)
    location = models.CharField(max_length=100)
    operational_hour = models.CharField(max_length=40, choices=operational_hour_list, default='08:00 - 22:00 WIB')
    operational_day = models.CharField(max_length=40, choices=operational_day_list, default='Senin - Minggu')
    phone = models.CharField(max_length=20)
    min_price = models.CharField(max_length=20, choices=min_price_list)
    max_price = models.CharField(max_length=20, choices=max_price_list)
    rating = models.CharField(max_length=4, choices=rating_list)
    price = models.CharField(max_length=4, choices=price_list, default=2)
    review = models.CharField(max_length=6)
    image = models.ImageField(blank=True)
    latitude = models.FloatField(blank=True, default=-6.300136)
    longitude = models.FloatField(blank=True, default=106.639061)
    

    def __str__(self):
        return self.name
    
class Shopping(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=40)
    desc = models.CharField(max_length=500)
    location = models.CharField(max_length=100)
    operational_hour = models.CharField(max_length=40, choices=operational_hour_list, default='08:00 - 22:00 WIB')
    operational_day = models.CharField(max_length=40, choices=operational_day_list, default='Senin - Minggu')
    phone = models.CharField(max_length=20)
    min_price = models.CharField(max_length=20, choices=min_price_list)
    max_price = models.CharField(max_length=20, choices=max_price_list)
    rating = models.CharField(max_length=4, choices=rating_list)
    price = models.CharField(max_length=4, choices=price_list, default=2)
    review = models.CharField(max_length=6)
    image = models.ImageField(blank=True)
    latitude = models.FloatField(blank=True, default=-6.300136)
    longitude = models.FloatField(blank=True, default=106.639061)

    def __str__(self):
        return self.name
    

news_category_list = [
    ('Umum', 'Umum'),
    ('Lifestyle', 'Lifestyle'),
    ('Sport', 'Sport'),
    ('Politic', 'Politic'),
    ('Health', 'Health'),
]

# NEWSS
class News(models.Model):
    id = models.AutoField(primary_key=True)
    datetime = models.DateTimeField(auto_now=True)
    author = models.CharField(max_length=40, default='Azhira')
    content = CKEditor5Field('Content', config_name='extends')
    title = models.CharField(max_length=100, default='Title')
    category = models.CharField(max_length=40, blank=True, null=True, choices=news_category_list)
    views = models.CharField(max_length=10, default=0)
    up = models.CharField(max_length=10, default=0)
    image = models.ImageField(blank=True)

    def __str__(self):
        return self.title

class Report(models.Model):
    id = models.AutoField(primary_key=True)
    datetime = models.DateTimeField(auto_now=True)
    author = models.CharField(max_length=40, default='user')
    title = models.CharField(max_length=100)
    content = models.CharField(max_length=4000)
    image = models.ImageField(blank=True)

    def __str__(self):
        return f'{self.title} (Report)'


# halte_list_bus_1 = [
#     ('Intermoda', 'Intermoda'),
#     ('Cosmo', 'Cosmo'),
#     ('Verdant View', 'Verdant View'),
#     ('Eternity', 'Eternity'),
#     ('Simplicity 2', 'Simplicity 2'),
#     ('Edutown 1', 'Edutown 1'),
#     ('Edutown 2', 'Edutown 2'),
#     ('ICE 1', 'ICE 1'),
#     ('ICE 2', 'ICE 2'),
#     ('ICE 6', 'ICE 6'),
#     ('ICE 5', 'ICE 5'),
#     ('GOP 1', 'GOP 1'),
#     ('SML Plaza', 'SML Plaza'),
#     ('The Breeze', 'The Breeze'),
#     ('CBD Timur 1', 'CBD Timur 1'),
#     ('CBD Timur 2', 'CBD Timur 2'),
#     ('Nava Park 1', 'Nava Park 1'),
#     ('SWA 1', 'SWA 1'),
#     ('Giant', 'Giant'),
#     ('Eka Hospital 1', 'Eka Hospital 1'),
#     ('Puspita Loka', 'Puspita Loka'),
#     ('Polsek Serpong', 'Polsek Serpong'),
#     ('Ruko Madrid', 'Ruko Madrid'),
#     ('Pasmod Timur', 'Pasmod Timur'),
#     ('Griyaloka 1', 'Griyaloka 1'),
#     ('Sektor 1.3', 'Sektor 1.3'),
#     ('Griyaloka 2', 'Griyaloka 2'),
#     ('Santa Ursula 1', 'Santa Ursula 1'),
#     ('Santa Ursula 2', 'Santa Ursula 2'),
#     ('Sentra Onderdil', 'Sentra Onderdil'),
#     ('Autopart 5', 'Autopart 5'),
#     ('Eka Hospital 2', 'Eka Hospital 2'),
#     ('Eat Bussiness District', 'Eat Bussiness District'),
#     ('SWA 1', 'SWA 1'),
#     ('Green Cove', 'Green Cove'),
#     ('The Breeze', 'The Breeze'),
#     ('CBD Timur 1', 'CBD Timur 1'),
#     ('Aeon Mall 1', 'Aeon Mall 1'),
#     ('CBD Barat 2', 'CBD Barat 2'),
#     ('Simplicity 1', 'Simplicity 1'),
#     ('Cosmo', 'Cosmo'),
#     ('Verdant View', 'Verdant View'),
#     ('Eternity', 'Eternity'),
#     ('Intermoda', 'Intermoda'),
#     ('Icon Business Park', 'Icon Business Park'),
#     ('Masjid Al Ukhuwa', 'Masjid Al Ukhuwa'),
#     ('Divena & Deshna', 'Divena & Deshna'),
#     ('The Avani Club House', 'The Avani Club House'),
#     ('Ammarilla', 'Ammarilla'),
#     ('Chandnya', 'Chandnya'),
#     ('Atmajaya', 'Atmajaya'),
#     ('Intermoda', 'Intermoda'),
# ]

# models.py




class BusRoute(models.Model):
    nama_rute = models.CharField(max_length=100)
    def __str__(self):
        return self.nama_rute

class Halte(models.Model):
    nama_halte = models.CharField(max_length=100, unique=True)
    class Meta:
        ordering = ['nama_halte']
    def __str__(self):
        return self.nama_halte


class Time(models.Model):
    time_value = models.TimeField()

    def __str__(self):
        return f'{self.time_value}'
    
class Waktu(models.Model):
    waktu_id = models.CharField(max_length=100, null=True)
    waktu_list = models.ManyToManyField(Time, related_name='waktu_list')
    def __str__(self):
        return self.waktu_id
        

waktu_list = (
    ('1','1'),
    ('2','2'),
    ('3','3'),
    ('4','4'),
    ('5','5'),
    ('6','6'),
    ('7','7'),
)

class WaktuRute(models.Model):
    rute = models.ForeignKey(BusRoute, related_name='waktu_id', on_delete=models.CASCADE)
    waktu_id = models.ForeignKey(Waktu, related_name='list_waktu', on_delete=models.CASCADE, blank=True, null=True) 
    waktu = models.CharField(max_length=10, choices=waktu_list)

    def __str__(self):
        # return f'({self.waktu}) {self.rute.nama_rute} {self.waktu_id}'
        return f'({self.waktu}) {self.rute.nama_rute}'

class BusSchedule(models.Model):
    rute = models.ForeignKey(BusRoute, related_name='rute', on_delete=models.CASCADE)
    nomor_bis = models.IntegerField()
    halte = models.ForeignKey(Halte, on_delete=models.CASCADE)
    waktu_1 = models.TimeField(blank=True, null=True)
    waktu_2 = models.TimeField(blank=True, null=True)
    waktu_3 = models.TimeField(blank=True, null=True)
    waktu_4 = models.TimeField(blank=True, null=True)
    waktu_5 = models.TimeField(blank=True, null=True)
    waktu_6 = models.TimeField(blank=True, null=True)
    waktu_7 = models.TimeField(blank=True, null=True)

    class Meta:
        ordering = ['nomor_bis']

    def __str__(self):
        return self.halte.nama_halte