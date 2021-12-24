import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'location.dart';

  //region API KEY
const apiKey = "6e99bc1b3807a870a0821eeca272b244"; //endregion
class WeatherDisplayData{
  Icon weatherIcon;
  AssetImage weatherImage;
  WeatherDisplayData({@required this.weatherIcon, this.weatherImage});
}


class WeatherData{

  //region OPENWEATHER API BAGLANTI VE ISLEMLER
  WeatherData({@required this.locationData});
  LocationHelper locationData;
  double currentTemperature;
  int currentCondition;
  String city;

  Future<void> getCurrentTemperature() async{
    Response response = await get("http://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric");

    if(response.statusCode == 200){
      String data = response.body;
      var currentWeather = jsonDecode(data);

      try{
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        city = currentWeather['name'];
        print("şehir: " +city);
        print("Durum : " + currentCondition.toString());
      }catch(e){
        print(e);
      }
    }
    else{
      print("API den değer gelmiyor!");
    }
  }
  //endregion

  //region background
  WeatherDisplayData getWeatherDisplayData(){
    var now = new DateTime.now();
    if(now.hour<=18 && now.hour >=07){
      if(currentCondition>=200 && currentCondition<=232){
      return WeatherDisplayData(
          weatherIcon: Icon(
              FontAwesomeIcons.pooStorm,
              size: 75.0,
              color: Colors.white
          ),
          weatherImage: AssetImage('assets/storm.png'));
      }
      else if(currentCondition>=300 && currentCondition<=321){
        return WeatherDisplayData(
            weatherIcon: Icon(
                FontAwesomeIcons.cloudSunRain,
                size: 75.0,
                color: Colors.white
            ),
            weatherImage: AssetImage('assets/rain.png'));
      }
      else if(currentCondition>=500 && currentCondition<=531){
        return WeatherDisplayData(
            weatherIcon: Icon(
                FontAwesomeIcons.cloudRain,
                size: 75.0,
                color: Colors.white
            ),
            weatherImage: AssetImage('assets/rain.png'));
      }
      else if(currentCondition>=600 && currentCondition<=622){
        return WeatherDisplayData(
            weatherIcon: Icon(
                FontAwesomeIcons.snowman,
                size: 75.0,
                color: Colors.white
            ),
            weatherImage: AssetImage('assets/snow.png'));
      }
      else if(currentCondition>=801 && currentCondition<=804){
        return WeatherDisplayData(
            weatherIcon: Icon(
                FontAwesomeIcons.cloud,
                size: 75.0,
                color: Colors.white
            ),
            weatherImage: AssetImage('assets/cloud.png'));
      }
      else if(currentCondition==800){
        return WeatherDisplayData(
            weatherIcon: Icon(
                FontAwesomeIcons.solidSun,
                size: 75.0,
                color: Colors.white
            ),
            weatherImage: AssetImage('assets/after_noon.png'));
      }
      else return WeatherDisplayData(weatherImage: AssetImage('assets/after_noon.png'));
    }
    else {
      return WeatherDisplayData(
          weatherIcon: Icon(
              FontAwesomeIcons.sun,
              size: 75.0,
              color: Colors.white
          ),
          weatherImage: AssetImage('assets/night.png'));
    }
  }
  //endregion
}