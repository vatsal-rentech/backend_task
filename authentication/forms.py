from django import forms

class StudentRegistration(forms.Form):
    username = forms.CharField(error_messages={'required':'Enter Your Username'})
    email = forms.EmailField(error_messages={'required':'Enter Your Email'})
    password = forms.CharField(widget= forms.PasswordInput,error_messages={'required':'Enter Your Password'})
    USER_GROUPS= [
    ('1', 'Teacher'),
    ('2', 'Student'),
    ]

    user_group= forms.CharField(label='Select your user group', widget=forms.Select(choices=USER_GROUPS))

class Login(forms.Form):
    username = forms.CharField(error_messages={'required':'Enter Your Name'})
    password = forms.CharField(widget= forms.PasswordInput,error_messages={'required':'Enter Your Password'})


