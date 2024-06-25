"""
URL configuration for pobe_backend project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.contrib.auth.models import User
from rest_framework import routers, serializers, viewsets
from drf import models
from django.conf.urls.static import static
from django.conf import settings
from rest_framework.authtoken import views

class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ['url', 'username', 'email', 'is_staff']
class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class FoodSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = models.Food
        fields = '__all__'
class FoodViewSet(viewsets.ModelViewSet):
    queryset = models.Food.objects.all()
    serializer_class = FoodSerializer

class EntertainSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = models.Entertain
        fields = '__all__'
class EntertainViewSet(viewsets.ModelViewSet):
    queryset = models.Entertain.objects.all()
    serializer_class = EntertainSerializer

class SportSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = models.Sport
        fields = '__all__'
class SportViewSet(viewsets.ModelViewSet):
    queryset = models.Sport.objects.all()
    serializer_class = SportSerializer

class HospitalSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = models.Hospital
        fields = '__all__'
class HospitalViewSet(viewsets.ModelViewSet):
    queryset = models.Hospital.objects.all()
    serializer_class = HospitalSerializer

class MallSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = models.Mall
        fields = '__all__'
class MallViewSet(viewsets.ModelViewSet):
    queryset = models.Mall.objects.all()
    serializer_class = MallSerializer

class ShoppingSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = models.Shopping
        fields = '__all__'
class ShoppingViewSet(viewsets.ModelViewSet):
    queryset = models.Shopping.objects.all()
    serializer_class = ShoppingSerializer

class NewsSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = models.News
        fields = '__all__'
class NewsViewSet(viewsets.ModelViewSet):
    queryset = models.News.objects.all()
    serializer_class = NewsSerializer

class ReportSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = models.Report
        fields = '__all__'
class ReportViewSet(viewsets.ModelViewSet):
    queryset = models.Report.objects.all()
    serializer_class = ReportSerializer

class BusRouteSerializer(serializers.ModelSerializer):
    rute = serializers.StringRelatedField(many=True)
    waktu_id = serializers.StringRelatedField(many=True)
    class Meta:
        model = models.BusRoute
        fields = '__all__'

class BusRouteViewSet(viewsets.ModelViewSet):
    queryset = models.BusRoute.objects.all()
    serializer_class = BusRouteSerializer

class WaktuRuteSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.WaktuRute
        fields = '__all__'
class WaktuRuteViewSet(viewsets.ModelViewSet):
    queryset = models.WaktuRute.objects.all()
    serializer_class = WaktuRuteSerializer


class TimeSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Time
        fields = '__all__'
class TimeViewSet(viewsets.ModelViewSet):
    queryset = models.Time.objects.all()
    serializer_class = TimeSerializer

class WaktuSerializer(serializers.HyperlinkedModelSerializer):
    # waktu_list = TimeSerializer(many=True)
    # waktu_list = serializers.PrimaryKeyRelatedField(many=True, queryset=models.Time.objects.all())
    waktu_list = TimeSerializer(many=True, read_only=True)
    waktu_list_ids = serializers.PrimaryKeyRelatedField(
        many=True, queryset=models.Time.objects.all(), write_only=True, source='waktu_list'
    )

    class Meta:
        model = models.Waktu
        fields = ['id', 'waktu_list', 'waktu_list_ids']

    def create(self, validated_data):
        waktu_list_data = validated_data.pop('waktu_list')
        waktu = models.Waktu.objects.create(**validated_data)
        for time_data in waktu_list_data:
            waktu.waktu_list.add(time_data)
        return waktu

    def update(self, instance, validated_data):
        waktu_list_data = validated_data.pop('waktu_list')
        instance.waktu_list.clear()
        for time_data in waktu_list_data:
            instance.waktu_list.add(time_data)
        instance.save()
        return instance

class WaktuViewSet(viewsets.ModelViewSet):
    queryset = models.Waktu.objects.all()
    serializer_class = WaktuSerializer


class HalteSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Halte
        fields = '__all__'
class HalteViewSet(viewsets.ModelViewSet):
    queryset = models.Halte.objects.all()
    serializer_class = HalteSerializer

class BusScheduleSerializer(serializers.HyperlinkedModelSerializer):
    rute = serializers.PrimaryKeyRelatedField(queryset=models.BusRoute.objects.all())
    halte = serializers.PrimaryKeyRelatedField(queryset=models.Halte.objects.all())

    class Meta:
        model = models.BusSchedule
        fields = '__all__'
class BusScheduleViewSet(viewsets.ModelViewSet):
    queryset = models.BusSchedule.objects.all()
    serializer_class = BusScheduleSerializer

router = routers.DefaultRouter()
router.register(r'users', UserViewSet)
router.register(r'foods', FoodViewSet)
router.register(r'entertains', EntertainViewSet)
router.register(r'sports', SportViewSet)
router.register(r'hospitals', HospitalViewSet)
router.register(r'malls', MallViewSet)
router.register(r'shoppings', ShoppingViewSet)
router.register(r'newss', NewsViewSet)
router.register(r'reports', ReportViewSet)
router.register(r'haltes', HalteViewSet)
router.register(r'busroutes', BusRouteViewSet)
router.register(r'busscheduls', BusScheduleViewSet)
router.register(r'wakturutes', WaktuRuteViewSet)
router.register(r'waktus', WaktuViewSet)
router.register(r'time', TimeViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('admin/', admin.site.urls),
    path("ckeditor5/", include('django_ckeditor_5.urls')),
    path('api/', include('drf.urls', namespace='drf')),
    path('api-token-auth/', views.obtain_auth_token, name='api-token-auth'),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
]

if settings.DEBUG:
     urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

