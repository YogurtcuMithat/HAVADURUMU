import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hava_durumu_app_v1/utils/weather.dart';

class MainScreen extends StatefulWidget {

  final WeatherData weatherData;

  MainScreen({@required this.weatherData});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int temperature;
  Icon weatherDisplayIcon;
  AssetImage backgroundImage;
  String city;
  void updateDisplayInfo(WeatherData weatherData){
    setState(() {
      temperature = weatherData.currentTemperature.round();
      city = weatherData.city;
      WeatherDisplayData weatherDisplayData = weatherData.getWeatherDisplayData();
      backgroundImage = weatherDisplayData.weatherImage;
      weatherDisplayIcon = weatherDisplayData.weatherIcon;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }
 //region Ekran text
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20,),
            Container(
              child: weatherDisplayIcon,
              padding: EdgeInsets.all(15),
            ),
            SizedBox(height: 5,),
            Center(
              child: Text('$temperature°',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 80.0,
                    letterSpacing: -8
                ),
              ),
            ),
            SizedBox(height: 5,),
            Center(
              child: Text(city,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow( offset: Offset(0.4, 0.4), blurRadius: 1, color: Colors.purple,),
                      Shadow( offset: Offset(3, 3), blurRadius: 3, color: Colors.black87,),
                    ],
                    letterSpacing: 5
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  //endregion
}