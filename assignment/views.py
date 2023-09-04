from rest_framework.views import APIView
from .serializers import (
    AssignmentCreateSerializer,
    AssignmentTeacherSerializer,
    AssignmentStudentSerializer,
    StdentSubmitAssignmentSerializer,
    TeacherScoreSerializer,
    StdentSubmitAssignmentSerializer,
)
from django.contrib.auth.models import User
from rest_framework.response import Response
from rest_framework import status
from .permissions import TeacherCustomPermission, StudentCustomPermission
from .models import Assignment, SubmittedAssignments
from .helpers import paginate
from django.core.paginator import Paginator
from django.http import HttpResponseRedirect
from rest_framework_simplejwt.authentication import JWTAuthentication
from django.core.mail import send_mail
from django.utils.decorators import method_decorator
from django.views.decorators.cache import cache_page
from django.views.decorators.vary import vary_on_cookie


class TeacherAssignmentView(APIView):
    permission_classes = [TeacherCustomPermission]
    authentication_classes=[JWTAuthentication]

    def post(self, request):
        if not request.user.is_authenticated:
            return HttpResponseRedirect("/login/")
        serializer = AssignmentCreateSerializer(data=request.data)

        if serializer.is_valid():
            student_users = User.objects.filter(groups=2)
            ids = student_users.values_list("id", flat=True)
            assign_from_user = self.request.user
            for id in ids:
                if id == assign_from_user.id:
                    return Response(
                        {"message": "You cannot assign task to youself"},
                        status=status.HTTP_400_BAD_REQUEST,
                    )
            task = serializer.save(assign_from=assign_from_user)
            task.assign_to.set(student_users)


            # sending email to all the students to notify the new assignment is created
            try:
                sender_user_email = request.user.email
                all_students_email = [i.email for i in student_users]
                subject = 'welcome to WorkManagement World'
                message = f"Assignment  {request.data.get('assignment_name')} is assign to you by{str(request.user)}"
                send_mail( subject, message, sender_user_email, all_students_email )
            except Exception as e:
                print("error in sending mail to students: ", e)


            return Response({"message": "assign create successfully."})
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


    @method_decorator(vary_on_cookie)
    @method_decorator(cache_page(60*60))
    def get(self, request):
        try:
            if not request.user.is_authenticated:
                return Response(data = {'message': 'Un authenticated user!'}, status=status.HTTP_401_UNAUTHORIZED)
            assignment_obj = Assignment.objects.filter(assign_from = request.user)
            
            page = request.GET.get("page", 1)
            page_obj = Paginator(assignment_obj, page)
            results = paginate(assignment_obj, page_obj, page)

            serializer = AssignmentTeacherSerializer(results["result"], many=True)
            return Response(status = status.HTTP_200_OK,
                data={
                    "message": "data fetched",
                    "data": {"data": serializer.data, "pagination": results["pagination"]},
                }
            )
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={"message": "Something went wrong!!"})


    def patch(self, request):
        try:
            data = request.data
            if not data.get("id"):
                return Response(
                    {"status": False, "message": "Assignment does not exists!!"}
                )
            obj = Assignment.objects.get(id=data.get("id"))

            if obj is not None:
                if str(request.user) == str(obj.assign_from):
                    serializer = AssignmentCreateSerializer(
                        obj, data=data, partial=True
                    )
                    if serializer.is_valid():
                        serializer.save()
                        return Response(
                            status=status.HTTP_200_OK,
                            data={
                                "message": "data updated successfully",
                                "data": serializer.data,
                            },
                        )

                else:
                    return Response(
                        status=status.HTTP_401_UNAUTHORIZED,
                        data={
                            "message": "Access denied!!  You have not created this assignment",
                        },
                    )
            return Response(
                status=status.HTTP_404_NOT_FOUND,
                data={"message": "Assignment not found!!"},
            )
        except Exception as e:
            print(e)
            return Response(
                status=status.HTTP_404_NOT_FOUND,
                data={"message": "Assignment not found !!"},
            )

    def delete(self, request):
        try:
            obj = Assignment.objects.get(id=request.data.get('assignment_id'))

            if obj is not None:
                if str(request.user) == str(obj.assign_from):
                    obj.delete()
                    return Response(
                        status=status.HTTP_200_OK,
                        data={"message": "Assignment deleted successfully!!"},
                    )
                else:
                    return Response(
                        status=status.HTTP_401_UNAUTHORIZED,
                        data={"message": "Access denied, you can delete the assignment you have created !!"},
                    )
            return Response(
                status=status.HTTP_404_NOT_FOUND,
                data={"message": "Assignment not found!!"},
            )

        except Exception as e:
            print(e)
            return Response(
                status=status.HTTP_404_NOT_FOUND,
                data={"message": "Assignment not found !!"},
            )

