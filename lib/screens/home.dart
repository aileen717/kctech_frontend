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
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'YourCustomFont', // Use your custom font family name here
            fontSize: 24.0,
          ),
        ),
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
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Kandahar Cottages'),
        backgroundColor: Colors.brown[600],
        centerTitle: true,
        toolbarHeight: 100.0,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: Container(
              color: Colors.brown[400],
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
              autoPlayAnimationDuration: Duration(seconds: 1),
              height: 270.0,
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
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'The KANDAHAR COTTAGES, owned by Ms. Neneth B. Lejano, and is located '
                    'at Matabungkay, Lian Batangas. It has 9 rooms, 2 of this is duplex '
                    'rooms, 3 couple rooms, 1 family rooms good for 20 persons, 1 family room '
                    'good for 10 persons and a presidential suite. It also have kubo’s that can '
                    'be rented by barkada’s for gathering and many other more vicinities that can '
                    'be explored. And also they can rent a videoke. About '
                    'the safety of the customer the Manager of the Kandahar Cottages rent a life guard.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
              ),
            ),
          ),

          SizedBox(height: 10.0,),
          Center(
            child: Text(
              'Kandahar Cottages',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
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
