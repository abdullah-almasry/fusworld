import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:splashscreen/splashscreen.dart';

import 'home_page.dart';


class Welcome extends StatefulWidget {



  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {


    setInitialTotalPrice() async {

    FirebaseAuth.instance.currentUser().then((user)async{

      final snapShot = await Firestore.instance
          .collection('Cart Details')
          .document(user.uid)
          .get();

      if (snapShot == null || !snapShot.exists) {

        Firestore.instance.collection('Cart Details').document(user.uid).setData({'total price': 0});

      }



    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setInitialTotalPrice();

  }




  @override
  Widget build(BuildContext context) {


      Locale myLocale = Localizations.localeOf(context);

      FirebaseAuth.instance.currentUser().then((user){

       Firestore.instance.collection('Users').document(user.uid).updateData({'lang code': '${myLocale.toString()}'});

      });

    return SplashScreen(



      seconds: 4,



      loaderColor: Colors.white,



      backgroundColor: Colors.black,



      image: Image.asset('assets/logo.jpg'),



      photoSize: 130,




      title : Text(AppLocalizations.of(context).translate('welcome'),
        style: TextStyle(fontFamily:AppLocalizations.of(context).translate('font_family'), color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700 ),),



      navigateAfterSeconds: Home()



    );
  }
}
