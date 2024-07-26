import 'package:flutter/material.dart';
import 'package:kandahar/screens/confirmation.dart';

class Summary extends StatefulWidget {
  final DateTime reservationDate;

  Summary({Key? key, required this.reservationDate}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  Map<String, dynamic> bookingDetails = {
    'roomId': '123',
    'userId': '12-123',
    'roomName': 'Deluxe Room',
    'roomPrice': '3,200',
    'checkInDate': 'August 15, 2024',
    'checkInTime': '3:00 PM',
    'checkOutDate': 'August 18, 2024',
    'checkOutTime': '12:00 PM',

    'totalAmount': 3200,

  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Reservation Summary',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.brown[600],
        centerTitle: true,
        toolbarHeight: 110.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildSectionTitle('Guest Information'),
              _buildDetailRow('Name', bookingDetails['guestName']),
              _buildDetailRow('User Id', bookingDetails['12-123']),
              SizedBox(height: 20.0),
              _buildSectionTitle('Reservation Details'),
              _buildDetailRow('Room Id', bookingDetails['RoomId']),
              _buildDetailRow('Check-in Date', bookingDetails['checkInDate']),
              _buildDetailRow('Check-in Time', bookingDetails['checkInTime']),
              _buildDetailRow('Check-out Date', bookingDetails['checkOutDate']),
              _buildDetailRow('Check-out Time', bookingDetails['checkOutTime']),
              _buildDetailRow('Room Type', bookingDetails['roomType']),
              SizedBox(height: 20.0),
              _buildDetailRow('Total Amount', '\$${bookingDetails['totalAmount']}'),
              SizedBox(height: 20.0),

              // Button Section
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Confirmation(),
                    ),
                  );
                },
                child: Text(
                  'Confirm Reservation',
                  style: TextStyle(fontSize: 16.0),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  backgroundColor: Colors.brown[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}