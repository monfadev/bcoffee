part of 'shared.dart';

///Class ini dapat diasumsikan untuk menghentikan authentication pages pada firebase
///yang 2 kali page atau mengulang ke page yang sama (exception)
///di inisiasinya pada file wrapper.dart
PageEvent prevPageEvent;

///Class ini untuk menitipkan upload profileImage dari pages/account_confirmation_page.dart
File imageFileToUpload;