# Generated by Django 4.2.2 on 2023-09-01 11:16

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('assignment', '0008_submittedassignments_assignment_obtain_score'),
    ]

    operations = [
        migrations.AlterField(
            model_name='submittedassignments',
            name='assignment_obtain_score',
            field=models.FloatField(default=None),
        ),
    ]