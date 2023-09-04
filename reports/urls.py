from django.urls import path
from . import views

urlpatterns = [
    path('student-reports/', views.StudentReportView.as_view(), name='student-reports'),
    path('teacher-reports/', views.TeacherReportView.as_view(), name='teacher-reports'),
    
]