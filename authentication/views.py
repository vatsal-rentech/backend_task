from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework import status
from django.http import HttpResponse
from django.contrib.sessions.serializers import JSONSerializer
from django.contrib.auth.models import User, Group
from django.contrib.auth import authenticate, login
from django.http import HttpResponseRedirect
from .forms import StudentRegistration, Login
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework_simplejwt.authentication import JWTAuthentication
from .serializers import ShowGroupSerializer, CreateGroupSerializer, RegisterSerializer, LoginSerializer
from django.utils.decorators import method_decorator
from django.views.decorators.cache import cache_page
from django.views.decorators.vary import vary_on_cookie

class SuccessView(APIView):
    def get(self,request):
        return render(request, 'success.html')

def get_tokens_for_user(user):
    refresh = RefreshToken.for_user(user)
    return {
        "refresh": str(refresh),
        "access": str(refresh.access_token),
    }

class RegistrationView(APIView):
    '''
    # method with html form
    def post(self,request):
        # if request.method == 'POST':
        fm = StudentRegistration(request.POST)
        # print(fm)
        if fm.is_valid():
            username = fm.cleaned_data['username']
            email = fm.cleaned_data['email']
            password = fm.cleaned_data['password']
            user_group = fm.cleaned_data['user_group'] 
            serializer = RegisterSerializer(data=request.data)
            g_id = request.data.get("user_group")
            user_group = Group.objects.get(id=g_id)
            if serializer.is_valid(raise_exception=True):
                serializer.save()       

            return HttpResponseRedirect('/login/')
        else:
            return render(request, 'registration.html',{'form': fm})
        '''
    
    def post(self, request):
        try:
            serializer = RegisterSerializer(data=request.data)
            g_id = request.data.get("user_group")
            group_name = Group.objects.get(id=g_id)
            if serializer.is_valid(raise_exception=True):
                serializer.save()

                return Response(status=status.HTTP_201_CREATED,
                    data={"message":"User created Successfully",
                        "username": request.data.get("username"),
                        "email": request.data.get("email"),
                        "user_group": group_name.name,
                    },
                )
            return Response(data=serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={"message": "Something went wrong!!"})



    def get(self, request):
        fm = StudentRegistration()

        return render(request, 'registration.html',{'form': fm})


class LoginView(APIView):
    authentication_classes=[JWTAuthentication]

    '''
    # Method for login using HTML form
    def post(self, request):
        fm = Login(request.POST)
        if fm.is_valid():
            data = request.data
            response = Response()
            username = fm.cleaned_data['username']
            password = fm.cleaned_data['password']

        if user.is_active:
                    data = get_tokens_for_user(user)
                    response.set_cookie(
                        key = settings.SIMPLE_JWT['AUTH_COOKIE'], 
                        value = data["access"],
                        expires = settings.SIMPLE_JWT['ACCESS_TOKEN_LIFETIME'],
                        secure = settings.SIMPLE_JWT['AUTH_COOKIE_SECURE'],
                        httponly = settings.SIMPLE_JWT['AUTH_COOKIE_HTTP_ONLY'],
                        samesite = settings.SIMPLE_JWT['AUTH_COOKIE_SAMESITE']
                    )
                    csrf.get_token(request)

                login(request,user)
                
                
                Setting up JWT token and sending the resopnse
                redirect to login

                return HttpResponseRedirect('/success/')
        else:
                return render(request, 'login.html',{'form': fm})
                
        else:
            return render(request, 'login.html',{'form': fm})

    '''
    def get(self, request):
        fm = Login()
        return render(request, 'login.html',{'form': fm})

    def post(self,request):
        
        try:
            serializer = LoginSerializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            username = request.data.get("username")
            password = request.data.get("password")
            user = authenticate(request,username=username, password=password)
            if user is not None:
                
                data = {
                    "id": user.id,
                    "username": user.username,
                    "token": get_tokens_for_user(user),
                }
                return Response(data, status=status.HTTP_200_OK) 
                
                
            else:
                return Response(data={}, status=status.HTTP_400_BAD_REQUEST) 
        except:
           
            return Response(status=status.HTTP_400_BAD_REQUEST, data={"message": "Something went wrong!!"})


# just for creattin user group initially (teacher , student)

class GroupApiView(APIView):
    @method_decorator(vary_on_cookie)
    @method_decorator(cache_page(60*60))
    def get(self, request):
        try:
            queryset = Group.objects.all()
            serializer = ShowGroupSerializer(queryset, many=True)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={"message": "Something went wrong!!"})

    def post(self, request):
        try:
            serializer = CreateGroupSerializer(data=request.data)
            if serializer.is_valid(raise_exception=True):
                serializer.save()
                return Response(
                    status=status.HTTP_200_OK,
                    data={"message": "Group created Successfully"},
                )
            return Response(status=status.HTTP_406_NOT_ACCEPTABLE, data=serializer.errors)
        except:
            return Response(status=status.HTTP_400_BAD_REQUEST, data={"message": "Something went wrong!!"})


