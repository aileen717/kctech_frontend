import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kandahar/screens/confirmation.dart';

class Summary extends StatefulWidget {
  final Map<String, dynamic> bookingDetails;
  Summary({Key? key, required this.bookingDetails}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState(bookingDetails: bookingDetails);
}

class _SummaryState extends State<Summary> {
  Map<String, dynamic> bookingDetails;

  _SummaryState({required this.bookingDetails});

  Future<String> getRoomName(int roomId) async{
    try{
      String apiUrl = 'http://10.0.2.2:8080/api/v1/room/name/${roomId.toString()}';

      final response = await http.get(Uri.parse(apiUrl));

      print(response.body);

      if (response.statusCode == 200) {
        // Successful reservation
        return response.body;
        // Navigate to success screen or handle accordingly
      }
      return '';

    }catch (e) {
      // Handle network errors
      print('Error: $e');
      return '';
      // Show error message to user or retry logic
    }
  }

  Future<bool> _makeReservation() async {
    try {
      const String apiUrl = 'http://10.0.2.2:8080/api/v1/reservation/new';

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // Add any necessary headers
        },
        body: jsonEncode(bookingDetails),
      );

      if (response.statusCode == 200) {
        // Successful reservation
        print('Reservation successful');
        return true;
        // Navigate to success screen or handle accordingly
      } else {
        // Handle other status codes
        print(
            'Failed to make reservation. Status code: ${response.statusCode}');
        return false;
        // Show error message to user or retry logic
      }
    } catch (e) {
      // Handle network errors
      print('Error making reservation: $e');
      return false;
      // Show error message to user or retry logic
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm'); // Customize format as needed
    return formatter.format(dateTime);
  }


  @override
  Widget build(BuildContext context) {
    print(bookingDetails);
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

              SizedBox(height: 20.0),
               _buildSectionTitle('Reservation Details'),
               _buildDetailRow('Room Id', bookingDetails['roomId'].toString()),
              _buildDetailRow(
                'Check-in Date',
                bookingDetails['checkInDate'] is DateTime
                    ? _formatDateTime(bookingDetails['checkInDate'])
                    : 'N/A',
              ),
              _buildDetailRow('Check-in Time', bookingDetails['checkInTime'].toString()),
              _buildDetailRow(
                'Check-out Date',
                bookingDetails['checkOutDate'] is DateTime
                    ? _formatDateTime(bookingDetails['checkOutDate'])
                    : 'N/A',
              ),
              _buildDetailRow('Check-out Time', bookingDetails['checkOutTime'].toString()),

              SizedBox(height: 20.0),

              ElevatedButton(
                onPressed: () {

                  _makeReservation().then((result){
                    if(result){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Confirmation(),
                        ),
                      );
                    }
                  });
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
