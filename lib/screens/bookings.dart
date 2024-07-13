import 'package:flutter/material.dart';

class Bookings extends StatefulWidget {
  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  DateTime _reservationDate = DateTime.now();
  DateTime _checkInDate = DateTime.now();
  DateTime _checkOutDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, DateTime initialDate, Function(DateTime) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != initialDate) {
      onDateSelected(picked);
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Booking successful!');
      print('Name: $_name');
      print('Email: $_email');
      print('Reservation Date: $_reservationDate');
      print('CheckIn Date: $_checkInDate');
      print('CheckOut Date: $_checkOutDate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kandahar Cottages'),
        backgroundColor: Colors.brown[600],
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
              color: Colors.brown[400],
              child: Center(
                child: Text(
                  'HOME',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Number of Guests'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a valid Number of Guests';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    ListTile(
                      title: Text("Date of Reservation: ${_reservationDate.toLocal().toString().split(' ')[0]}"),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: () => _selectDate(context, _reservationDate, (picked) {
                        setState(() {
                          _reservationDate = picked;
                        });
                      }),
                    ),
                    ListTile(
                      title: Text("CheckIn: ${_checkInDate.toLocal().toString().split(' ')[0]}"),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: () => _selectDate(context, _checkInDate, (picked) {
                        setState(() {
                          _checkInDate = picked;
                        });
                      }),
                    ),
                    ListTile(
                      title: Text("CheckOut: ${_checkOutDate.toLocal().toString().split(' ')[0]}"),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: () => _selectDate(context, _checkOutDate, (picked) {
                        setState(() {
                          _checkOutDate = picked;
                        });
                      }),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Book Room'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[700], // Background color
                        foregroundColor: Colors.white, // Text color
                        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}