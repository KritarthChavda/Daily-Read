import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_read/screens/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:daily_read/models/headline_model.dart';
import 'package:daily_read/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterLists {
  bbcNews,
  aryNews,
  alJazeeraEnglish,
  bloomberg,
  businessInsider,
  cnn,
  espn,
  fortune,
  googleNews,
  hackerNews,
  newScientist
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  FilterLists? selectedMenu;
  final format = DateFormat('MMMM dd, yyyy');
  String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoriesScreen(),
                  ));
            },
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
          actions: [
            PopupMenuButton<FilterLists>(
              initialValue: selectedMenu,
              onSelected: (FilterLists item) {
                if (FilterLists.bbcNews.name == item.name) {
                  name = 'bbc-news';
                }
                if (FilterLists.aryNews.name == item.name) {
                  name = 'ary-news';
                }
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<FilterLists>>[
                const PopupMenuItem(
                  value: FilterLists.bbcNews,
                  child: Text("BBC"),
                ),
                const PopupMenuItem(
                  value: FilterLists.aryNews,
                  child: Text("Al Jazeera English"),
                ),
                const PopupMenuItem(
                  value: FilterLists.businessInsider,
                  child: Text("Business Insider"),
                ),
                const PopupMenuItem(
                  value: FilterLists.cnn,
                  child: Text("CNN"),
                ),
                const PopupMenuItem(
                  value: FilterLists.espn,
                  child: Text("Espn"),
                ),
                const PopupMenuItem(
                  value: FilterLists.fortune,
                  child: Text("Fortune"),
                ),
                const PopupMenuItem(
                  value: FilterLists.googleNews,
                  child: Text("Google News"),
                ),
                const PopupMenuItem(
                  value: FilterLists.hackerNews,
                  child: Text("Hacker News"),
                ),
                const PopupMenuItem(
                  value: FilterLists.newScientist,
                  child: Text("New Scientist"),
                )
              ],
            ),
          ],
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
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * 0.6,
                                width: width * 0.9,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: height * 0.02),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        child: const SpinKitChasingDots(
                                            color: Colors.amberAccent),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error_outline,
                                              color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    height: height * 0.13,
                                    alignment: Alignment.bottomCenter,
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * 0.7,
                                          child: Text(
                                              snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: width * 0.7,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                Text(format.format(dateTime),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ]),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
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
