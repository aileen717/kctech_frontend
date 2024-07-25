import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kandahar/screens/summary.dart';

class Bookings extends StatefulWidget {
  final DateTime reservationDate;

  const Bookings({Key? key, required this.reservationDate}) : super(key: key);

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  final _formKey = GlobalKey<FormState>();
  DateTime _checkInDate = DateTime.now();
  TimeOfDay _checkInTime = TimeOfDay.now();
  DateTime _checkoutDate = DateTime.now().add(Duration(days: 1));
  TimeOfDay _checkOutTime = TimeOfDay.now();

  Future<void> selectCheckInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _checkInDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _checkInDate) {
      setState(() {
        _checkInDate = picked;
      });
    }
  }

  Future<void> _selectCheckOutDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _checkoutDate,
      firstDate: _checkInDate.add(Duration(days: 1)),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _checkoutDate) {
      setState(() {
        _checkoutDate = picked;
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
      print('CheckIn Date: $_checkInDate');
      print('CheckIn Time: $_checkInTime');
      print('Checkout Date: $_checkoutDate');
      print('CheckOut Time: $_checkOutTime');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Summary(reservationDate: widget.reservationDate),
        ),
      );
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
                      title: Text("Reservation Date: ${DateFormat('yyyy-MM-dd').format(widget.reservationDate)}"),
                      trailing: Icon(Icons.calendar_today),
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
                      title: Text("CheckOut Date: ${DateFormat('yyyy-MM-dd').format(_checkoutDate)}"),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () => _selectCheckOutDate(context),
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
                      child: Text('Reserve'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[700],
                        foregroundColor: Colors.white,
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