import 'package:flutter/material.dart';
import 'package:kandahar/screens/availability.dart';
import 'package:kandahar/screens/bookingdetails.dart';
import 'package:kandahar/services/Room.dart';


class Selectedroom extends StatefulWidget {
  final Room room;
  const Selectedroom({required this.room});

  @override
  State<Selectedroom> createState() => _SelectedroomState(room: room);
}

class _SelectedroomState extends State<Selectedroom> {
  final Room room;
  late double totalAmount;
  int numberOfOrders = 1;

  _SelectedroomState({required this.room});


  @override
  void initState() {
    super.initState();
    totalAmount = room.price;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Selected Room'),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
        color: Colors.brown[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  Image.network(widget.room.url),
                  Text(
                    widget.room.name,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.room.pax,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.room.price.toString(),
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                  MaterialPageRoute(
                    builder: (context) => Availability(),
                  ),
                  );
                },
                child: Text('Check Availability'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[300],
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                ),
              ),
            ),
              ],
            )
        ),
    );
  }
}