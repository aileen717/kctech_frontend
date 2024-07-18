import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking Details',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Summary(),
    );
  }
}

class Summary extends StatefulWidget {
  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  Map<String, dynamic> bookingDetails = {
    'guestName': 'John Doe',
    'guestEmail': 'johndoe@example.com',
    'guestPhone': '+1234567890',
    'checkInDate': 'August 15, 2024',
    'checkInTime': '3:00 PM',
    'checkOutDate': 'August 18, 2024',
    'checkOutTime': '12:00 PM',
    'roomType': 'Deluxe Room',
    'numAdults': 2,
    'numChildren': 1,
    'specialRequests': 'Non-smoking room, Extra bed',
    'roomRate': 150,
    'numNights': 3,
    'additionalCharges': 0,
    'totalAmount': 450,
    'paymentMethod': 'Credit Card (Visa)',
    'paymentStatus': 'Paid',
    'transactionId': '#1234567890',
    'resortName': 'Kandahar Cottages',
    'resortAddress': '123 Resort Avenue, Beach City, State, ZIP',
    'resortPhone': '+9876543210',
    'resortEmail': 'info@kandaharcottages.com',
    'resortWebsite': 'www.kandaharcottages.com',
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
              _buildDetailRow('Email', bookingDetails['guestEmail']),
              _buildDetailRow('Phone Number', bookingDetails['guestPhone']),
              SizedBox(height: 20.0),
              _buildSectionTitle('Reservation Details'),
              _buildDetailRow('Check-in Date', bookingDetails['checkInDate']),
              _buildDetailRow('Check-in Time', bookingDetails['checkInTime']),
              _buildDetailRow('Check-out Date', bookingDetails['checkOutDate']),
              _buildDetailRow('Check-out Time', bookingDetails['checkOutTime']),
              _buildDetailRow('Room Type', bookingDetails['roomType']),
              _buildDetailRow('Number of Adults', bookingDetails['numAdults'].toString()),
              _buildDetailRow('Number of Children', bookingDetails['numChildren'].toString()),
              _buildDetailRow('Special Requests', bookingDetails['specialRequests']),
              SizedBox(height: 20.0),
              _buildSectionTitle('Total Charges'),
              _buildDetailRow('Room Rate per Night', '\$${bookingDetails['roomRate']}'),
              _buildDetailRow('Number of Nights', bookingDetails['numNights'].toString()),
              _buildDetailRow('Additional Charges', '\$${bookingDetails['additionalCharges']}'),
              _buildDetailRow('Total Amount', '\$${bookingDetails['totalAmount']}'),
              SizedBox(height: 20.0),
              _buildSectionTitle('Payment Information'),
              _buildDetailRow('Payment Method', bookingDetails['paymentMethod']),
              _buildDetailRow('Payment Status', bookingDetails['paymentStatus']),
              _buildDetailRow('Transaction ID', bookingDetails['transactionId']),
              SizedBox(height: 20.0),
              _buildSectionTitle('Contact Information'),
              _buildDetailRow('Resort Name', bookingDetails['resortName']),
              _buildDetailRow('Address', bookingDetails['resortAddress']),
              _buildDetailRow('Phone', bookingDetails['resortPhone']),
              _buildDetailRow('Email', bookingDetails['resortEmail']),
              _buildDetailRow('Website', bookingDetails['resortWebsite']),
              SizedBox(height: 20.0),

              // Button Section
              ElevatedButton(
                onPressed: () {
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
                    borderRadius: BorderRadius.circular(8.0),
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
