import 'package:get/get.dart';

class AppConstants {
  static AppConstants get to => Get.find();

  RxBool isGuest = false.obs;

  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString profilePic = ''.obs;
  RxString address = ''.obs;
  RxString about = ''.obs;
  Rx<DateTime> dob = DateTime(1970, 1, 1).obs;

  void setName(String value) {
    name.value = value;
  }

  void setEmail(String value) {
    email.value = value;
  }

  void setPhone(String value) {
    phone.value = value;
  }

  void setProfilePic(String value) {
    profilePic.value = value;
  }

  void setAddress(String value) {
    address.value = value;
  }

  void setAbout(String value) {
    about.value = value;
  }

  void setDOB(DateTime value) {
    dob.value = value;
  }

}
