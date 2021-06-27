import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIdx = 0;
  late List<Map<String, dynamic>> bottomNavbarItems;
  @override
  void initState() {
    currentIdx = 0;
    bottomNavbarItems = [
      {"icon": Icons.home, "title": 'Home'},
      {"icon": FontAwesomeIcons.fire, "title": 'Trending'},
      {"icon": Icons.subscriptions, "title": 'Subscriptions'},
      {"icon": Icons.email, "title": 'Email'},
      {"icon": Icons.folder, "title": 'Inbox'},
    ];

    super.initState();
  }

  List<Widget> appBarActionsIcons() {
    List<IconData> icons = [
      Icons.videocam,
      Icons.search,
      Icons.account_circle,
    ];
    return List.generate(
      icons.length,
      (i) => IconButton(
        icon: Icon(icons[i]),
        onPressed: null,
        color: Colors.black54,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: appBarActionsIcons(),
        leading: Icon(
          FontAwesomeIcons.youtube,
          color: Colors.red,
          size: 30,
        ),
        title: Text(
          "YouTube",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: buildDashboard(),
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(
          bottomNavbarItems.length,
          (i) => BottomNavigationBarItem(
            icon: Icon(bottomNavbarItems[i]["icon"]),
            label: bottomNavbarItems[i]["title"],
          ),
        ),
        backgroundColor: Colors.white,
        currentIndex: currentIdx,
        onTap: (idx) {
          setState(() {
            currentIdx = idx;
          });
        },
        selectedItemColor: Colors.red,
        selectedLabelStyle: TextStyle(color: Colors.red),
        unselectedItemColor: Colors.black87,
        unselectedLabelStyle: TextStyle(color: Colors.black87),
      ),
    );
  }

  Widget buildDashboard() {
    List<Videos> videos = [
      Videos(
          imagePath: "assets/images/youtube_one.jpg",
          title: "Lorem ipsum dolor sit amet",
          publisher: "Adarsh"),
      Videos(
          imagePath: "assets/images/youtube_one.jpg",
          title: "Lorem ipsum dolor sit amet",
          publisher: "Adarsh"),
      Videos(
          imagePath: "assets/images/youtube_one.jpg",
          title: "Lorem ipsum dolor sit amet",
          publisher: "Adarsh"),
    ];
    const TextStyle kStyle = TextStyle(
      color: Colors.black54,
    );

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          videos.length,
          (i) => Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                child: Image.asset(
                  videos[i].imagePath,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 45,
                      ),
                      //Horizontal Space
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            videos[i].title,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            videos[i].publisher,
                            style: kStyle,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                videos[i].views + "M views",
                                style: kStyle,
                              ),
                              Text(
                                ".",
                                style: kStyle,
                              ),
                              Text(
                                DateTime.now()
                                        .subtract(Duration(
                                          microseconds: videos[i]
                                              .publishedDate
                                              .microsecondsSinceEpoch,
                                        ))
                                        .day
                                        .toString() +
                                    " days ago",
                                style: kStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                        child: Icon(
                          Icons.more_vert,
                          size: 20,
                          color: Colors.black54,
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
}

class Videos {
  final String imagePath, title, publisher, views;
  final int likeCounts;
  final DateTime publishedDate;
  Videos({
    required this.imagePath,
    required this.title,
    required this.publisher,
  })  : this.publishedDate = DateTime(2021, 02, 13),
        this.views = (Random().nextInt(100) * 0.1).toStringAsPrecision(2),
        this.likeCounts = Random().nextInt(10);
}
