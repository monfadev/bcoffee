import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bcoffee/models/models.dart';
import 'package:bcoffee/services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    ///Kalau event nya adalah LoadUser maka ambil data dari FireStore
    if (event is LoadUser) {
      UserModel user = await UserServices.getUser(event.id);

      ///Setelah diatas berhasil, kembalikan usernya
      yield UserLoaded(user);
    } else if (event is SignOut) {
      yield UserInitial();
      //Kalau eventnya itu adalah UpdateData
    } else if (event is UpdateData) {
      //Maka akan dibuat updateUser (user yang baru) itu dari state saat ini sebagai UserLoaded, karna sudah pasti UserLoaded kalau sudah di main_page.dart(dalem)
      UserModel updatedUser = (state as UserLoaded).user.copyWith(
            name: event.name,
            profilePicture: event.profileImage,
          );

      await UserServices.updateUser(
          updatedUser); //untuk updateuser agar profileImage terupdate di firestore

      yield UserLoaded(updatedUser);
    }
  }
}