# Generated by Django 4.2.2 on 2023-09-01 06:04

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('assignment', '0004_remove_assignment_assign_is_submitted_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='submittedassignments',
            name='assignment_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='assignment_id', to='assignment.assignment'),
        ),
    ]