import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '206e4bd7f2d281b42179194a6cf40abe';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocation();
    print('This line of code is triggerd');
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    getData();
  }

  void getData() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    if (response.statusCode == 200) {
      String data = response.body;

      var decodeData = jsonDecode(data);

      double temperature = decodeData['main']['temp'];
      int condition = decodeData['weather'][0]['id'];
      String cityName = decodeData['name'];
      print(temperature);
      print(condition);
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
