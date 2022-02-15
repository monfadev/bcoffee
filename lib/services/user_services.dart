part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection = FirebaseFirestore.instance.collection('users'); //Nama collection = users.

  static Future<void> updateUser(UserModel user) async {
    //Save to Firestore
    _userCollection.doc(user.id).set({
      'email': user.email,
      'name': user.name,
      'role': user.role,
      'profilePicture': user.profilePicture ?? "" //Kalau tidak input foto maka string kosong.
    });
  }

  ///Untuk mengambil dari Firestore
  static Future<UserModel> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();
    return UserModel(
      id,
      snapshot['email'],
      name: snapshot['name'],
      role: snapshot['role'],
      profilePicture: snapshot['profilePicture'],
    );
  }
}
