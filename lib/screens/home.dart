import 'package:flutter/material.dart';
import 'package:bmr_calculator/constants/app_constants.dart';
import 'package:bmr_calculator/constants/text_style.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

enum Gender { female, male }

class _HomeState extends State<Home> {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  double _bmr = 0;
  Gender? _gender = Gender.female;

  double bmrCalc(_weight, _height, _age, _gender) {
    if (_gender == Gender.female) {
      _bmr = 655.1 + (9.563 * _weight) + (1.85 * _height) - (4.676 * _age);
    } else {
      _bmr = 66.47 + (13.75 * _weight) + (5.003 * _height) - (6.755 * _age);
    }
    return _bmr;
  }

  double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMR Calculator",
          style: titleStyle,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.black,
            systemNavigationBarIconBrightness: Brightness.light),
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: fadedBlack,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getScreenHeight(context) / 15,
            ),
            ListTile(
              title: Text(
                'Female',
                style: radioStyle,
              ),
              leading: Radio<Gender>(
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: Gender.female,
                groupValue: _gender,
                onChanged: (Gender? value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text(
                'Male',
                style: radioStyle,
              ),
              leading: Radio<Gender>(
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: Gender.male,
                groupValue: _gender,
                onChanged: (Gender? value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: getScreenHeight(context) / 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: getScreenWidth(context) / 3,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _weightController,
                    style: mainTextStyle,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Weight",
                      hintStyle: hintTextStyle,
                    ),
                  ),
                ),
                Container(
                  width: getScreenWidth(context) / 3,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _heightController,
                    style: mainTextStyle,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Height",
                      hintStyle: hintTextStyle,
                    ),
                  ),
                ),
                Container(
                  width: getScreenWidth(context) / 3,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _ageController,
                    style: mainTextStyle,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Age",
                      hintStyle: hintTextStyle,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getScreenHeight(context) / 20,
            ),
            GestureDetector(
              onTap: () {
                double _weight = double.parse(_weightController.text);
                double _height = double.parse(_heightController.text);
                double _age = double.parse(_ageController.text);
                setState(() {
                  bmrCalc(_weight, _height, _age, _gender);
                });
              },
              child: Container(
                child: Text(
                  "Calculate",
                  style: buttonTextStyle,
                ),
              ),
            ),
            SizedBox(
              height: getScreenHeight(context) / 15,
            ),
            Container(
              child: Text(
                _bmr.toStringAsFixed(0),
                style: resultTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
