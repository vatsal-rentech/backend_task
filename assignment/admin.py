from django.contrib import admin
from .models import Assignment, SubmittedAssignments
# Register your models here.

@admin.register(Assignment)
class AssignmentAdmin(admin.ModelAdmin):
    list_display = ['id', 'assignment_name', 'assignment_description','assignment_due_date', 'assignment_score', 'assign_from','get_assigned_users']
    # list_display = ['id', 'assignment_name', 'assignment_description','assignment_due_date', 'assignment_score', 'assign_from','get_assigned_users','assign_is_submitted','assign_student_answer']

    def get_assigned_users(self, obj):
        return [user.username for user in obj.assign_to.all()]
    get_assigned_users.short_description = 'Assigned Users'

@admin.register(SubmittedAssignments)
class AssignmentAdmin(admin.ModelAdmin):
    list_display = ['id','assignment_id', 'assignment_submitted_by_id','assignment_submitted_by','assign_student_answer','assignment_is_submitted','assignment_submitted_at','assignment_obtain_score']
