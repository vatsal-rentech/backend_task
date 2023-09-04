from rest_framework.views import APIView
from assignment.models import SubmittedAssignments, Assignment
from django.contrib.auth.models import User
from .serializers import ReportSerializer
from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework import status
from rest_framework.response import Response
from assignment.helpers import paginate
from django.core.paginator import Paginator
from django.utils.decorators import method_decorator
from django.views.decorators.cache import cache_page
from django.views.decorators.vary import vary_on_cookie
# Create your views here.


class StudentReportView(APIView):
    authentication_classes=[JWTAuthentication]

    @method_decorator(vary_on_cookie)
    @method_decorator(cache_page(60*60))
    def get(self, request):
        try:

            if not request.user.is_authenticated:
                return Response(data = {'message': 'Un authenticated user!'}, status=status.HTTP_401_UNAUTHORIZED)

            # assignment_obj = SubmittedAssignments.objects.filter(assignment_submitted_by = str(request.user))
            assignment_obj = SubmittedAssignments.objects.filter(assignment_submitted_by = request.user)
            page = request.GET.get("page", 1)
            page_obj = Paginator(assignment_obj, page)
            results = paginate(assignment_obj, page_obj, page)
            serializer = ReportSerializer(results["result"], many=True)
            return Response(status = status.HTTP_200_OK,
                data={
                    "message": "data fetched",
                    "data": {"data": serializer.data, "pagination": results["pagination"]},
                }
            )


        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={"message": "Something went wrong!!"})

class TeacherReportView(APIView):
    authentication_classes=[JWTAuthentication]

    # here it will give the sae response though we are changing the student name due to cache in its life time
    # @method_decorator(vary_on_cookie)
    # @method_decorator(cache_page(60*60))

    def get(self, request):
        try:

            if not request.user.is_authenticated:
                return Response(data = {'message': 'Un authenticated user!'}, status=status.HTTP_401_UNAUTHORIZED)
            user_obj = User.objects.get(username = request.data.get('student'))
            print(user_obj)
            assignment_obj = SubmittedAssignments.objects.filter(assignment_submitted_by = user_obj)
            print(assignment_obj)
            page = request.GET.get("page", 1)
            page_obj = Paginator(assignment_obj, page)
            results = paginate(assignment_obj, page_obj, page)
            serializer = ReportSerializer(results["result"], many=True)
            return Response(status = status.HTTP_200_OK,
                data={
                    "message": "data fetched",
                    "data": {"data": serializer.data, "pagination": results["pagination"]},
                }
            )

        except Exception as e:
            
            return Response(status=status.HTTP_400_BAD_REQUEST, data={"message": e})