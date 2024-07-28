import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:kandahar/screens/confirmation.dart';

class Summary extends StatefulWidget {
  final Map<String, dynamic> bookingDetails;

  Summary({Key? key, required this.bookingDetails}) : super(key: key);

  @override
  State<Summary> createState() => _SummaryState(bookingDetails: bookingDetails);
}

class _SummaryState extends State<Summary> {
  Map<String, dynamic> bookingDetails;
  double? roomPrice;

  _SummaryState({required this.bookingDetails});

  @override
  void initState() {
    super.initState();
    _fetchRoomPrice();
  }

  Future<void> _fetchRoomPrice() async {
    final roomId = bookingDetails['roomId'];
    if (roomId != null) {
      try {
        final response = await http
            .get(Uri.parse('http://10.0.2.2:8080/api/v1/room/$roomId'));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            roomPrice = (data['price'] as num).toDouble();
          });
        } else {
          print(
              'Failed to fetch room price. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching room price: $e');
      }
    }
  }

  DateTime get _checkInDate => bookingDetails['checkInDate'] as DateTime;

  DateTime get _checkOutDate => bookingDetails['checkOutDate'] as DateTime;

  double _calculateTotal() {
    if (roomPrice == null) return 0.0;
    final daysOfStay = _calculateDaysOfStay();
    return roomPrice! * daysOfStay;
  }

  int _calculateDaysOfStay() {
    return _checkOutDate.difference(_checkInDate).inDays;
  }

  Future<bool> _makeReservation() async {
    try {
      const String apiUrl = 'http://10.0.2.2:8080/api/v1/reservation/new';

      final formattedBookingDetails = _convertDateTimeValues(bookingDetails);
      final total = _calculateTotal();
      formattedBookingDetails['total'] = total;

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(formattedBookingDetails),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        print('Server response: $responseBody');
        return responseBody == 'A new reservation is created.';
      } else {
        print(
            'Failed to make reservation. Status code: ${response.statusCode}');
        print('Server response: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error making reservation: $e');
      return false;
    }
  }

  Map<String, dynamic> _convertDateTimeValues(Map<String, dynamic> details) {
    final result = <String, dynamic>{};

    details.forEach((key, value) {
      if (value is DateTime) {
        result[key] =
            value.toIso8601String(); // Convert DateTime to ISO 8601 string
      } else if (value is TimeOfDay) {
        result[key] = _formatTimeOfDay(value); // Convert TimeOfDay to string
      } else if (value is Map<String, dynamic>) {
        result[key] =
            _convertDateTimeValues(value); // Recursively handle nested maps
      } else {
        result[key] = value; // Copy other values as is
      }
    });

    return result;
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    final formatter = DateFormat('HH:mm');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final formattedBookingDetails = _convertDateTimeValues(bookingDetails);
    final total = _calculateTotal();

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
              _buildDetailRow('Room Id',
                  formattedBookingDetails['roomId']?.toString() ?? 'N/A'),
              _buildDetailRow('Check-in Date',
                  formattedBookingDetails['checkInDate'] ?? 'N/A'),
              _buildDetailRow('Check-in Time',
                  formattedBookingDetails['checkInTime'] ?? 'N/A'),
              _buildDetailRow('Check-out Date',
                  formattedBookingDetails['checkOutDate'] ?? 'N/A'),
              _buildDetailRow('Check-out Time',
                  formattedBookingDetails['checkOutTime'] ?? 'N/A'),
              _buildDetailRow(
                  'Total Price',
                  roomPrice == null
                      ? 'Fetching...'
                      : '\₱${total.toStringAsFixed(2)}'),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: roomPrice == null
                    ? null
                    : () {
                        _makeReservation().then((result) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Confirmation(),
                            ),
                          );
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
