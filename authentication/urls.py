from django.urls import path
from . import views

urlpatterns = [
    path('registration/', views.RegistrationView.as_view(), name='registration'),
    path('crearte-group/',views.GroupApiView.as_view()),
    path('login/', views.LoginView.as_view()),
    path('success/',views.SuccessView.as_view())
]