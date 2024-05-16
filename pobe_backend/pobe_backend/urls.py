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

class CommentNewsSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = models.CommentNews
        fields = '__all__'
class CommentNewsViewSet(viewsets.ModelViewSet):
    queryset = models.CommentNews.objects.all()
    serializer_class = CommentNewsSerializer

router = routers.DefaultRouter()
router.register(r'users', UserViewSet)
router.register(r'foods', FoodViewSet)
router.register(r'entertains', EntertainViewSet)
router.register(r'sports', SportViewSet)
router.register(r'hospitals', HospitalViewSet)
router.register(r'malls', MallViewSet)
router.register(r'shoppings', ShoppingViewSet)
router.register(r'newss', NewsViewSet)
router.register(r'commentnewss', CommentNewsViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('admin/', admin.site.urls),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
]

if settings.DEBUG:
     urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

