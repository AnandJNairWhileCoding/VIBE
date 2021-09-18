from django.contrib import admin
from django.urls import path
from .views import *



urlpatterns = [
    
    path("users/<str:pk>",OwnerRUD.as_view()),
    path("createUser/",OwnerC.as_view()),
    path("uploadResidentialDetails/",ResidenceDetailsUpload.as_view()),
    path("listResidentialDetails/",ResidenceDetailsList.as_view()),
    path("listFilteredResidentialDetails/",ResidenceDetailsDistanceList.as_view()),
    path("createUser1/",UserCL.as_view()),
    path("retriveUser/<str:pk>",RetriveUser.as_view()),
    path("retriveOwner/<str:pk>",RetriveOwner.as_view()),

    path("uploadImage/",ResidenceImagesUpload.as_view()),
    path("listImage/",ResidenceImagesList.as_view()),
    path("deleteResidence/<str:pk>",ResidenceDetailsDelete.as_view()),
    path("listQandA/",QandAList.as_view()),
    path("postQandA/",QandAPost.as_view()),
    path("postAnswer/<int:pk>",QandAAnswer.as_view()),
    path("postReport/",ReportPost.as_view()),

    







    # path('students/',StudentData.as_view())
    # https://simpleisbetterthancomplex.com/tutorial/2018/11/22/how-to-implement-token-authentication-using-django-rest-framework.html
]