from django import forms

class CreateAssignment(forms.Form):
    assignment_name = forms.CharField()
    assignment_description = forms.CharField(widget=forms.TextInput(attrs={'name':'assignment_description'}))
    assignment_due_date = forms.DateField(widget=forms.DateInput)
    assignment_score = forms.IntegerField()