from django import forms

class CourtForm(forms.Form):
    description = forms.CharField(label="Description", max_length=30)
    court_type = forms.CharField(label="Type of court", max_length=10)

class MemberForm(forms.Form):
    firstname = forms.CharField(label="First name", max_length=255)
    lastname = forms.CharField(label="Last name", max_length=255)
    phone = forms.IntegerField(label="Phone number")
    joined_date = forms.DateField(label="Joined date")