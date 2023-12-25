import 'package:daily_read/models/headline_model.dart';
import 'package:daily_read/view_model/news_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Image.asset(
              "images/download.png",
              height: 30,
              width: 30,
            ),
          ),
          centerTitle: true,
          title: Text(
            textAlign: TextAlign.center,
            "Daily Read",
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          children: [
            Container(
              height: height * .45,
              width: width,
              child: FutureBuilder<HeadlineModel>(
                future: newsViewModel.fetchHeadlineApi(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SpinKitThreeBounce(
                      color: Colors.blue,
                      size: 40,
                    ));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    child: SpinKitChasingDots(
                                        color: Colors.amberAccent),
                                  ),
                                  errorWidget: (context, url, error) => Icon(
                                      Icons.error_outline,
                                      color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ));
  }
}
