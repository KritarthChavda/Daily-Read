import 'dart:async';

import 'package:daily_read/screens/home_scree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.sizeOf(context).height * 1;
    // final width = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/splashmain.jpg',
              fit: BoxFit.cover,
              width: 320,
              height: 390,
            ),
            const SizedBox(
              height: 20,
            ),
            Text("Headlines",
                style: GoogleFonts.anton(
                    letterSpacing: 0.6, color: Colors.grey.shade700)),
            const SizedBox(
              height: 20,
            ),
            const SpinKitFoldingCube(
              color: Colors.blue,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}
