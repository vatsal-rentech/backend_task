from assignment.models import SubmittedAssignments
from rest_framework import serializers


class ReportSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubmittedAssignments
        fields = ['assignment_id','assignment_submitted_at', 'assignment_obtain_score']