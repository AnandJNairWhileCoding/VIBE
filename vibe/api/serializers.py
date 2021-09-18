from rest_framework import serializers
from .models import *

class OwnerSerializers(serializers.ModelSerializer):
    class Meta:
        model=Owner
        fields=['eMail','name','photoUrl','phoneNumber']

class ResidenceDetailsSerializers(serializers.ModelSerializer):
    class Meta:
        model=ResidenceDetails
        fields= ['owner','residenceId','residenceName','residenceType','bedRooms','washRooms','carpetArea','parking','cost','locationLA','locationLO']

class ResidenceImagesSerializers(serializers.ModelSerializer):
    class Meta:
        model=ResidenceImages
        fields= ['residence','image']

class UserSerializers(serializers.ModelSerializer):
    class Meta:
        model=User
        fields=['eMail','name','photoUrl']



class QandASerializers(serializers.ModelSerializer):
    class Meta:
        model=QandA
        fields=['id','residence','user','question','answer']

class ReportSerializers(serializers.ModelSerializer):
    class Meta:
        model=Report
        fields=['residenceId','user','report']




            