import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgly_sdk/imgly_sdk.dart';
import 'package:photo_editor_sdk/photo_editor_sdk.dart';

class image extends StatefulWidget {
  const image({Key? key}) : super(key: key);

  @override
  State<image> createState() => _imageState();
}

class _imageState extends State<image> {
  Configuration createConfiguration() {
    final flutterSticker = Sticker(
        "example_sticker_logos_flutter", "Flutter", "assets/Flutter-logo.png");
    final imglySticker = Sticker(
        "example_sticker_logos_imgly", "img.ly", "assets/IgorSticker.png");

    /// A completely custom category.
    final logos = StickerCategory(
        "example_sticker_category_logos", "Logos", "assets/Flutter-logo.png",
        items: [flutterSticker, imglySticker]);

    /// A predefined category.
    final emoticons =
        StickerCategory.existing("imgly_sticker_category_emoticons");

    /// A customized predefined category.
    final shapes =
        StickerCategory.existing("imgly_sticker_category_shapes", items: [
      Sticker.existing("imgly_sticker_shapes_badge_01"),
      Sticker.existing("imgly_sticker_shapes_arrow_02")
    ]);
    final categories = <StickerCategory>[logos, emoticons, shapes];
    final configuration = Configuration(
        sticker:
            StickerOptions(personalStickers: true, categories: categories));
    return configuration;
  }

  @override
  void initState() {
    super.initState();
  }

  imgFromGallery1(bool openWithConfig) async {
    final _image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (_image != null) {
      setState(() {
        imglyEditor(_image.path, openWithConfig);
      });
    }
  }

  imgFromGallery(bool openWithConfig) async {
    final _image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_image != null) {
      setState(() {
        imglyEditor(_image.path, openWithConfig);
      });
    }
  }

  imglyEditor(image, config) async {
    if (config == true) {
      await PESDK.openEditor(
          image: image, configuration: createConfiguration());
    } else {
      await PESDK.openEditor(image: image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text(' Photo Editor ')),
      ),
      body: SafeArea(
        child: Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(75),
              child: GestureDetector(
                 onTap: () => imgFromGallery1(true),
                  child: Icon(
                    Icons.camera_enhance_rounded,
                    size: 50,
                  )),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(75),
              child: GestureDetector(
                  onTap: () => imgFromGallery(true),
                  child: Icon(
                    Icons.image,
                    size: 50,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
