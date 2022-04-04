import 'package:flutter/material.dart';
import 'package:random_social_network/utils/SizeConfig.dart';

class Gender {
  String name;
  IconData icon;
  bool isSelected;

  Gender(this.name, this.icon, this.isSelected);
}

class CustomRadio extends StatelessWidget {
  Gender _gender;

  CustomRadio(this._gender);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: _gender.isSelected ? Color(0xFF3B4257) : Colors.white,
        child: Container(
          height: SizeConfig.h(80),
          width: SizeConfig.h(80),
          alignment: Alignment.center,
          margin: new EdgeInsets.all(SizeConfig.w(2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                _gender.icon,
                color: _gender.isSelected ? Colors.white : Colors.grey,
                size: SizeConfig.w(20),
              ),
              Text(
                _gender.name,
                style: TextStyle(
                    color: _gender.isSelected ? Colors.white : Colors.grey),
              )
            ],
          ),
        ));
  }
}
