import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/models/photo_model.dart';
import 'package:http/http.dart' as http;
import 'package:tictactoe/widgets/search_list.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<PhotosModel> photos = [];
  TextEditingController searchcontroller = TextEditingController();
  bool isLoading = false;
  bool search = false;

  Future<void> getSearchWallpaper(String searchQuery) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$searchQuery&per_page=30"),
        headers: {
          "Authorization":
              "hIedh4ooKUlIGWvgdZvOI0ioR7V4YiVtDj5uTfhzDzuWBd6CD6HhVimc"
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);

      jsonData["photos"].forEach((element) {
        PhotosModel photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });

      setState(() {
        isLoading = false;
        search = true;
      });
    } else {
      print("Failed to load wallpapers. Status code: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Search Wallpaper",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold))),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchcontroller,
              decoration: InputDecoration(
                fillColor: Color.fromARGB(159, 190, 184, 184),
                filled: true,
                suffixIcon: GestureDetector(
                    onTap: () {
                      getSearchWallpaper(searchcontroller.text.toString());
                    },
                    child: search
                        ? GestureDetector(
                            onTap: () {
                              photos.clear();
                              search = false;
                              setState(() {});
                            },
                            child: Icon(Icons.close))
                        : Icon(Icons.search)),
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          isLoading ? CircularProgressIndicator() : wallpaper(photos, context)
        ],
      ),
    );
  }
}
