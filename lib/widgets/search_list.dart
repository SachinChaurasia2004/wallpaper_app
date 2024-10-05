import 'package:flutter/material.dart';
import 'package:tictactoe/models/photo_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tictactoe/pages/full_screen.dart';

Widget wallpaper(List<PhotosModel> photos, BuildContext context) {
  return photos.isEmpty
      ? Center(
          child: Text('No images Found'),
        )
      : Expanded(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 6),
              itemCount: photos.length,
              itemBuilder: (context, index) {
                // Access the portrait URL from the PhotosModel
                final PhotosModel photosModel = photos[index];
                final imageUrl = photosModel.src?.portrait;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FullScreen(imagepath: imageUrl)));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: GridTile(
                          child: Hero(
                        tag: photos,
                        child: CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error), // Handle null image case
                        ),
                      )),
                    ),
                  ),
                );
              }),
        );
}
