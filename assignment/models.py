from django.db import models
from django.contrib.auth.models import User
# Create your models here.


class Assignment(models.Model):
    assignment_name = models.CharField(max_length=50)
    assignment_description = models.TextField()
    assignment_due_date = models.DateField()
    assignment_score = models.IntegerField()
    assignment_created = models.DateTimeField(auto_now_add=True)
    assign_from = models.ForeignKey(User, on_delete=models.CASCADE, related_name='assign_from')
    assign_to = models.ManyToManyField(User, related_name='assign_to')

    def __str__(self):
        return self.assignment_name

class SubmittedAssignments(models.Model):
    assignment_id = models.ForeignKey(Assignment, on_delete=models.CASCADE, related_name='assignment_id')
    assignment_submitted_by = models.ForeignKey(User, on_delete=models.CASCADE, related_name='assignment_submitted_by')
    assign_student_answer = models.TextField(blank=True)
    assignment_is_submitted = models.BooleanField(default=False)
    assignment_obtain_score = models.FloatField(default=None)
    assignment_submitted_at = models.DateTimeField(auto_now_add=True)
