import 'package:image_picker/image_picker.dart';

Future<String> pickImage() async {
  final ImagePicker picker = ImagePicker();
  XFile? pickedImage =
      await picker.pickImage(source: ImageSource.gallery, imageQuality: 20);
  return pickedImage!.path;
}

Map<String, dynamic> map = {'hh': 11, 'gdhs': 2341};
