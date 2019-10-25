import 'package:myfoodpoints/Models/BaseModel.dart';
import 'package:myfoodpoints/Models/Enums.dart';

class UserProfile extends BaseModel {
  String firstName;
  String middleInitial;
  String lastName;
  Gender gender;
  ActivityLevel activityLevel;
  bool isBreastFeeding;
  double startWeight;
  String idealWeightRange;
  double goalWeight;
  UserMembershipType userMembershipType;

  bool isDiabetic;
  bool hasHighCholesterol;
  String otherHealthConcerns;

  //optional

  String addressLine1;
  String addressLine2;
  String city;
  String state;
  String zipcode;
  String country;
  String phoneNumber;
}
