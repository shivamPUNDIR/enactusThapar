import 'dart:typed_data';
import 'package:enactus_thapar/dataHolder.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  StorageReference photoref = FirebaseStorage.instance.ref().child("photos");

  Widget makeImageGrid() {
    return GridView.builder(
        itemCount: 6,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 12,
            childAspectRatio: .6),
        itemBuilder: (context, index) {
          return ImageGridItem(index: index);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GALLERY",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: makeImageGrid(),
        ),
      ),
    );
  }
}

class ImageGridItem extends StatefulWidget {
  final int index;

  ImageGridItem({this.index});
  @override
  _ImageGridItemState createState() => _ImageGridItemState();
}

class _ImageGridItemState extends State<ImageGridItem> {
  Uint8List imageFile;
  StorageReference photosReference =
      FirebaseStorage.instance.ref().child("photos");
  getImage() {
    if (!requestedIndexes.contains(widget.index)) {
      int maxSize = 7 * 1024 * 1024;
      photosReference
          .child("image_${(widget.index) + 1}.jpg")
          .getData(maxSize)
          .then((data) {
        this.setState(() {
          imageFile = data;
        });
        imageData.putIfAbsent(widget.index, () {
          return data;
        });
      }).catchError((error) {
        debugPrint("Error has occurred");
      });
      requestedIndexes.add(widget.index);
    }
  }

  Widget decideGridTileViewWidget() {
    if (imageFile == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Image.memory(
        imageFile,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (!imageData.containsKey(widget.index)) {
      getImage();
    } else {
      this.setState(() {
        imageFile = imageData[widget.index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: decideGridTileViewWidget(),
      ),
    );
  }
}
