import 'package:diaryapp/functions/image_widget_list_creator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../datamodels/entry.dart';

class AddImage extends StatefulWidget {
  final Entry entry;
  final ValueNotifier<List<String>> imagenotifier;

  const AddImage({super.key, required this.entry, required this.imagenotifier});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  late Entry entry;
  late ValueNotifier<List<String>> imagenotifier;

  @override
  void initState() {
    super.initState();
    entry = widget.entry;
    imagenotifier = widget.imagenotifier;
  }

  @override
  Widget build(BuildContext context) {
    final ImagePicker imagePicker = ImagePicker();
    List<XFile>? imageFileList = [];

    imagenotifier = ValueNotifier(entry.images);

    List<Widget> imagewidget = imagewidgetlist(
      entry.images,
      (index) {
        entry.images.removeAt(index);
        imagenotifier.value = [...entry.images];
        setState(() {});
      },
    );

    void selectImages() async {
      final List<XFile> selectedImages = await imagePicker.pickMultiImage();

      if (selectedImages.isNotEmpty) {
        imageFileList.addAll(selectedImages);
      }
      imagenotifier.value.addAll(imageFileList.map((e) => e.path).toList());

      imagewidget = imagewidgetlist(entry.images, (index) {
        entry.images.removeAt(index);
        List<String> images = entry.images;
        imagenotifier.value = [...images];
      });
      setState(() {});
      // entry.images.addAll(entry.images);
    }

    return ValueListenableBuilder(
        valueListenable: imagenotifier,
        builder: (context, val, child) {
          return GridView(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(4),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4),
            children: [
              ...imagewidget,
              GestureDetector(
                onTap: selectImages,
                child: Image.asset('assets/images/image.png'),
              ),
            ],
          );
        });
  }
}

// Widget addimage(Entry entry ,ValueNotifier<List<String>> imagenotifier) {
//   final ImagePicker imagePicker = ImagePicker();
//   List<XFile>? imageFileList = [];

//   imagenotifier = ValueNotifier(entry.images);

//   List<Widget> imagewidget = imagewidgetlist(entry.images,(index) {
//     print(index);
//     entry.images.removeAt(index);
//    imagenotifier.value=[...entry.images];
//   },);

//   void selectImages() async {
//     final List<XFile> selectedImages = await imagePicker.pickMultiImage();
//     if (selectedImages.isNotEmpty) {
//       imageFileList.addAll(selectedImages);
//     }
//     entry.images.addAll(imageFileList.map((e) => e.path).toList()) ;
//     imagewidget = imagewidgetlist(entry.images,(index) {
//     entry.images.removeAt(index);
//       List<String> images = entry.images;
//    imagenotifier = ValueNotifier(images);
//   });
//     imagenotifier.value.addAll(entry.images);

//   }

//   return ValueListenableBuilder(
//       valueListenable: imagenotifier,
//       builder: (context, val, child) {
//         return GridView(
//           shrinkWrap: true,
//           primary: false,
//           padding: const EdgeInsets.all(4),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 4),
//           children: [
//             ...imagewidget,
//             GestureDetector(
//               onTap: selectImages,
//               child: Image.asset('assets/images/image.png'),
//             ),
//           ],
//         );
//       });
// }
