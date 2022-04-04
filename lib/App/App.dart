import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:random_social_network/App/Informations.dart';
import 'package:random_social_network/App/Screens/Home.dart';
import 'package:random_social_network/Data/FirebaseAuth.dart';
import 'package:random_social_network/Statics/statics.dart';
import 'package:random_social_network/provider/locale_provider.dart';
import 'package:random_social_network/utils/Constants.dart';
import 'package:random_social_network/utils/SizeConfig.dart';

class App extends StatefulWidget {
  final LocaleProvider? provider;
  const App({Key? key, required this.provider}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

class _AppState extends State<App> {
  bool run = false;
  final SizeConfig s = new SizeConfig();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Statics.provider = widget.provider;
    Future.delayed(Duration(seconds: 3), () {
      checkSignedIn();
    });
  }

  void checkSignedIn() async {
    bool isLoggedIn = await AuthService().isLoggedIn();
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
      return;
    }
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => LoginPage()),
    // );
  }

  Widget buildPages(BuildContext context) {
    s.init(context);
    return Stack(
      // fit: StackFit.expand,
      alignment: AlignmentDirectional.topCenter,
      children: [
        Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: this.run,
                child: Spacer(
                  flex: 1,
                ),
              ),
              Visibility(
                visible: this.run,
                child: Flexible(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/logo_random1.png',
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: !this.run,
                    child: DefaultTextStyle(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: SizeConfig.h(100),
                        color: Colors.black,
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          FadeAnimatedText('Hello !',
                              duration: Duration(seconds: 1)),
                          FadeAnimatedText('مرحبا !',
                              duration: Duration(seconds: 1)),
                          FadeAnimatedText('नमस्ते !',
                              duration: Duration(seconds: 1)),
                          FadeAnimatedText('Hola !',
                              duration: Duration(seconds: 1)),
                          FadeAnimatedText('你好 !',
                              duration: Duration(seconds: 1)),
                          ColorizeAnimatedText(
                              AppLocalizations.of(context)!.signIn,
                              textStyle: TextStyle(
                                fontSize: SizeConfig.h(50),
                              ),
                              colors: colorizeColors),
                        ],
                        onTap: () {
                          setState(() {
                            this.run = true;
                          });
                        },
                        repeatForever: false,
                        totalRepeatCount: 1,
                        onFinished: () {
                          setState(() {
                            this.run = true;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: this.run,
                child: Container(
                  height: SizeConfig.h(40),
                  width: SizeConfig.w(230),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextButton(
                    onPressed: () {
                      print('signed');
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signInText,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.h(10),
              ),
              Visibility(
                visible: this.run,
                child: Container(
                  height: SizeConfig.h(40),
                  width: SizeConfig.w(230),
                  decoration: BoxDecoration(
                    gradient: kPrimaryGradientLeaderboard,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextButton(
                    onPressed: () {
                      print('register');
                    },
                    child: Text(
                      AppLocalizations.of(context)!.registerText,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Visibility(
                visible: this.run,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await AuthService().signInwithGoogle().then((value) {
                          if (value != null) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InformationSignIn(
                                          user: value,
                                          provider: widget.provider,
                                        )),
                                (route) => true);
                          }
                        });
                      },
                      child: CircleAvatar(
                        child: SvgPicture.asset(
                            'assets/images/svg/googleLogo.svg'),
                        maxRadius: SizeConfig.w(25),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: CircleAvatar(
                        child:
                            SvgPicture.asset('assets/images/svg/phoneLogo.svg'),
                        maxRadius: SizeConfig.w(25),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -SizeConfig.screenHeight / SizeConfig.h(1.7),
          child: SvgPicture.asset(
            "assets/images/svg/LoginWave.svg",
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildPages(context);
  }
}
