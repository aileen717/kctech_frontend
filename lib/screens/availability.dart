import 'package:flutter/material.dart';
import 'package:kandahar/screens/bookingdetails.dart';
import 'package:table_calendar/table_calendar.dart';

class Availability extends StatefulWidget {

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
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
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
                    // Enable day if it doesn't have a reservation
                    return !_events.containsKey(day) || _events[day]!.isEmpty;
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

    return Container(
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
          ElevatedButton(
            onPressed: () {
              _showReservationDialog(day);
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
              ),
              minimumSize: MaterialStateProperty.all<Size>(
                Size(0, 0),
              ),
            ),
            child: Text(
              'Reserve',
              style: TextStyle(fontSize: 7.0),
            ),
          ),
        ],
      ),
    );
  }

  void _showReservationDialog(DateTime day) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Make Reservation'),
          content: Text(
              'Would you like to make a reservation for ${day.toLocal()}?'),
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
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Bookings(reservationDate: day),
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