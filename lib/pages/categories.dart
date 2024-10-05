import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/pages/all_wallpapers.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 50,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text("Categories",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold))),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          PhotoBox(imagepath: 'assets/images/ocean.jpg', text: 'Wildlife'),
          PhotoBox(imagepath: 'assets/images/city.jpg', text: 'City'),
          PhotoBox(imagepath: 'assets/images/food.jpg', text: 'Food'),
          PhotoBox(imagepath: 'assets/images/nature.jpg', text: 'Nature'),
        ]))
      ],
    ));
  }
}

class PhotoBox extends StatelessWidget {
  final String imagepath;
  final String text;

  const PhotoBox({super.key, required this.imagepath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllWallpapers(category: text)));
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      imagepath,
                      width: MediaQuery.of(context).size.width, // Full width
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
