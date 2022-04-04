import 'package:flutter/material.dart';
import 'package:random_social_network/utils/SizeConfig.dart';

class textFieldInfo extends StatelessWidget {
  final String te;
  final TextEditingController cn;
  final bool secret;
  const textFieldInfo({
    Key? key,
    required this.te,
    required this.cn,
    required this.secret,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.h(50),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: TextField(
        obscuringCharacter: '*',
        obscureText: secret,
        controller: cn,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          labelText: te,
        ),
      ),
    );
  }
}
