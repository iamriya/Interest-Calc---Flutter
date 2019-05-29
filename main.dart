import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Stateful App Demo",
    home: YourName(),
  ));
}

class YourName extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _yourNameState();
  }
}

class _yourNameState extends State<YourName> {
  String yourname = " ";
  var _currencies = ["Rupees", "Dollars", "Pounds", "Others"];
  var _currentItemSelected = "Rupees";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("App bar")),
        body: Container(
            child: Column(children: <Widget>[
          TextField(onChanged: (String input_name) {
            setState(() {
              yourname = input_name;
            });
          }), //TextField

          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "You entered : $yourname",
              style: TextStyle(fontSize: 20.0, color: Colors.blue),
            ),
          ),

          DropdownButton<String>(
            items: _currencies.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(
                  dropDownStringItem,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String newValueSelected) {
              //code
              setState(() {
                this._currentItemSelected = newValueSelected;
              });
            },
            value: _currentItemSelected,
          )
        ]) //Column
            ) //Container
        ); //Scaffold
  }
}
