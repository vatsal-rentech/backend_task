from django.urls import path
from . import views

urlpatterns = [
    path('teacher-assignment/', views.TeacherAssignmentView.as_view(), name='teacher-assignment'),
    path('student-assignment/', views.StudentAssignmentView.as_view(), name='student-assignment'),

]