from django.shortcuts import render
from .models import *
from .serializers import *
from rest_framework.generics import *
from rest_framework.authentication import TokenAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import views, status, generics
import base64
from django.core.files.base import ContentFile
import haversine as hs



# from django_filters.rest_framework import DjangoFilterBackend




# Create your views here.
# class UserList(CreateAPIView):
#     queryset=User.objects.all()
#     serializer_class=UserSerializers

    # def get_serializer(self, *args, **kwargs):
    #     # leave this intact
    #     serializer_class = self.get_serializer_class()
    #     draft_request_data = self.request.data.copy()
    #     draft_request_data["about"] = "pur pur pur pur pur"
    #     try:


            
        
    #         kwargs["context"] = self.get_serializer_context()   
            
    #         print(kwargs)
    #         print(draft_request_data)
    #         kwargs["data"] = draft_request_data
    #         return serializer_class(*args, **kwargs)
    #     except AssertionError:
    #         return serializer_class(*args, **kwargs)
    #     """
    #     If not mind your own business and move on
    #     """
        
class OwnerC(ListCreateAPIView):
  queryset=Owner.objects.all()
  serializer_class=OwnerSerializers  
     

class OwnerRUD(RetrieveUpdateDestroyAPIView):
    queryset=Owner.objects.all()
    serializer_class=OwnerSerializers
    # authentication_classes=[TokenAuthentication]
    # permission_classes=[IsAuthenticated]

class ResidenceDetailsUpload(views.APIView):
      def post(self, request):
        print(request.data['eMail'])
        print(Owner.objects.get(eMail= request.data['eMail']))

        # try:
        owner = Owner.objects.get(eMail= request.data['eMail'])
        for i in ResidenceDetails.objects.filter(owner=owner) :
          print(i) 
        obj=ResidenceDetails.objects.filter(owner=owner)
        
        count=obj.count()
        if count==0:
          id=request.data['eMail']+str(count)
        else:
          data=str(obj[count-1])
          result = data.find('@')+10
          a=int(data[result:])+1
          print(a-1)
          id=request.data['eMail']+str(a)

        
        ResidenceDetails(
                owner = owner,
                residenceId=id,
                residenceName = request.data['residenceName'],
                residenceType=request.data['residenceType'],
                bedRooms=request.data['bedRooms'],
                washRooms=request.data['washRooms'],
                carpetArea=request.data['carpetArea'],
                parking=request.data['parking'],
                cost=request.data['cost'],
                locationLA=request.data['locationLA'],
                locationLO=request.data['locationLO']
                ).save()
        # serializedData = ResidenceDetailsSerializers(ResidenceDetails, context= {'request': request}).data
    
        return Response({"residenceId":str(id)},status=status.HTTP_201_CREATED)
  
    
class ResidenceDetailsList(ListAPIView):
  queryset=ResidenceDetails.objects.all()
  serializer_class=ResidenceDetailsSerializers
  # filter_backends = [DjangoFilterBackend]
  filterset_fields = ['owner']

class ResidenceDetailsDistanceList(generics.ListAPIView):
    serializer_class = ResidenceDetailsSerializers

    def isNearToThisLocation(self,la1,lo1,la2,lo2):
      loc1=(eval(la1),eval(lo1))
      loc2=(eval(la2),eval(lo2))
      distance=hs.haversine(loc1,loc2)
      print("the distance")
      print(distance)
      if distance>6.1:
        return True
      else: return False


    def get_queryset(self):
        lattitude=self.request.GET.get('la')
        longitude=self.request.GET.get('lo')
        
        obj=ResidenceDetails.objects.all()
        excludelist = [i.residenceId for i in obj if self.isNearToThisLocation(lattitude,longitude,i.locationLA,i.locationLO)]
        print(excludelist)
        my_results = ResidenceDetails.objects.exclude(residenceId__in=excludelist)
        print(my_results.count())   
        return my_results





class ResidenceDetailsDelete(DestroyAPIView):
  queryset=ResidenceDetails.objects.all()
  serializer_class=ResidenceDetailsSerializers


class ResidenceImagesUpload(views.APIView):
  def post(self,request):
      residence = ResidenceDetails.objects.get(residenceId= request.data['residenceId'])
      imageName=request.data['residenceId']
      ResidenceImages(
      residence=residence,
      image=ContentFile(base64.b64decode(request.data['image']),f'{imageName}.jpg')
      ).save()
      return Response(status=status.HTTP_201_CREATED)
 
class ResidenceImagesList(ListAPIView):
  queryset=ResidenceImages.objects.all()
  serializer_class=ResidenceImagesSerializers
  filterset_fields = ['residence']


class UserCL(ListCreateAPIView):
  queryset=User.objects.all()
  serializer_class=UserSerializers
  

class RetriveUser(RetrieveAPIView):
  queryset=User.objects.all()
  serializer_class=UserSerializers

class RetriveOwner(RetrieveAPIView):
  queryset=Owner.objects.all()
  serializer_class=OwnerSerializers



class QandAPost(views.APIView):
  def post(self,request):
      residence = ResidenceDetails.objects.get(residenceId= request.data['residence']) 
      user=User.objects.get(eMail=request.data['user'])
      QandA(
      residence=residence,
      user=user,
      question=request.data['question'],
      # answer=request.data['answer']
      ).save()
      return Response(status=status.HTTP_201_CREATED)

  def put(self,request):
      residence = ResidenceDetails.objects.get(residenceId= request.data['residence']) 
      user=User.objects.get(eMail=request.data['user'])
      QandA(
      id=request.data['id'],
      residence=residence,
      user=user,
      question=request.data['question'],
      answer=request.data['answer']
      ).save()
      return Response(status=status.HTTP_201_CREATED)




class QandAList(ListAPIView):
  queryset=QandA.objects.all()
  serializer_class=QandASerializers
  filterset_fields = ['residence']


class QandAAnswer(UpdateAPIView):
  queryset=QandA.objects.all()
  serializer_class=QandASerializers


class ReportPost(CreateAPIView):
  queryset=Report.objects.all()
  serializer_class=ReportSerializers