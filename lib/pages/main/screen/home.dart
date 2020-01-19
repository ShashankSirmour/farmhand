import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:course_ripper/util/scroll/noglow.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  int item = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage("assets/images/tbunch.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.1),
        child: new ClipRect(
          child: new BackdropFilter(
            filter: new ImageFilter.blur(
              sigmaX: 20.0,
              sigmaY: 20.0,
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart', arguments: item);
                    },
                  ),
                ],
              ),
              body: Container(
                width: double.infinity,
                height: double.infinity,
                margin: const EdgeInsets.only(
                  bottom: 60,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "FARM-HAND",
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        left: 10,
                      ),
                      child: TabBar(
                        controller: tabController,
                        indicatorColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: Colors.white,
                        labelPadding: EdgeInsets.only(
                          right: 22,
                        ),
                        unselectedLabelColor: Colors.grey.withOpacity(0.6),
                        isScrollable: true,
                        tabs: <Widget>[
                          Text(
                            'Latest in Stock',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'About Us',
                            style: TextStyle(
                                fontSize: 17.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: <Widget>[
                          FireBaseBooks(
                            data: [null, null, null],
                            text: [
                              "Cherry Tomato ",
                              "Rama Tomato",
                              "Onion",
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Text(
                                "An Innovation To Remove The Interfare Of Any Middle Agency Between Customers And Farmer By Maximizing The Revenue With Prdiction Of Willigness to Pay And Changing Pricing Dynamically And After Month In Production Suggesting Them For Exact Time To Cultivate The Crop  ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  item++;
                                });
                              },
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              width: 50,
                              height: 50,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  item.toString() + " kg",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                if (item > 0)
                                  setState(() {
                                    item--;
                                  });
                              },
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FireBaseBooks extends StatefulWidget {
  final List<String> data;
  final List<String> text;
  const FireBaseBooks({Key key, this.data, this.text}) : super(key: key);

  @override
  _FireBaseBooksState createState() => _FireBaseBooksState();
}

class _FireBaseBooksState extends State<FireBaseBooks> {
  PageController pageController = PageController(viewportFraction: 0.9);

  int currentPage = 0;

  @override
  void initState() {
    pageController.addListener(() {
      int next = pageController.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: ScrollConfiguration(
              behavior: NoGlow(),
              child: PageView.builder(
                controller: pageController,
                itemCount: widget.data.length,
                itemBuilder: (BuildContext context, int index) {
                  bool active = index == currentPage;
                  bool left = index <= currentPage;
                  var snap = widget.data[index];

                  return buildBook(context, active, left, snap, index);
                },
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SingleChildScrollView(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width - 150),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Chip(
                        backgroundColor: Colors.greenAccent,
                        label: Text("Fresh"),
                      ),
                      SizedBox(width: 5),
                      Chip(
                        backgroundColor: Colors.green,
                        label: Text("organic"),
                      ),
                    ],
                  ),
                ),
                AutoSizeText(
                  widget.text[currentPage],
                  maxLines: 2,
                  minFontSize: 22,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white, fontSize: 30, fontFamily: "Agne"),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

Widget buildBook(
    BuildContext context, bool active, bool left, String b, int index) {
  BoxShadow shadow = BoxShadow(
    blurRadius: 20.0,
    offset: Offset(30, 20),
    color: Colors.black87,
    spreadRadius: 4,
  );

  return Container(
    color: Colors.transparent,
    margin: EdgeInsets.only(right: 40, bottom: 50),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        height: active ? 200 : 120,
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          boxShadow: [shadow],
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.contain,
            image: b != null
                ? CachedNetworkImageProvider(b)
                : AssetImage("assets/images/tomato.jpg"),
          ),
        ),
        alignment: Alignment.bottomLeft,
      ),
    ),
  );
}
