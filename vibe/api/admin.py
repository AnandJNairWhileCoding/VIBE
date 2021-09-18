from django.contrib import admin
from .models import *
# Register your models here.

@admin.register(Owner)
class OwnerAdmin(admin.ModelAdmin):
    list_display=['eMail','name','photoUrl','phoneNumber']



@admin.register(ResidenceDetails)
class ResidenceDetailsAdmin(admin.ModelAdmin):
    list_display=['owner','residenceId','residenceName','residenceType','bedRooms','washRooms','carpetArea','parking','cost','locationLA','locationLO']


@admin.register(ResidenceImages)
class ResidenceImagesAdmin(admin.ModelAdmin):
    list_display=['residence','image']

@admin.register(User)
class OwnerAdmin(admin.ModelAdmin):
    list_display=['eMail','name','photoUrl']

@admin.register(QandA)
class QandAAdmin(admin.ModelAdmin):
    list_display=['id','residence','user','question','answer']

@admin.register(Report)
class ReportAdmin(admin.ModelAdmin):
    list_display=['residenceId','user','report']