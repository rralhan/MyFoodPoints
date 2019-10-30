import 'package:myfoodpoints/Models/BaseModel.dart';
import 'package:myfoodpoints/Models/Enums.dart';

class UserProfile extends BaseModel {
  UserProfile() : super();

  String firstName;
  String middleInitial;
  String lastName;
  Gender gender;
  double startWeight;
  String idealWeightRange;
  double goalWeight;
  UserMembershipType userMembershipType;
  String profilePicturePath;
  DateTime dateOfBirth;
  double height;

  //optional

  UserHealthProfile userHealthProfile;
  UserStat userStat;

  String addressLine1;
  String addressLine2;
  String city;
  String state;
  String zipcode;
  String country;
  String phoneNumber;

  UserProfile.fromMap(Map<String, dynamic> map, [bool isAlternate = false])
      : super.fromMap(map, isAlternate) {
    this.firstName = map["name"];
    this.middleInitial = map["email"];
    this.lastName = map["email"];
    this.gender = map["gender"];
    this.startWeight = map["startWeight"];
    this.idealWeightRange = map["idealWeightRange"];
    this.goalWeight = map["goalWeight"];
    this.userMembershipType = map["userMembershipType"];
    this.profilePicturePath = map["profilePicturePath"];
    if (map["dateOfBirth"] != null) {
      this.dateOfBirth = map["signedIn"].toDate();
    }
    this.height = map["height"];
    this.userHealthProfile = map["userHealthProfile"];
    this.addressLine1 = map["addressLine1"];
    this.addressLine2 = map["addressLine2"];
    this.city = map["city"];
    this.state = map["state"];
    this.country = map["country"];
    this.phoneNumber = map["phoneNumber"];
    this.userStat = map["userStat"];
  }

  Map<String, dynamic> toMap([bool isAlternate = false]) {
    var map = super.toMap(isAlternate);
    map["firstName"] = firstName;
    map["middleInitial"] = middleInitial;
    map["lastName"] = lastName;
    map["gender"] = gender;
    map["startWeight"] = startWeight;
    map["idealWeightRange"] = idealWeightRange;
    map["goalWeight"] = goalWeight;

    map["userMembershipType"] = userMembershipType;
    map["profilePicturePath"] = profilePicturePath;
    if (isAlternate) map["dateOfBirth"] = dateOfBirth.toString();
    map["height"] = height;
    map["userHealthProfile"] = userHealthProfile;
    map["addressLine1"] = addressLine1;
    map["addressLine2"] = addressLine2;
    map["city"] = city;
    map["state"] = state;
    map["country"] = country;
    map["phoneNumber"] = phoneNumber;
    map["userStat"] = userStat;
    return map;
  }
}

class UserHealthProfile extends BaseModel {
  UserHealthProfile() : super();
  bool isDiabetic;
  bool hasHighCholesterol;
  String otherHealthConcerns;

  ActivityLevel activityLevel;
  bool isBreastFeeding;

  UserHealthProfile.fromMap(Map<String, dynamic> map,
      [bool isAlternate = false])
      : super.fromMap(map, isAlternate) {
    this.isDiabetic = map["isDiabetic"];
    this.hasHighCholesterol = map["hasHighCholesterol"];
    this.otherHealthConcerns = map["otherHealthConcerns"];
    this.activityLevel = map["activityLevel"];
    this.isBreastFeeding = map["isBreastFeeding"];
  }

  Map<String, dynamic> toMap([bool isAlternate = false]) {
    var map = super.toMap(isAlternate);
    map["isDiabetic"] = isDiabetic;
    map["hasHighCholesterol"] = hasHighCholesterol;
    map["otherHealthConcerns"] = otherHealthConcerns;
    map["activityLevel"] = activityLevel;
    map["isBreastFeeding"] = isBreastFeeding;
    return map;
  }
}

class UserStat extends BaseModel {
  UserStat() : super();
  double points;
  double cheatPoints;
  DateTime weekDate;
  double bodyMassIndex;
  double currentWeight;
  double height;

  UserStat.fromMap(Map<String, dynamic> map, [bool isAlternate = false])
      : super.fromMap(map, isAlternate) {
    this.points = map["deviceType"];
    this.cheatPoints = map["deviceToken"];
    if (map["weekDate"] != null) {
      this.weekDate = map["weekDate"].toDate();
    }
    this.bodyMassIndex = map["bodyMassIndex"];
    this.currentWeight = map["currentWeight"];
    this.height = map["height"];
  }

  Map<String, dynamic> toMap([bool isAlternate = false]) {
    var map = super.toMap(isAlternate);
    map["points"] = points;
    map["cheatPoints"] = cheatPoints;
    if (isAlternate) map["weekDate"] = weekDate.toString();
    map["bodyMassIndex"] = bodyMassIndex;
    map["currentWeight"] = currentWeight;
    map["height"] = height;
    return map;
  }
}
