import 'package:flutter/material.dart';

class Bookings extends StatefulWidget {
  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  List<Map<String, dynamic>> transactions = [
    {
      'id': '1',
      'roomName': 'Deluxe Room',
      'reservationDate': '2024-07-14',
      'checkInDateTime': '2024-07-16T14:00:00',
      'checkOutDate': '2024-07-18',
      'checkOutTime': '11:00:00',
      'totalCost': 300.0,
      'status': 'Confirmed'
    },
    {
      'id': '2',
      'roomName': 'Standard Room',
      'reservationDate': '2024-07-13',
      'checkInDateTime': '2024-07-15T10:30:00',
      'checkOutDate': '2024-07-17',
      'checkOutTime': '10:00:00',
      'totalCost': 200.0,
      'status': 'Pending'
    },
    {
      'id': '3',
      'roomName': 'Single Room',
      'reservationDate': '2024-07-13',
      'checkInDateTime': '2024-07-15T10:30:00',
      'checkOutDate': '2024-07-17',
      'checkOutTime': '10:00:00',
      'totalCost': 200.0,
      'status': 'Pending'
    },
  ];

  List<Map<String, dynamic>> filteredTransactions = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredTransactions = transactions;
  }

  void _filterTransactions(String query) {
    final filtered = transactions.where((transaction) {
      return transaction['id'].contains(query) ||
          transaction['roomName'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      searchQuery = query;
      filteredTransactions = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Kandahar Cottages'),
        backgroundColor: Colors.brown[500],
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
                  'BOOKINGS',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by ID or Room Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: _filterTransactions,
            ),
          ),
          Expanded(
            child: filteredTransactions.isEmpty
                ? Center(child: Text('No transactions available.'))
                : ListView.builder(
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                final transaction = filteredTransactions[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text('Room: ${transaction['roomName']}', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reservation Date: ${transaction['reservationDate']}'),
                        Text('Check-in: ${DateTime.parse(transaction['checkInDateTime']).toLocal()}'),
                        Text('Check-out Date: ${transaction['checkOutDate']}'),
                        Text('Check-out Time: ${transaction['checkOutTime']}'),
                        Text('Total Cost: ₱${transaction['totalCost'].toStringAsFixed(2)}'),
                        Text('Status: ${transaction['status']}'),
                      ],
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Bookings(),
  ));
}
