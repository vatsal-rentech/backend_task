# Generated by Django 4.2.2 on 2023-09-01 06:48

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('assignment', '0006_rename_assign_is_submitted_submittedassignments_assignment_is_submitted'),
    ]

    operations = [
        migrations.RenameField(
            model_name='submittedassignments',
            old_name='assignment_submitted_date',
            new_name='assignment_submitted_at',
        ),
    ]
