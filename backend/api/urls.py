from django.urls import path

from api import views

urlpatterns = [
    path('food/', views.FoodRecommendationsView.as_view()),
    path('akun/', views.AkunView.as_view()),
    path('akun/<str:nim>/', views.AkunView.as_view()),
    path('login/', views.LoginView.as_view()),
    path('medical/', views.MedicalRecordView.as_view()),
    path('medical/<str:nim>/', views.MedicalRecordView.as_view()),
    path('medical/<int:id>/', views.MedicalRecordView.as_view()),
]
