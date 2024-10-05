import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tictactoe/Admin/admin_login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

// Use local asset images
final List<String> wallpapers = [
  'assets/images/image3.jpg',
  'assets/images/image2.jpg',
  'assets/images/image1.jpg',
];

class _HomeState extends State<Home> {
  int activeIndex = 0;

  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => AdminLogin())),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/images/man.png',
                height: 50,
                width: 50,
              ),
            ),
          ),
        ),
        title: Text("Wallify",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 45.0,
                    fontWeight: FontWeight.bold))),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 1.35,
                autoPlay: true,
                viewportFraction: 1,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: Duration(seconds: 2),
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
              items: wallpapers.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 10),
          AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: wallpapers.length,
            effect: JumpingDotEffect(
                dotWidth: 10,
                dotHeight: 10,
                activeDotColor: Colors.blueAccent,
                dotColor: Colors.grey),
            onDotClicked: (index) {
              _carouselController.animateToPage(index);
            },
          )
        ],
      ),
    );
  }
}
