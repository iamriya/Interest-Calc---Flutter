import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "SI Calculator",
    home: SIForm(),
    theme: ThemeData(
        primaryColor: Colors.cyan,
        accentColor: Colors.cyanAccent,
        brightness: Brightness.dark),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formkey = GlobalKey<FormState>();
  var _minPadding = 5.0;
  var _currencies = ["Rupees", "Dollars", "Pounds"];
  var _currentItemSelected = "";
  var display = " ";
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    TextStyle hintStyle = Theme.of(context).textTheme.subtitle;

    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text(
          "Interest Calculator",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          PopupMenuButton(itemBuilder: null)
        ],), //AppBar

        body: Form(
            key: _formkey,
            child: Padding(
                padding: EdgeInsets.all(5.0),
                child: ListView(children: <Widget>[
                  Center(child: getImageAsset()),
                  Padding(
                      padding: EdgeInsets.all(_minPadding),
                      child: TextFormField(
                        validator: (String value) {
                          if (value.isEmpty)
                            return "Please enter Principal amount";
                        },
                        controller: principalController,
                        style: textStyle,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Principal",
                            hintText: "Enter Principal Amount \t e.g. 10000",
                            labelStyle: textStyle,
                            hintStyle: hintStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ) //Principal TextField
                      ),
                  Padding(
                      padding: EdgeInsets.all(_minPadding),
                      child: TextFormField(
                        validator: (String value) {
                          if (value.isEmpty)
                            return "Please enter Rate of Interest";
                        },
                        controller: roiController,
                        style: textStyle,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Rate of Interest",
                            hintText: "Enter Rate in Percent (%)",
                            labelStyle: textStyle,
                            hintStyle: hintStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ) //Rate TextField
                      ),
                  Padding(
                      padding: EdgeInsets.all(_minPadding),
                      child: Row(children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          validator: (String value) {
                            if (value.isEmpty) return "Please enter the Term";
                          },
                          controller: termController,
                          style: textStyle,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Term",
                              hintText: "Enter in years",
                              labelStyle: textStyle,
                              hintStyle: hintStyle,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )), //Term TextField)

                        Container(
                          child: SizedBox.fromSize(size: Size(10.0, 2.0)),
                        ),

                        Expanded(
                            child: Center(
                          child: DropdownButton<String>(
                            items: _currencies.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(
                                  dropDownStringItem,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }).toList(),
                            value: _currentItemSelected,
                            onChanged: (String newValueSelected) {
                              //code
                              setState(() {
                                this._currentItemSelected = newValueSelected;
                              });
                            },
                          ), //DropdownButton
                        ))
                      ]) //Row,
                      ),

                  Padding(
                      padding: EdgeInsets.all(_minPadding),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              textColor: Theme.of(context).primaryColorDark,
                              elevation: 50.0,
                              child: Text(
                                "Calculate",
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_formkey.currentState.validate()) {
                                    display = _calculateTotal();
                                  } else
                                    display = "";
                                });
                              },
                            ),
                          ),
                          Container(
                            child: SizedBox.fromSize(size: Size(10.0, 2.0)),
                          ),
                          Expanded(
                              child: RaisedButton(
                            color: Colors.white,
                            textColor: Theme.of(context).primaryColor,
                            elevation: 50.0,
                            child: Text(
                              "Reset",
                              textAlign: TextAlign.center,
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            },
                          ))
                        ],
                      ) //Row
                      ), //Padding
                  Padding(
                      padding: EdgeInsets.all(_minPadding),
                      child: Text(display,
                          textAlign: TextAlign.center, style: textStyle)),
                ]) //Column
                ) //FormPadding
            ) //Form
        ); //Scaffold
  } //build()

  String _calculateTotal() {
    //auto_focus = false;
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double amount = principal + (principal * roi * term) / 100;
    String result =
        "After $term years, your investment will be worth $_currentItemSelected $amount";
    return result;
  }

  void _reset() {
    _formkey.currentState.reset();
    principalController.text = "";
    roiController.text = "";
    termController.text = "";
    display = "";
    _currentItemSelected = _currencies[0];
  }

  Widget getImageAsset() {
    AssetImage aimg = AssetImage('images/bank.png');
    Image si = Image(
      image: aimg,
      width: 150.0,
      height: 150.0,
    );
    return Container(child: si);
  }
} //class
