import 'package:myfoodpoints/Models/BaseModel.dart';

class User extends BaseModel {
  User() : super();

  String displayText;
  String email;
  String profilePicturePath;
  DateTime signedIn;
  String metaData;
  String token;
  String firstName;
  String lastName;
  UserDevice userDevice;
 

  String get name {
    if (displayText != null && displayText.isNotEmpty) {
      return displayText.replaceAll(new RegExp(r'[^\w]+'), '');
    }
    return "";
  }

  User.fromMap(Map<String, dynamic> map, [bool isAlternate = false])
      : super.fromMap(map, isAlternate) {
    this.displayText = map["DisplayText"];
    this.email = map["Email"];
    if (map["SignedIn"] != null) {
      this.createDate = map["SignedIn"].toDate();
    }
    this.token = map["Token"];
    this.firstName = map["FirstName"];
    this.lastName = map["LastName"];
    //this.userDevices = map["UserDevices"];
  }

  Map<String, dynamic> toMap([bool isAlternate = false]) {
    var map = super.toMap(isAlternate);
    map["Name"] = name;
    map["DisplayText"] = displayText;
    map["Email"] = email;
    map["SignedIn"] = signedIn;
    if (isAlternate) map["SignedIn"] = signedIn.toString();
    map["Token"] = token;
    map["FirstName"] = firstName;
    map["LastName"] = lastName;
    return map;
  }
}

class UserDevice extends BaseModel {
  
  String deviceType;
  String deviceToken;
  String udId;
  String userId;

  UserDevice(this.deviceToken, this.userId): super();

  UserDevice.fromMap(Map<String, dynamic> map, [bool isAlternate = false])
      : super.fromMap(map, isAlternate) {
    this.deviceType = map["DeviceType"];
    this.deviceToken = map["DeviceToken"];
    this.udId = map["UDId"];
    this.userId = map["UserId"];
  }

  Map<String, dynamic> toMap([bool isAlternate = false]) {
    var map = super.toMap(isAlternate);
    map["DeviceType"] = deviceType;
    map["DeviceToken"] = deviceToken;
    map["UDId"] = udId;
    map["UserId"] = userId;
    return map;
  }
}
