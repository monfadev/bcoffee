part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUser extends UserEvent {
  final String id;

  LoadUser(this.id);

  @override
  List<Object> get props => [id];
}

class SignOut extends UserEvent {
  @override
  List<Object> get props => [];
}

//for movie_page.dart uploadimage
//untuk saat ini hanya meminta nama dan profileImage, karna yang dapat dibuah hanya nama dan profileImage
//email tidak dapat diubah
class UpdateData extends UserEvent {
  final String name;
  final String profileImage;

  UpdateData({this.name, this.profileImage});

  @override
  List<Object> get props => [name, profileImage];
}
