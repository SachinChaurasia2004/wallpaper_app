import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/pages/full_screen.dart';
import 'package:tictactoe/services/database.dart';

class AllWallpapers extends StatefulWidget {
  final String category;
  const AllWallpapers({super.key, required this.category});

  @override
  State<AllWallpapers> createState() => _AllWallpapersState();
}

class _AllWallpapersState extends State<AllWallpapers> {
  Stream<QuerySnapshot>? categoryStream;

  // Properly handle Future to get Stream
  Future<void> getontheLoad() async {
    // Await the Future to get the Stream
    Stream<QuerySnapshot> stream =
        await DatabaseMethods().getCategory(widget.category);
    setState(() {
      categoryStream = stream; // Assign the Stream directly
    });
  }

  @override
  void initState() {
    super.initState();
    getontheLoad();
  }

  Widget allWallpaper() {
    return StreamBuilder<QuerySnapshot>(
      stream: categoryStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No wallpapers available"));
        }

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            crossAxisSpacing: 6.0,
            mainAxisSpacing: 6.0,
          ),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];
            String? imageUrl = ds["Image"];

            if (imageUrl == null || imageUrl.isEmpty) {
              // Skip item if image URL is missing or invalid
              return const SizedBox.shrink();
            }

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreen(imagepath: imageUrl),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GridTile(
                    child: Hero(
                      tag: imageUrl, // Use a unique identifier
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error), // Handle error
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: allWallpaper(),
    );
  }
}
