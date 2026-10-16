from django.db import models

# Create your models here.

class Member(models.Model):
  firstname = models.CharField(max_length=255)
  lastname = models.CharField(max_length=255)
  phone = models.IntegerField()
  joined_date = models.DateField()

class Court(models.Model):
    description = models.CharField(max_length=255)
    court_type = models.IntegerField()