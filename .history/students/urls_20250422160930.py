from django.urls import path
from . import views

urlpatterns = [
    path('studentList/', views.getStudentList, name="studentList"),
    path('courseList/', views.getCourseList, name="courseList"),
]