part of 'models.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String profilePicture;
  final String role;
  // final String historyPay;
  // final String statusPayment;

  UserModel(this.id, this.email, {this.name, this.role, this.profilePicture});

  UserModel copyWith({String name, String profilePicture}) => UserModel(
        this.id, this.email,
        //Name tersebut diambil dari name yang baru, tetapi kalau tidak diisi diambil dari name saat ini(default)
        name: name ?? this.name,
        profilePicture: profilePicture ?? this.profilePicture,
        //Kalau selectedGenres tetap, tidak dapat diubah, sesuai selected awal pada preference_page.dart
        role: role,
      );

  @override
  List<Object> get props => [
        id,
        email,
        name,
        role,
        profilePicture,
      ];
}
