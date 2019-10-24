class BaseModel {
  BaseModel();
  String id;
  DateTime createDate = DateTime.now().toUtc();
  DateTime modifiedDate;
  bool isActive = true;

  Map<String, dynamic> toMap([bool isAlternate = false]) {
    var map = new Map<String, dynamic>();
    if (id != null) {
      map["id"] = id;
    }
    map["CreateDate"] = createDate;
    map["ModifiedDate"] = modifiedDate;
    if (isAlternate) {
      map["CreateDate"] = createDate.toString();
      if (modifiedDate != null) {
        map["ModifiedDate"] = modifiedDate.toString();
      }
    }
    map["IsActive"] = isActive == null ? true : isActive;
    return map;
  }

  BaseModel.fromMap(Map<String, dynamic> map, [bool isAlternate = false]) {
    this.id = map["id"];
    if (map["CreateDate"] != null) {
      if (isAlternate) {
        this.createDate = DateTime.parse(map["CreateDate"]);
      } else {
        this.createDate = map["CreateDate"].toDate();
      }
    }
    if (map["ModifiedDate"] != null) {
      if (isAlternate)
        this.modifiedDate = DateTime.parse(map["ModifiedDate"]);
      else
        this.modifiedDate = map["ModifiedDate"].toDate();
    }
    this.isActive = isAlternate ? map["IsActive"] == 1 : map["isActive"];
  }
}
