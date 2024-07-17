import 'package:flutter/material.dart';

Future<List<DateTime>> fetchAvailableDates() async {
  await Future.delayed(Duration(seconds: 1));
  return List.generate(10, (index) => DateTime.now().add(Duration(days: index)));
}

class Bookings extends StatefulWidget {
  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  final _formKey = GlobalKey<FormState>();
  DateTime _reservationDate = DateTime.now();
  TimeOfDay _checkInTime = TimeOfDay.now();
  TimeOfDay _checkOutTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    fetchAvailableDates().then((dates) {
      setState(() {
        _reservationDate = dates.isNotEmpty ? dates[0] : DateTime.now();
      });
    });
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _reservationDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _reservationDate) {
      setState(() {
        _reservationDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, TimeOfDay initialTime, Function(TimeOfDay) onTimeSelected) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null && picked != initialTime) {
      onTimeSelected(picked);
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Booking successful!');
      print('Reservation Date: $_reservationDate');
      print('CheckIn Time: $_checkInTime');
      print('CheckOut Time: $_checkOutTime');
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
                  'BOOKING DETAILS',
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
                    ListTile(
                      title: Text("Date of Reservation: ${_reservationDate.toLocal().toString().split(' ')[0]}"),
                    ),
                    ListTile(
                      title: Text("CheckIn Time: ${_checkInTime.format(context)}"),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: () => _selectTime(context, _checkInTime, (picked) {
                        setState(() {
                          _checkInTime = picked;
                        });
                      }),
                    ),
                    ListTile(
                      title: Text("CheckOut Time: ${_checkOutTime.format(context)}"),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: () => _selectTime(context, _checkOutTime, (picked) {
                        setState(() {
                          _checkOutTime = picked;
                        });
                      }),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _submitForm,
                    child: Text('Continue'),
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[700], // Background color
                    foregroundColor: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    ),
                    ),
                  ]
                ),
              ),
    ),
    ),
    ]
            ),
          );

  }
}
