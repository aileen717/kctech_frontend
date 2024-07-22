import 'dart:convert';

import 'package:kandahar/services/menuCard.dart';
import 'package:flutter/material.dart';
import 'package:kandahar/services/Room.dart';
import 'package:kandahar/screens/selectedRoom.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Menu extends StatefulWidget {
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late Future<List<Room>> rooms;
  Future <List<Room>> fetchData() async{
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/api/v1/room/all')
    );
    final List<dynamic> data = jsonDecode(response.body);
    List<Room> rooms = [];
    for(var room in data){
      rooms.add(Room.fromJson(room));
    }

    return rooms;
  }

  @override
  void initState() {
    rooms = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[600],
        foregroundColor: Colors.white,
        title: Text(
          'Rooms',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            color: Colors.black,

          ),
        ),
        centerTitle: true,

      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: FutureBuilder(
              future: rooms,
              builder: (BuildContext context, snapshots){
                if(snapshots.connectionState == ConnectionState.waiting){
                  return Center(
                    child: SpinKitThreeBounce(
                      color: Colors.brown[500],
                      size: 60.0,
                    ),
                  );
                }
                if(snapshots.hasData) {
                  List? rooms = snapshots.data! as List?;
                  return Padding(
                    padding: EdgeInsets.all(3.0),
                    child: ListView.builder(
                        itemCount: rooms!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.brown[300],
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    rooms[index].name,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(rooms[index].price.toString()),
                                ],
                              ),
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Selectedroom(room: rooms[index]),
                                    )
                                );
                              },

                            ),
                          );
                        }
                    ),
                  );
                }
                return Center(
                  child: Text('Unable to load data'),
                );
              }
          )
      ),
    );
  }
}