import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> imgList = [
    'assets/front.jpg',
    'assets/Room1.jpg',
    'assets/Room2.jpg',
    'assets/Room3.jpg',
    'assets/view.jpg',
    'assets/roomview.jpg',
    'assets/Room4.jpg',
    'assets/cottage.jpg',
    'assets/comfortroom.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kandahar Cottages'),
        backgroundColor: Colors.brown[200],
        centerTitle: true,
        toolbarHeight: 110.0,

      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.brown[900],
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('My Profile'),
              onTap: () {
                // Handle the Search tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.history_sharp),
              title: Text('History'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle_outlined),
              title: Text('Account'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: Container(
              color: Colors.brown[700],
              child: Center(
                child: Text(
                  'HOME',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              '',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: imgList.map((item) => Container(
              child: Center(
                child: Image.asset(item, fit: BoxFit.cover, width: 1000),
              ),
            )).toList(),
          ),
          Center(
            child: Text(
              '',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'The KANDAHAR COTTAGES, owned by Ms. Neneth B. Lejano, and is located '
                    'at Matabungkay, Lian Batangas. It has 9 rooms, 2 of this is duplex '
                    'rooms, 3 couple rooms, 1 family rooms good for 20 persons, 1 family room '
                    'good for 10 persons and a presidential suite. It also have kubo’s that can '
                    'be rented by barkada’s for gathering and many other more vicinities that can '
                    'be explored. If the customer wants to explore or enjoy the beach they can '
                    'rent some aqua facilities like banana boat, sail boat, motor boat, aqua bike '
                    'and floating raft in the beach. And also they can rent a videoke. About '
                    'the safety of the customer the Manager of the Kandahar Cottages rent a life guard.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
              ),
            ),
          ),

          Center(
            child: Text(
              '',
              style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              'Kandahar Cottages',
              style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              'Matabungkay Lian, Batangas',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              '09057556578',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}