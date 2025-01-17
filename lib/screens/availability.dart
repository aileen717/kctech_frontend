import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'bookingdetails.dart';

class Availability extends StatefulWidget {
  final int roomId;
  const Availability({required this.roomId});

  @override
  _AvailabilityState createState() => _AvailabilityState(roomId: roomId);
}

class _AvailabilityState extends State<Availability> {
  late final DateTime reservationDate;
  final int roomId;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<Event>> _events = {};

  _AvailabilityState({required this.roomId});

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
                _makeReservation(day);
                Map<String, dynamic> roomAndDate = {
                  'roomId': roomId,
                  'checkInDate': day,  // Changed from 'date' to 'checkInDate'
                };
                print(roomAndDate);
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Bookings(roomAndDate: roomAndDate),
                  ),
                );
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