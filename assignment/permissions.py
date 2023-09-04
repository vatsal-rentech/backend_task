from rest_framework import permissions
from django.contrib.auth.models import User, Group

class TeacherCustomPermission(permissions.BasePermission):
    def has_permission(self, request, view):
        print("++++++++++++++++++++ ", request.data)
        user = User.objects.get(username=request.user)
        group = user.groups.get()
        

        if str(group).lower() == 'teacher':
            return True
        # if str(group).lower() == 'teacher' and request.method == "POST":
        #     return True
        
        # if str(group).lower() == 'teacher' and request.method == "PATCH":
        #     return True

        # if str(group).lower() == 'teacher' and request.method == "DELETE":
        #     return True
        
        # if str(group).lower() == 'teacher' and request.method == 'GET':
        #     return True
class StudentCustomPermission(permissions.BasePermission):
    def has_permission(self, request, view):
        user = User.objects.get(username=request.user)
        group = user.groups.get()

        if str(group).lower() == 'student' and request.method == "POST":
            return True
        
        if str(group).lower() == 'teacher' and request.method == "PATCH":
            return True