class StudentAssignmentView(APIView):
    permission_classes = [StudentCustomPermission]
    authentication_classes=[JWTAuthentication]

    @method_decorator(vary_on_cookie)
    @method_decorator(cache_page(60*60))
    def get(self, request):
        try:
            if not request.user.is_authenticated:
                return Response(data = {'message': 'Un authenticated user!'}, status=status.HTTP_401_UNAUTHORIZED)

            assignment_obj = Assignment.objects.all()
            page = request.GET.get("page", 1)
            page_obj = Paginator(assignment_obj, page)
            results = paginate(assignment_obj, page_obj, page)
            serializer = AssignmentStudentSerializer(results["result"], many=True)
            return Response(
                {
                    "status": status.HTTP_200_OK,
                    "message": "data fetched",
                    "data": {"data": serializer.data, "pagination": results["pagination"]},
                }
            )
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={"message": "Something went wrong!!"})

    def post(self, request):
        try:
            if not request.user.is_authenticated:
                return Response(data = {'message': 'Un authenticated user!'}, status=status.HTTP_401_UNAUTHORIZED)

            try:
                data = request.data
                submitted_assignment_obj = SubmittedAssignments.objects.filter(assignment_id = data.get("assignment_id"))
                submitted_assign_student_id = [str(i.assignment_submitted_by) for i in submitted_assignment_obj]

                if str(request.user) in submitted_assign_student_id:
                    return Response(status=status.HTTP_406_NOT_ACCEPTABLE, data = {"message": " You have already submitted this assignment!!!"})
                
                if not data.get("assignment_id"):
                    return Response(status=status.HTTP_404_NOT_FOUND,
                        data={"message": "Assignment does not exists!!"}
                    )

                obj = Assignment.objects.get(id=data.get("assignment_id"))
                user_list = list(obj.assign_to.filter(groups=2))
                user_names = [i.username for i in user_list]

                final_data = {
                    "assignment_id" : data.get("assignment_id"),
                    "assignment_submitted_by" : request.user.id,
                    "assign_student_answer": data.get("assign_student_answer"),
                    "assignment_is_submitted": True,
                }

                if obj:
                    if str(request.user) in user_names:
                        serializer = StdentSubmitAssignmentSerializer(
                            data=final_data, partial=False)
                        if serializer.is_valid():
                            serializer.save()
                            return Response(
                                status=status.HTTP_200_OK,
                                data={
                                    "message": "data updated successfully",
                                    "data": serializer.data,
                                },
                            )
                        else:
                            return Response(
                            status=status.HTTP_400_BAD_REQUEST,
                            data={
                                "message": "Enter valid data!",
                            },
                        )

                    else:
                        return Response(
                            status=status.HTTP_401_UNAUTHORIZED,
                            data={
                                "message": "Access denied!!  You have not enrolled in this assignment",
                            },
                        )
                return Response(
                    status=status.HTTP_404_NOT_FOUND,
                    data={"message": "Assignment not found!!"},
                )
            except Exception as e:
                print(e)
                return Response(
                    status=status.HTTP_404_NOT_FOUND,
                    data={"message": "Assignment not found !!"},
                )
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={"message": "Something went wrong!!"})

    def patch(self, request):
        try:
            data = request.data
            if not data.get("id"):
                return Response(
                    {"status": False, "message": "Assignment does not exists!!"}
                )
            submitted_assignment_obj = SubmittedAssignments.objects.get(id=data.get("id"))

            assignment_obj = Assignment.objects.get(assignment_name=submitted_assignment_obj.assignment_id)

            if assignment_obj is not None:
                if str(request.user) == str(assignment_obj.assign_from):
                    serializer = TeacherScoreSerializer(
                        submitted_assignment_obj,data=data,partial=True
                    )
                    if serializer.is_valid():
                        serializer.save()
                        return Response(
                            status=status.HTTP_200_OK,
                            data={
                                "message": "data updated successfully",
                                "data": serializer.data,
                            },
                        )

                else:
                    return Response(
                        status=status.HTTP_401_UNAUTHORIZED,
                        data={
                            "message": "Access denied!!  You have not created this assignment",
                        },
                    )
            return Response(
                status=status.HTTP_404_NOT_FOUND,
                data={"message": "Assignment not found!!"},
            )
        except Exception as e:
            print(e)
            return Response(
                status=status.HTTP_406_NOT_ACCEPTABLE,
                data={"message": "Unsuccessful , Something went wrong!!"},
            )
        

