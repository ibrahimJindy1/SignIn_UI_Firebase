import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:random_social_network/App/App.dart';
import 'package:random_social_network/App/Screens/Home.dart';
import 'package:random_social_network/Data/FirebaseAuth.dart';
import 'package:random_social_network/Data/FirebaseProcess.dart';
import 'package:random_social_network/components/Client.dart';
import 'package:random_social_network/components/gender.dart';
import 'package:random_social_network/components/textFieldInfo.dart';
import 'package:random_social_network/provider/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:random_social_network/utils/SizeConfig.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

class InformationSignIn extends StatefulWidget {
  final User user;
  final LocaleProvider? provider;
  const InformationSignIn(
      {Key? key, required this.user, required this.provider})
      : super(key: key);

  @override
  _InformationSignInState createState() => _InformationSignInState();
}

final TextEditingController first = TextEditingController();
final TextEditingController last = TextEditingController();
final TextEditingController pass = TextEditingController();
final TextEditingController phone = TextEditingController();
final TextEditingController birthdate = TextEditingController();
final ImagePicker _picker = ImagePicker();
late XFile? file;
late Client client;
FirebaseProcess _firebase = new FirebaseProcess();
int g = 0;

class _InformationSignInState extends State<InformationSignIn> {
  List<Gender> genders = <Gender>[];
  final SizeConfig s = new SizeConfig();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    first.text = "";
    last.text = "";
    pass.text = "";
    phone.text = "";
    file = new XFile('assets/images/guest.png');
    Future.delayed(Duration(seconds: 1), () {
      genders.add(new Gender(
          AppLocalizations.of(context)!.male, MdiIcons.genderMale, true));
      genders.add(new Gender(
          AppLocalizations.of(context)!.female, MdiIcons.genderFemale, false));
      genders.add(new Gender(AppLocalizations.of(context)!.otherG,
          MdiIcons.genderTransgender, false));
      first.text = widget.user.displayName!;

      setState(() {});
    });
  }

  final format = DateFormat("yyyy-MM-dd");
  Widget date(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        height: SizeConfig.h(50),
        child: DateTimeField(
          controller: birthdate,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            labelText: 'Birthdate',
          ),
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
        ),
      ),
    ]);
  }

  String countryCode = '';
  String fullPhone = '';
  _buildCountryPickerDropdownSoloExpanded() {
    return CountryPickerDropdown(
      underline: Container(
        height: 2,
        color: Colors.red,
      ),
      //show'em (the text fields) you're in charge now
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      //if you want your dropdown button's selected item UI to be different
      //than itemBuilder's(dropdown menu item UI), then provide this selectedItemBuilder.
      onValuePicked: (Country country) {
        countryCode = '+${country.phoneCode}';
        phone.text = '$countryCode';
      },

      itemBuilder: (Country country) {
        return Row(
          children: <Widget>[
            SizedBox(width: SizeConfig.w(8)),
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: SizeConfig.w(5),
            ),
            Text(country.name),
          ],
        );
      },
      itemHeight: null,
      isExpanded: true,
      //initialValue: 'TR',
      icon: Icon(Icons.arrow_downward),
    );
  }

  @override
  Widget build(BuildContext context) {
    s.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.registerText,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: TextButton(
          onPressed: () async {
            await AuthService().signOutFromGoogle().then(
                  (value) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => App(provider: widget.provider),
                      ),
                      (route) => false),
                );
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 10,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.blue.shade400, Colors.purple.shade400],
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(SizeConfig.h(70)),
            child: CircleAvatar(
              radius: SizeConfig.h(70),
              child: GestureDetector(
                onTap: () async {
                  file = await _picker.pickImage(source: ImageSource.gallery);
                  setState(() {});
                },
                child: Container(
                  width: SizeConfig.h(190),
                  height: SizeConfig.h(190),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: io.File(file!.path).existsSync()
                      ? new Image.file(
                          File(file!.path),
                          fit: BoxFit.fill,
                        )
                      : new Image.network(
                          widget.user.photoURL!,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Flexible(
                child: textFieldInfo(
                  te: AppLocalizations.of(context)!.firstName,
                  cn: first,
                  secret: false,
                ),
              ),
              Flexible(
                child: textFieldInfo(
                  te: AppLocalizations.of(context)!.lastName,
                  cn: last,
                  secret: false,
                ),
              ),
            ],
          ),
          textFieldInfo(
            te: AppLocalizations.of(context)!.password,
            cn: pass,
            secret: true,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: date(context),
          ),
          Column(
            children: [
              Card(
                child: _buildCountryPickerDropdownSoloExpanded(),
              ),
              textFieldInfo(
                te: AppLocalizations.of(context)!.phoneNumber,
                cn: phone,
                secret: false,
              ),
            ],
          ),
          Spacer(),
          Expanded(
            flex: 3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: genders.length,
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Colors.blue.shade800,
                  onTap: () {
                    setState(
                      () {
                        genders.forEach((gender) => gender.isSelected = false);
                        g = index;
                        genders[index].isSelected = true;
                      },
                    );
                  },
                  child: CustomRadio(genders[index]),
                );
              },
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Container(
            height: SizeConfig.h(40),
            width: SizeConfig.w(230),
            decoration: BoxDecoration(
              color: Colors.purple[400],
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextButton(
              onPressed: () async {
                client = new Client(widget.user.uid, first.text, last.text,
                    birthdate.text, phone.text, g);
                await _firebase.setNewClient(client);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                    (route) => false);

                print("Successful");
              },
              child: Text(
                AppLocalizations.of(context)!.next,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}

// class BasicDateField extends StatelessWidget {
//   final format = DateFormat("yyyy-MM-dd");
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       DateTimeField(
//         controller: birthdate,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//           labelText: 'Birthdate',
//         ),
//         format: format,
//         onShowPicker: (context, currentValue) {
//           return showDatePicker(
//               context: context,
//               firstDate: DateTime(1900),
//               initialDate: currentValue ?? DateTime.now(),
//               lastDate: DateTime(2100));
//         },
//       ),
//     ]);
//   }
// }
