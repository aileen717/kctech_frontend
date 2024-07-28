import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kandahar/screens/summary.dart';

class Bookings extends StatefulWidget {
  final Map<String, dynamic> roomAndDate;
  const Bookings({Key? key, required this.roomAndDate}) : super(key: key);

  @override
  State<Bookings> createState() => _BookingsState(roomAndDate: roomAndDate);
}

class _BookingsState extends State<Bookings> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> roomAndDate;
  late DateTime _checkInDate;
  TimeOfDay _checkInTime = TimeOfDay.now();
  late DateTime _checkoutDate;
  TimeOfDay _checkOutTime = TimeOfDay.now();

  _BookingsState({required this.roomAndDate}) {
    _checkInDate = roomAndDate['checkInDate'] as DateTime;
    _checkoutDate = _checkInDate.add(Duration(days: 1));
  }

  DateTime _timeOfDayToDateTime(TimeOfDay timeOfDay, DateTime referenceDate) {
    return DateTime(
      referenceDate.year,
      referenceDate.month,
      referenceDate.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }

  String _formatTime(TimeOfDay timeOfDay) {
    final dateTime = _timeOfDayToDateTime(timeOfDay, DateTime.now());
    return DateFormat.Hm().format(dateTime);
  }

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
        _checkoutDate = _checkInDate.add(Duration(days: 1));
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
    Map<String, dynamic> bookingDetails = {
      'roomId': roomAndDate['roomId'],
      'checkInDate': _checkInDate,
      'checkInTime': _checkInTime,
      'checkOutDate': _checkoutDate,
      'checkOutTime': _checkOutTime,
    };
    print(bookingDetails);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Summary(bookingDetails: bookingDetails),
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
                      title: Text("Check-In Date: ${DateFormat('yyyy-MM-dd').format(_checkInDate)}"),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () => selectCheckInDate(context),
                    ),
                    ListTile(
                      title: Text("Check-In Time: ${_formatTime(_checkInTime)}"),
                      trailing: Icon(Icons.keyboard_arrow_down),
                      onTap: () => _selectTime(context, _checkInTime, (picked) {
                        setState(() {
                          _checkInTime = picked;
                        });
                      }),
                    ),
                    ListTile(
                      title: Text("Check-Out Date: ${DateFormat('yyyy-MM-dd').format(_checkoutDate)}"),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () => _selectCheckOutDate(context),
                    ),
                    ListTile(
                      title: Text("Check-Out Time: ${_formatTime(_checkOutTime)}"),
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