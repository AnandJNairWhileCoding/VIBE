import 'package:get/get.dart';

class DetailedViewScreenController extends GetxController{
int activeSlide=0;
setActiveSlide(int count){
  this.activeSlide=count;
  update();
}

}