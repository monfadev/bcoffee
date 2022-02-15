part of 'models.dart';

///Model untuk menyimpan User Registrasi
class RegistrationData {
  String email;
  String name;
  File profileImage; //Pilih Image dari device jadi type datanya File.
  String password;

  // final String id;
  // final String email;
  // final String name;
  // final String profilePicture;
  // final String role;

//Parameter Constructornya optional dengan value String kosong dan selectedGenres list kosong.
  RegistrationData(
      {this.email = "", this.name = "", this.profileImage, this.password = ""});
}
