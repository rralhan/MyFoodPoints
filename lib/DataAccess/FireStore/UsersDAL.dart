import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfoodpoints/Models/User.dart';

final CollectionReference userCollection =
    Firestore.instance.collection('Users');
final CollectionReference userDeviceCollection =
    Firestore.instance.collection('UserDevices');

class UsersDAL {
  static final UsersDAL _instance = new UsersDAL.internal();

  factory UsersDAL() => _instance;

  UsersDAL.internal();

  void addUser(User user) {
    var docRef = userCollection.document();
    user.id = docRef.documentID;
    docRef
        .setData(user.toMap())
        .whenComplete(() => {print("user added")})
        .catchError((error) {
      print('error: $error');
    });
  }

  Future<User> getUserByEmail(String userEmail) async {
    var tUser = new User();
    tUser.email = userEmail;

    return userCollection
        .where("Email", isEqualTo: tUser.email)
        .getDocuments()
        .then((querySnapshot) {
      if (querySnapshot.documentChanges.length > 0) {
        var doc = querySnapshot.documents.first;
        return User.fromMap(doc.data);
      } else {
        return null;
      }
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Future<User> getUserByUserId(String userId) async {
    return userCollection
        .where("UserId", isEqualTo: userId)
        .getDocuments()
        .then((querySnapshot) {
      if (querySnapshot.documentChanges.length > 0) {
        var doc = querySnapshot.documents.first;
        return User.fromMap(doc.data);
      } else {
        return null;
      }
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getUserList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = userCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }




/*  Future<dynamic> updateUser(User user) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(userCollection.document(user.id));

      await tx.update(ds.reference, user.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .timeout(Duration(
            seconds:
                30)) //Make timeout configurable and figure out what happens when timeout happens
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });

     var docRef = userCollection.document(user.id);
    docRef.updateData(user.toMap())
    .whenComplete(() => {print("user added")})
    .catchError((error) {
      print('error: $error');
    }); 
 } */

  Future<bool> doesUserExist(String email) async {
    var user = await getUserByEmail(email);
    if (user != null) return true;
    return false;
  }

  void updateUser(User user) {
    var docRef = userCollection.document(user.id);
    docRef
        .updateData(user.toMap())
        .whenComplete(() => {print("user updated")})
        .catchError((error) {
      print('error: $error');
    });
  }

  Future<dynamic> deleteUser(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(userCollection.document(id));

      await tx.delete(ds.reference); //<RR> Never delete. Deactivate and update
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .timeout(Duration(
            seconds:
                20)) //Make timeout configurable and figure out what happens when timeout happens
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}

class UserDevicesDAL {
  void addUserDevice(UserDevice userDevice) {
    var docRef = userDeviceCollection.document();
    userDevice.id = docRef.documentID;
    docRef
        .setData(userDevice.toMap())
        .whenComplete(() => {print("user added")})
        .catchError((error) {
      print('error: $error');
    });
  }

  Future<UserDevice> getUserDeviceByUserId(String userId) async {
    return userDeviceCollection
        .where("UserId", isEqualTo: userId)
        .where("IsActive", isEqualTo: true)
        .getDocuments()
        .then((querySnapshot) {
      if (querySnapshot.documentChanges.length > 0) {
        var doc = querySnapshot.documents.first;
        return UserDevice.fromMap(doc.data);
      } else {
        return null;
      }
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  void deleteUserDevice(String userId) async {
    var qs = await userDeviceCollection
        .where("UserId", isEqualTo: userId)
        .where("IsActive", isEqualTo: true)
        .getDocuments();
    for (var docss in qs.documents) {
      docss.reference.updateData({'IsActive': false});
    }
  }
}
