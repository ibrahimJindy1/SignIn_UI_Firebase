import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:random_social_network/App/App.dart';
import 'package:random_social_network/App/Screens/HomePage.dart';
import 'package:random_social_network/Data/FirebaseAuth.dart';
import 'package:random_social_network/Statics/statics.dart';

class PagesIndexed extends StatelessWidget {
  const PagesIndexed({
    Key? key,
    required this.selected,
  }) : super(key: key);

  final int selected;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: selected,
      // children: _pages,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                AuthService().signOutFromGoogle();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => App(provider: Statics.provider)),
                );
                return;
              },
              child: Text(
                AppLocalizations.of(context)!.signOut,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Second'),
          ],
        ),
        HamePage(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Fourth'),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Fifth'),
          ],
        ),
      ],
    );
  }
}
