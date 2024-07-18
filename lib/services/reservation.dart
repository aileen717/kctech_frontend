import 'package:flutter/material.dart';

class Reservation {
  final int id;
  final int userAuthId;
  final int roomId;
  final DateTime checkInDate;
  final TimeOfDay checkInTime;
  final DateTime checkOutDate;
  final TimeOfDay checkOutTime;
  final double total;
  final bool reserved;
  final String status;

  Reservation({
    required this.id,
    required this.userAuthId,
    required this.roomId,
    required this.checkInDate,
    required this.checkInTime,
    required this.checkOutDate,
    required this.checkOutTime,
    required this.total,
    required this.reserved,
    required this.status,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      userAuthId: json['userAuthId'],
      roomId: json['roomId'],
      checkInDate: DateTime.parse(json['checkInDate']),
      checkInTime: TimeOfDay.fromDateTime(DateTime.parse(json['checkInTime'])),
      checkOutDate: DateTime.parse(json['checkOutDate']),
      checkOutTime: TimeOfDay.fromDateTime(DateTime.parse(json['checkOutTime'])),
      total: json['total'],
      reserved: json['reserved'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userAuthId': userAuthId,
      'roomId': roomId,
      'checkInDate': checkInDate.toIso8601String(),
      'checkInTime': '${checkInTime.hour}:${checkInTime.minute}',
      'checkOutDate': checkOutDate.toIso8601String(),
      'checkOutTime': '${checkOutTime.hour}:${checkOutTime.minute}',
      'total': total,
      'reserved': reserved,
      'status': status,
    };
  }
}
