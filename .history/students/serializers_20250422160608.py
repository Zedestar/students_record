class StudentListSerializer(ModelSerializer):
    class Meta:
        model = Student
        fields = '__all__'
        
        
class CourseListSerializer(ModelSerializer):
    class Meta:
        model = Course
        fields = '__all__'