from django import forms

from django.db.models import fields

from accounts.models import Account


class RegistrationForm(forms.ModelForm):
    password = forms.CharField(required=False,
                               widget=forms.PasswordInput(attrs={'placeholder': 'Enter the password',
                                                                 'class': 'form-control', 'onkeypress': 'check_password()', 'onblur': 'check_password()'}))
    confirm_password = forms.CharField(required=False,
                                       widget=forms.PasswordInput(attrs={'placeholder': 'Confirm the password',
                                                                         'class': 'form-control', 'onblur': 'check_confirm_password()'}))

    class Meta:
        model = Account
        fields = ['first_name', 'last_name',
                  'username', 'email', 'phone_number', 'address', 'referral_code']

    def __init__(self, *args, **kwargs):
        super(RegistrationForm, self).__init__(*args, **kwargs)
        self.fields['first_name'].widget.attrs = {
            'placeholder': 'Enter Your First Name', 'onkeypress': 'check_first_name()', 'onblur': 'check_first_name()'}
        self.fields['last_name'].widget.attrs = {
            'placeholder': 'Enter Last First Name', 'onkeypress': 'check_last_name()', 'onblur': 'check_last_name()'}
        self.fields['username'].widget.attrs = {
            'placeholder': 'Enter Your Username', 'onkeypress': 'check_username()', 'onblur': 'check_username()'}
        self.fields['email'].widget.attrs = {
            'placeholder': 'Enter Your Email Address', 'onkeypress': 'check_email()', 'onblur': 'check_email()'}
        self.fields['phone_number'].widget.attrs = {
            'placeholder': 'Enter Your Mobile Number', 'onkeypress': 'check_phone_number()', 'onblur': 'check_phone_number()'}
        self.fields['address'].widget.attrs['placeholder'] = 'Enter Your Address'
        for field in self.fields:
            self.fields[field].widget.attrs['class'] = 'form-control'
