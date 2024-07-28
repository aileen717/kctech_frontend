import 'package:flutter/material.dart';
import 'package:kandahar/screens/summary.dart';


void main() {
  runApp(MaterialApp(
    title: 'Booking Confirmation',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: Confirmation(),
  ));
}


class Confirmation extends StatefulWidget {

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Booking Confirmation',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.brown[600],
        centerTitle: true,
        toolbarHeight: 70.0,
      ),
      body: Expanded(
            child: Center(
              child: Card(
                color: Colors.brown[100],
                margin: EdgeInsets.all(20.0),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Thank you for your booking!',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20.0),
                      _buildConfirmationDetails(),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        ),
                        child: Text('GO BACK',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
      );
  }

  Widget _buildConfirmationDetails() {
    Map<String, dynamic> bookingDetails = {
      'guestName': 'Jessa Tenorio',
      'checkInDate': 'August 15, 2024',
      'checkOutDate': 'August 18, 2024',
      'roomType': 'Deluxe Room',
      'totalAmount': 450,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildDetailRow('Guest Name', bookingDetails['guestName']),
        _buildDetailRow('Check-in Date', bookingDetails['checkInDate']),
        _buildDetailRow('Check-out Date', bookingDetails['checkOutDate']),
        _buildDetailRow('Room Type', bookingDetails['roomType']),
        _buildDetailRow('Total Amount', '\$${bookingDetails['totalAmount']}'),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}

