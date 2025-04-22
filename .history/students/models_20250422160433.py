from django.db import models

# Create your models here.

class Student(models.Model):
    name = models.CharField(max_length=250)
    course = models.CharField(max_length=250)
        
    def __str__(self):
        return f"self.name = {self.course}"
        

class Course(models.Model):
    course_name = models.CharField(max_length=250)
    accademic_year = models.IntegerField(default=2021)
    
    def __str__(self):
        return f"{self.course_name} = {self.accademic_year}"
