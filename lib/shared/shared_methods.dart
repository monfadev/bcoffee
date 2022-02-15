part of 'shared.dart';

//(newversion image_picker, but belum ubah plugin dan add androidmanifest(sesuai newversion on github me))
// Future<File> getImage() async {
//   final _picker = ImagePicker();
//   PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery);
//   if (pickedFile != null) {
//     File(pickedFile.path);
//   } else {
//     print('No Image Selected');
//   }
//   return File(pickedFile.path);
// }

///Method for image_picker.
// Future<File> getImage() async {
//   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//   return image;
// }

Future<File> getImage() async {
  final _picker = ImagePicker();
  PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    File(pickedFile.path);
  } else {
    print('No Image Selected');
  }
  return File(pickedFile.path);
}

///Future dengan type kembaliannya String, untuk download URLnya berupa string

Future<String> uploadImage(File image) async {
  //Mengambil nama file
  //Method basename adanya di import path/path.dart
  String fileName = basename(image.path);
  //StorageReference akan di arahkan ke FirebaseStorage, dengan nama childnya fileName.
  Reference ref = FirebaseStorage.instance.ref().child(fileName);
  //Setelah itu, reference diberi tugas untuk mengupload filenya.
  UploadTask task = ref.putFile(image);
  //Setelah melakukan upload, kita ambil kembaliannya, task.onComplete.
  TaskSnapshot snapshot = await task;

  //Download URL apabila di hover mengembalikan Future, maka di await.
  return await snapshot.ref.getDownloadURL();
}

var numberRupiah =
    NumberFormat.currency(locale: 'id-ID', symbol: 'Rp ', decimalDigits: 0);
