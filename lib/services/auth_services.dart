part of 'services.dart';

///Ini class services untuk Sign Up, Sign In, Sign Out
class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  ///Method Sign Up parameter email, password, name, number
  static Future<SignInSignUpResult> signUp(
      String email, String password, String name,
      {String role = "user"}) async {
    try {
      //try(coba), jika ada error maka langsung catch(menangkap) message.e
      //createUserWithEmailAndPassword apabila di Hover ia mengembalikan AuthResult.
      //Didalam result line 14, mengembalikan objek user.
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //Kalau firebaseAuth berhasil maka kita akan membuat lagi data user di Firestore
      //Semua data email,password,name,selectedgenre/language akan tersimpan di Firestore
      //Convert firebaseUser menjadi User

      //Membuat model user sebelum ke line bawah ini.
      UserModel user = result.user.convertToUser(
          name: name,
          role: role); //Setelah menjadi user baru kirim ke Firestore

      await UserServices.updateUser(user ?? "Not Available");

      return SignInSignUpResult(user: user ?? "Not Available");
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1]);
      //PlatformException(ERROR_WRONG_PASSWORD, The password is invalid or the user does not have a password., null, null)
      //.split(,)[1] ialah berdasarkan koma(,) mengambil array index ke-1 agar di console show the password...
    }
  }

  ///Method signIn parameter email dan password
  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      //Membuat user dari firebase user di result line 38, maka membuat extension lagi
      UserModel user = await result.user.fromFireStore() ?? "Not Available";

      return SignInSignUpResult(user: user ?? "Not Available");
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split(',')[1]);
      //PlatformException(ERROR_WRONG_PASSWORD, The password is invalid or the user does not have a password., null, null)
      //.split(,)[1] ialah berdasarkan koma(,) mengambil array index ke-1 agar di console show the password...
    }
  }

  ///Method signOut
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  ///Method resetPassword
  static Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  ///Ini authentication/sharedpreferences dari Firebase, sudah memiliki Stream
  ///_auth.onAuthStateChanged ini yang akan memberitahukan jika ada perubahan status di authentication
  static Stream<User> get userStream => _auth.authStateChanges() ?? "";
}

///Class for try catch
class SignInSignUpResult {
  final UserModel user;
  final String message;

  SignInSignUpResult({this.user, this.message});
}
