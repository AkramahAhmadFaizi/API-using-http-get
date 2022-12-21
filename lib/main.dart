import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:core';


void main() => runApp(MaterialApp(
  home: HomePage(),
));

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url = "https://reqres.in/api/users";
  late List data;

  @override
  void initState(){
    super.initState();
    getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
      //Encode the url to remove spaces
        Uri.parse(url),
        //only accept json response
      headers: {"Accept": "application/json"}
    );

   print(response.body);

    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson['data'];
    });
    return "Success";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retrive Json via HTTP Get"),
      ),
      body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (_, int index){
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Container(
                      color: Colors.tealAccent[200],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("email : "+data[index]['email']),
                          Text("first : "+data[index]['first_name']),
                          Text("last : " +data[index]['last_name']),
                        ],
                      ),
                      padding: const EdgeInsets.all(10.0),
                    ),
                  )
                ],
              )

            );
          }
      ),
    );
  }
}
