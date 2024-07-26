import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';
import 'package:kandahar/services/Room.dart';
import 'package:kandahar/services/reservation.dart';

class Availability extends StatefulWidget {
  final Room room;

  const Availability({required this.room});

  @override
  _AvailabilityState createState() => _AvailabilityState();
}

class _AvailabilityState extends State<Availability> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<Event>> _events = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Kandahar Cottages'),
        backgroundColor: Colors.brown[500],
        centerTitle: true,
        toolbarHeight: 110.0,
      ),
      body: Column(
        children: [
          PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: Container(
              color: Colors.brown[300],
              child: Center(
                child: Text(
                  'Check Availability',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (selectedDay.isBefore(DateTime.now())) {
                      return;
                    }
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    _showReservationDialog(selectedDay);
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  eventLoader: (day) {
                    return _events[day] ?? [];
                  },
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      return _buildCalendarCell(day, focusedDay);
                    },
                    todayBuilder: (context, day, focusedDay) {
                      return _buildCalendarCell(
                          day, focusedDay, textColor: Colors.blue);
                    },
                    selectedBuilder: (context, day, focusedDay) {
                      return _buildCalendarCell(
                          day, focusedDay, textColor: Colors.red);
                    },
                  ),
                  rowHeight: 80,
                  enabledDayPredicate: (day) {
                    return (!_events.containsKey(day) || _events[day]!.isEmpty) &&
                        !day.isBefore(DateTime.now());
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarCell(DateTime day, DateTime focusedDay,
      {Color? textColor}) {
    final isSelected = isSameDay(_selectedDay, day);
    final isToday = isSameDay(DateTime.now(), day);

    return GestureDetector(
      onTap: () {
        _showReservationDialog(day);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              day.day.toString(),
              style: TextStyle(fontSize: 10.0, color: textColor ?? Colors.black),
            ),
            SizedBox(height: 2),
            if (isSelected)
              Container(
                width: 6.0,
                height: 6.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _createReservation(DateTime day) async {
    final url = 'http://10.0.2.2:8080/api/v1/reservation/new';
    final headers = {
      'Content-Type': 'application/json',
    };

    final reservation = Reservation(
      id: 0,
      userAuthId: 1,
      roomId: widget.room.id,
      checkInDate: day,
      checkInTime: TimeOfDay.now(),
      checkOutDate: day.add(Duration(days: 1)),
      checkOutTime: TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1),
      total: widget.room.price,
      status: 'Pending',
    );

    final body = jsonEncode(reservation.toJson());

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        setState(() {
          _makeReservation(day);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Reservation successful!'),
          ),
        );
      } else {
        // Print status code and response body for debugging
        print('Failed to make reservation. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to make reservation: ${response.body}'),
          ),
        );
      }
    } catch (e) {
      // Print the error for debugging
      print('Error: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  void _showReservationDialog(DateTime day) {
    if (day.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not Reserve!'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Make Reservation'),
          content: Text('Would you like to make a reservation for ${day.toLocal()}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _createReservation(day);
                Navigator.of(context).pop();
              },
              child: Text('Reserve'),
            ),
          ],
        );
      },
    );
  }

  void _makeReservation(DateTime day) {
    setState(() {
      if (_events[day] == null) {
        _events[day] = [];
      }
      _events[day]!.add(Event('Reservation'));
    });
  }
}

class Event {
  final String title;

  Event(this.title);
}
