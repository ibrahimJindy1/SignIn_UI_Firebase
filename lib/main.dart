import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:random_social_network/App/App.dart';
import 'package:random_social_network/Data/FirebaseProcess.dart';
import 'package:random_social_network/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:random_social_network/provider/locale_provider.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  await FirebaseProcess().FirebaseInit();
  await Future.delayed(Duration(milliseconds: 500));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Random Social Network';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: title,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primaryColor: Colors.white,
            ),
            locale: provider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: [
              CountryLocalizations.delegate,
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: App(
              provider: provider,
            ),
          );
        },
      );
}
