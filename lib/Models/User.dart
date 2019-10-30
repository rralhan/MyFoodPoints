import 'package:myfoodpoints/Models/BaseModel.dart';
import 'package:myfoodpoints/Models/UserProfile.dart';

class User extends BaseModel {
  User() : super();

  String name;
  String email;
  DateTime signedIn;
  String metaData;
  String token;
  UserDevice userDevice;
  bool hasAcceptedTerms;
  UserProfile userProfile;
  String referenceUserId;

  String get nameAbbr {
    if (name != null && name.isNotEmpty) {
      return name.replaceAll(new RegExp(r'[^\w]+'), '');
    }
    return "";
  }

  User.fromMap(Map<String, dynamic> map, [bool isAlternate = false])
      : super.fromMap(map, isAlternate) {
    this.name = map["name"];
    this.email = map["email"];
    if (map["signedIn"] != null) {
      this.createDate = map["signedIn"].toDate();
    }
    this.token = map["token"];
    this.userDevice = map["userDevice"];
    this.userProfile = map["userProfile"];
  }

  Map<String, dynamic> toMap([bool isAlternate = false]) {
    var map = super.toMap(isAlternate);
    map["name"] = name;
    map["nameAbbr"] = nameAbbr;
    map["email"] = email;
    map["signedIn"] = signedIn;
    if (isAlternate) map["signedIn"] = signedIn.toString();
    map["token"] = token;
    map["hasAcceptedTerms"] = hasAcceptedTerms;
    map["userProfile"] = userProfile;
    map["userDevice"] = userDevice;
    return map;
  }
}

class UserDevice extends BaseModel {
  UserDevice(this.deviceToken, this.userId) : super();

  String deviceType;
  String deviceToken;
  String udId;
  String userId;

  UserDevice.fromMap(Map<String, dynamic> map, [bool isAlternate = false])
      : super.fromMap(map, isAlternate) {
    this.deviceType = map["deviceType"];
    this.deviceToken = map["deviceToken"];
    this.udId = map["udId"];
    this.userId = map["userId"];
  }

  Map<String, dynamic> toMap([bool isAlternate = false]) {
    var map = super.toMap(isAlternate);
    map["deviceType"] = deviceType;
    map["deviceToken"] = deviceToken;
    map["udId"] = udId;
    map["userId"] = userId;
    return map;
  }
}
