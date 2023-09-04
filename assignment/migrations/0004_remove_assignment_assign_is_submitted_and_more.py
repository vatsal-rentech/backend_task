# Generated by Django 4.2.2 on 2023-09-01 05:46

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('assignment', '0003_rename_assign_student_asnwer_assignment_assign_student_answer'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='assignment',
            name='assign_is_submitted',
        ),
        migrations.RemoveField(
            model_name='assignment',
            name='assign_student_answer',
        ),
        migrations.CreateModel(
            name='SubmittedAssignments',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('assignment_id', models.IntegerField()),
                ('assign_student_answer', models.TextField(blank=True)),
                ('assign_is_submitted', models.BooleanField(default=False)),
                ('assignment_submitted_date', models.DateTimeField(auto_now_add=True)),
                ('assignment_submitted_by', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='assignment_submitted_by', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
