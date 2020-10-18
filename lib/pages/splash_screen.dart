import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:splashscreen/splashscreen.dart';



import 'package:flutter/material.dart';



import '../main.dart';
import 'home_page.dart';











class SplashScreenPage extends StatefulWidget {



  @override



  _SplashScreenPageState createState() => _SplashScreenPageState();



}







class _SplashScreenPageState extends State<SplashScreenPage> {









  @override

  void initState() {

    // TODO: implement initState

    super.initState();



  }



  Future<void> setLocaleForAuthenticatedUser()async{


    FirebaseAuth.instance.currentUser().then((user){

      Firestore.instance.collection('Users').document(user.uid).get().then((DocumentSnapshot snapshot){



        String langCode = snapshot.data['lang code'];

        Locale newLocale = Locale('$langCode');
        MyApp.setLocale(context, newLocale);


      });

    });
  }


  @override

  Widget build(BuildContext context) {


    Locale myLocale = Localizations.localeOf(context);




    if(FirebaseAuth.instance.currentUser() == null){

      print('user is null');

      Locale newLocale = Locale(myLocale.toString());
      MyApp.setLocale(context, newLocale);

    }else{

      setLocaleForAuthenticatedUser();

    }


    return SplashScreen(



      seconds: 4,



      loaderColor: Colors.white,



      backgroundColor: Colors.black,





      image: Image.asset('assets/logo.jpg'),



      photoSize: 130,



      navigateAfterSeconds: Home(),



    );



  }



}

