import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/Admin/add_wallpaper.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _buildTextField(
      {required TextEditingController controller,
      required String hintText,
      bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintText';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onDoubleTap: () => Navigator.pop(context),
        child: SafeArea(
          child: Stack(
            children: [
              // Background Container with gradient
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 2),
                padding: EdgeInsets.only(top: 45, left: 20, right: 20),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                        MediaQuery.of(context).size.width, 110.0),
                  ),
                ),
              ),
              // Login Form
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 60),
                child: Form(
                  child: Column(
                    children: [
                      // Title Text
                      Text(
                        "Let's Start with Admin",
                        style: TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40),
                      // Form fields
                      Material(
                        elevation: 6.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 60),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            children: [
                              // Username TextField
                              _buildTextField(
                                controller: _usernameController,
                                hintText: "Username",
                              ),
                              SizedBox(height: 20),
                              // Password TextField
                              _buildTextField(
                                controller: _passwordController,
                                hintText: "Password",
                                obscureText: true,
                              ),
                              SizedBox(height: 20),
                              // Login Button
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Add login logic
                                    loginAdmin();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance
        .collection("Admin")
        .where("id", isEqualTo: _usernameController.text.toLowerCase().trim())
        .where("password",
            isEqualTo: _passwordController.text.toLowerCase().trim())
        .get()
        .then((snapshot) {
      if (snapshot.docs.isEmpty) {
        // No matching credentials found
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Invalid username or password",
            style: TextStyle(fontSize: 18.0),
          ),
        ));
      } else {
        // Successful login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddWallpaper()),
        );
      }
    }).catchError((error) {
      print("Error logging in: $error"); // Add this to log the error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "Error: ${error.toString()}",
          style: TextStyle(fontSize: 18.0),
        ),
      ));
    });
  }
}
