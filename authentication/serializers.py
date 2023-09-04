from django.contrib.auth.models import User, Group
from rest_framework import serializers
# from .models import CustomUser

class ShowGroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = Group
        fields = ['id', 'name']


class CreateGroupSerializer(serializers.ModelSerializer):
    class Meta:
        model = Group
        fields = ['name']  
    def create(self, validated_data):
        group = validated_data.get('name')
        if group:
            gp = Group(name=validated_data.get('name'))
            gp.save()
            return gp
        else:
            raise serializers.ValidationError('errors')


class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(style = {'input':'password'})
    user_group = serializers.CharField(write_only=True)
    class Meta:
        model = User
        # model = CustomUser
        fields = ['username', 'email', 'password', 'user_group']
        
    def create(self, validated_data):
        user_group = validated_data.get('user_group')
        if user_group:
            user = User(username = validated_data.get('username'), email = validated_data.get('email'))
            user.set_password(validated_data.get('password'))
            user.save()
            user.groups.add(user_group)
            return user
        

class LoginSerializer(serializers.Serializer):
    username = serializers.CharField(max_length=255)
    password = serializers.CharField(style = {'input':'password'})
  