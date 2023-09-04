from .models import Assignment, SubmittedAssignments
from rest_framework import serializers



class AssignmentCreateSerializer(serializers.ModelSerializer):
    assign_to = serializers.ReadOnlyField(source='assign_from.username')
    class Meta:
        model = Assignment
        fields = ['id','assignment_name', 'assignment_description','assignment_due_date','assignment_score', 'assign_to']
        
class AssignmentStudentSerializer(serializers.ModelSerializer):
    assign_from = serializers.ReadOnlyField(source='assign_from.username')
    class Meta:
        model = Assignment
        fields = ['id','assignment_name', 'assignment_description','assignment_due_date','assignment_score','assign_from']

class AssignmentTeacherSerializer(serializers.ModelSerializer):
    assign_from = serializers.ReadOnlyField(source='assign_from.username')
    class Meta:
        model = Assignment
        fields = fields = ['id','assignment_name', 'assignment_description','assignment_due_date','assignment_score', 'assign_to','assign_from']


class StdentSubmitAssignmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubmittedAssignments
        fields = ['assignment_id', 'assignment_submitted_by','assign_student_answer','assignment_is_submitted','assignment_submitted_at']

class TeacherScoreSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubmittedAssignments
        fields = ['id','assignment_obtain_score']