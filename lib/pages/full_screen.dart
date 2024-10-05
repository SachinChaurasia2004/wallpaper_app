import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

class FullScreen extends StatefulWidget {
  final String imagepath;
  const FullScreen({super.key, required this.imagepath});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  void _setWallpaper() async {
    var response = await Dio().get(widget.imagepath,
        options: Options(responseType: ResponseType.bytes));
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    Navigator.pop(context);
  }

  void _requestPermissions() async {
    // Request the permission to access photos (for Android 13+)
    var status = await Permission.photos.request();

    // Check if permission was granted
    if (status.isGranted) {
      _setWallpaper(); // Call your method to save the image
    } else if (status.isPermanentlyDenied) {
      // Open app settings if permission is permanently denied
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Permission permanently denied. Please enable it in the app settings.'),
          action: SnackBarAction(
            label: 'Open Settings',
            onPressed: () {
              openAppSettings();
            },
          ),
        ),
      );
    } else {
      // Handle the case where permission is denied temporarily
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission denied to access storage')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 60, left: 10, right: 10, bottom: 10),
        child: Stack(
          children: [
            Hero(
              tag: widget.imagepath,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: SizedBox.expand(
                  child: CachedNetworkImage(
                    imageUrl: widget.imagepath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: GestureDetector(
                onTap: _requestPermissions,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    color: Colors.black.withOpacity(0.7),
                    child: Text(
                      "Save Wallpaper",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
