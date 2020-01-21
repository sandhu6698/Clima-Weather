import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/networking.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String values;
  var hint = "Enter City name";
  var color = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 35,
                      ),
                      hintText: hint,
                      hintStyle: TextStyle(color: color),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none)),
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  onChanged: (value) {
                    values = value;
                  },
                ),
              ),
              FlatButton(
                onPressed: () async {
                  if (values != null) {
                    var url = "http://api.openweathermap.org/data/2.5/weather?q=$values&appid=875951dcb159b3f1f05d6d70ef286ea5";
                    NetworkHelper networkHelper = NetworkHelper(url);
                    var weatherdata= await networkHelper.getData();
                    Navigator.pop(context, weatherdata.body);
                  } else {
                    setState(() {
                      hint = "Please enter City name";
                      color = Colors.red;
                    });
                  }
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
