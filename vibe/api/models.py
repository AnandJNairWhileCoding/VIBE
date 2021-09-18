from django.db import models

# Create your models here.
class Owner(models.Model):
    eMail= models.CharField(primary_key = True,max_length=60)
    name= models.CharField(max_length=50)
    photoUrl= models.CharField(max_length=200)
    phoneNumber=models.CharField(max_length=20)

    def __str__(self):
        return self.eMail


class ResidenceDetails(models.Model):
    owner = models.ForeignKey(Owner, on_delete=models.CASCADE)
    residenceId=models.CharField(primary_key = True,max_length=70)
    residenceName=models.CharField(max_length=50)
    residenceType=models.CharField(max_length=10)
    bedRooms=models.CharField(max_length=1)
    washRooms=models.CharField(max_length=1)
    carpetArea=models.CharField(max_length=10)
    parking=models.BooleanField(default=False)
    cost=models.CharField(max_length=6)
    locationLA=models.CharField(max_length=20)
    locationLO=models.CharField(max_length=20)

    def __str__(self):
        return self.residenceId



class ResidenceImages(models.Model):
    residence=models.ForeignKey(ResidenceDetails,on_delete=models.CASCADE)
    image= models.ImageField('image', upload_to='residenceImages/')
    def __str__(self):
        return str(self.image)



class User(models.Model):
    eMail= models.CharField(primary_key = True,max_length=60)
    name= models.CharField(max_length=50)
    photoUrl= models.CharField(max_length=200)


    def __str__(self):
        return self.eMail



class QandA(models.Model):
    residence=models.ForeignKey(ResidenceDetails,on_delete=models.CASCADE)
    user=models.ForeignKey(User,on_delete=models.CASCADE)
    question=models.CharField(max_length=400)
    answer=models.CharField(max_length=400,blank=True)

class Report(models.Model):
    residenceId=models.CharField(max_length=50)
    user=models.CharField(max_length=50)
    report=models.CharField(max_length=25)