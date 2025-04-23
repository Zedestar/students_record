from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.decorators import api_view
from .models import Student, Course

# Create your views here.


@api_view(['GET'])
def getStudentList(request):
    students = Student.objects.all()
    serializer = StudentListSerializer(students, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def getCourseList(request):
    course = Course.objects.all()
    serializer = CourseListSerializer(course, many=True)
    return Response(serializer.data)
