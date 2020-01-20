import 'package:flutter/material.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';
import 'dart:convert';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';




class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
 var lat;
 var long;
  void getLocationData() async{
    Location location = Location();
    await location.getCurrentLocation();
    lat = location.latitude;
    long= location.longitude;
    String url= "http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=875951dcb159b3f1f05d6d70ef286ea5";
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherdata= await networkHelper.getData();

    var temperature=jsonDecode(weatherdata.body)['main']['temp'] - 273.15;
    var name  = jsonDecode(weatherdata.body)['name'];
    var weather= jsonDecode(weatherdata.body)['weather'][0]['main'];
    print("temp : $temperature \n City: $name \n weather: $weather " );

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(weatherdata);
    }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }

  @override

  void initState() {
    super.initState();
    getLocationData();
  }

}
