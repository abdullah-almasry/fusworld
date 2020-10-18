import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

///import 'package:code_input/code_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:fus_world/pages/welcoming_page.dart';
import 'package:intl/intl.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPhoneNumber extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final String password;

  VerifyPhoneNumber(
    this.name,
    this.phoneNumber,
    this.password,
  );

  @override
  _VerifyPhoneNumberState createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  void showSnackBar(
    String msg,
  ) {
    final snackBarContent = SnackBar(
      content: Text(
        "$msg",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 5),
    );
    _scaffoldkey.currentState.showSnackBar(snackBarContent);
  }

  String get name => widget.name;
  String get phoneNumber => widget.phoneNumber;
  String get password => widget.password;

  String _verificationId;

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> checkSMSCode(String smsCode) async {
    AuthCredential phoneAuthCredential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: smsCode);

    await auth.signInWithCredential(phoneAuthCredential).then((value) {
      FirebaseAuth.instance.currentUser().then((user) {
        Firestore.instance.collection('Users').document('${user.uid}').setData({
          'name': name,
          'phone number': '$phoneNumber',
          'password': '$password'
        }).then((value) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Welcome()));
        });
      });
    });
  }

  Future<void> sendSMSCode() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+974' + '$phoneNumber',
      verificationCompleted: (AuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          FirebaseAuth.instance.currentUser().then((user) {
            Firestore.instance
                .collection('Users')
                .document('${user.uid}')
                .setData({
              'name': name,
              'phone number': '$phoneNumber',
              'password': '$password',
              'date': DateFormat.yMd().format(new DateTime.now())
            }).then((value) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Welcome()));
            });
          });
        });
      },
      verificationFailed: (AuthException e) {
        showSnackBar(e.message);
      },
      codeSent: (String verificationId, [int resendToken]) {
        setState(() {
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: Duration(seconds: 60),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    sendSMSCode();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  AppLocalizations.of(context).translate('verification'),
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      fontFamily:
                          AppLocalizations.of(context).translate('font_family'),
                      color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  AppLocalizations.of(context).translate('thanks'),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily:
                          AppLocalizations.of(context).translate('font_family'),
                      color: Colors.white),
                ),
              ),
              Text(
                AppLocalizations.of(context).translate('we_are'),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontFamily:
                        AppLocalizations.of(context).translate('font_family'),
                    color: Colors.white),
              ),
              Container(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  '+974' + '$phoneNumber',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish',
                      color: Colors.white),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 27),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      disabledColor: Colors.black,
                      inactiveColor: Colors.grey,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.black,
                    enableActiveFill: true,

                    ///  errorAnimationController: errorController,
                    ///  controller: textEditingController,
                    onCompleted: (v) {
                      checkSMSCode(v);
                    },
                    onChanged: (value) {
                      print(value);
                    },

                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  )
                  /* child: CodeInput(
                    length: 6,
                    keyboardType: TextInputType.number,
                    builder: CodeInputBuilders.circle(border: Border.all(), color: Colors.white, textStyle: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600)),
                    onFilled: (value) {
                      checkSMSCode(value);
                    },
                  )*/

                  ),
              Container(
                padding: EdgeInsets.only(top: 25),
                child: Text(
                  AppLocalizations.of(context).translate('resend'),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily:
                          AppLocalizations.of(context).translate('font_family'),
                      fontSize: 15),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  '$_start',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Mulish',
                      fontSize: 25),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 35),
                child: RaisedButton(
                  onPressed: _start > 0
                      ? null
                      : () {
                          sendSMSCode();

                          _start = 60;

                          startTimer();
                        },
                  child: Text(
                    AppLocalizations.of(context).translate('resend_code'),
                    style: TextStyle(
                        color: _start > 0 ? Colors.black38 : Colors.black,
                        fontFamily: AppLocalizations.of(context)
                            .translate('font_family')),
                  ),
                  color: Colors.white,
                  disabledColor: Colors.grey,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Timer _timer;

  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);

    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }
}
/*import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_input/code_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:fus_world/pages/welcoming_page.dart';
import 'package:intl/intl.dart';


class VerifyPhoneNumber extends StatefulWidget {

  final String  name;
  final String  phoneNumber;
  final String  password;

  VerifyPhoneNumber ( this.name, this.phoneNumber, this.password, );

  @override

  _VerifyPhoneNumberState createState() => _VerifyPhoneNumberState();

}



class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {


  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String msg, ) {

    final snackBarContent = SnackBar(
      content: Text("$msg", style: TextStyle(color: Colors.white),),

      backgroundColor: Colors.red,

      duration: Duration(seconds: 5),


    );
    _scaffoldkey.currentState.showSnackBar(snackBarContent);

  }




  String get name => widget.name;
  String get phoneNumber => widget.phoneNumber;
  String get password => widget.password;





  String _verificationId;



  final FirebaseAuth auth = FirebaseAuth.instance;


  Future <void> checkSMSCode(String smsCode) async {






    AuthCredential  phoneAuthCredential = PhoneAuthProvider.getCredential(verificationId: _verificationId, smsCode: smsCode);


    await auth.signInWithCredential(phoneAuthCredential).then((value) {
      FirebaseAuth.instance.currentUser().then((user){


        Firestore.instance.collection('Users').document('${user.uid}')
            .setData({ 'name': name , 'phone number': '$phoneNumber' , 'password': '$password'}).then((value) {

          Navigator.push(context, MaterialPageRoute(builder: (context) => Welcome()));
        });

      });
    });













  }





  Future<void> sendSMSCode()async{




    await FirebaseAuth.instance.verifyPhoneNumber(

      phoneNumber: '+974' + '$phoneNumber',

      verificationCompleted: (AuthCredential credential) async {

        await auth.signInWithCredential(credential).then((value){

          FirebaseAuth.instance.currentUser().then((user){

            Firestore.instance.collection('Users').document('${user.uid}')
                .setData({'name': name, 'phone number': '$phoneNumber' , 'password': '$password', 'date': DateFormat.yMd().format(new DateTime.now())}).then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Welcome()));
            });

          });




        });
      },

      verificationFailed: (AuthException e) {

        showSnackBar(e.message);

      },
      codeSent: (String verificationId, [int resendToken]) {



        setState(() {
          _verificationId = verificationId;
        });


      },
      codeAutoRetrievalTimeout: (String verificationId) {},

      timeout: Duration(seconds: 60),
    );

  }







  @override

  void initState() {

    // TODO: implement initState

    super.initState();



    sendSMSCode();

    startTimer();



  }



  @override

  Widget build(BuildContext context) {



    return Scaffold(


      key: _scaffoldkey,

      backgroundColor: Colors.black,



      appBar: AppBar(



        backgroundColor: Colors.black,



        elevation: 0.0,



        leading: IconButton(



            icon: Icon(Icons.arrow_back_ios,



              color: Colors.black,



              size: 24,



            ),



            onPressed: (){

              Navigator.pop(context);

            }



        ),





      ),



      body: ListView(

        scrollDirection: Axis.vertical,

        children: <Widget>[



          Column(

            children: <Widget>[





              Container(



                alignment: Alignment.center,



                padding: EdgeInsets.only(top: 20),



                child: Text(
                  AppLocalizations.of(context).translate('verification'),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, fontFamily: AppLocalizations.of(context).translate('font_family'), color: Colors.white),),

              ),





              Container(

                padding: EdgeInsets.only(top: 20),

                child: Text(AppLocalizations.of(context).translate('thanks'),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: AppLocalizations.of(context).translate('font_family'), color: Colors.white),),



              ),

              Text(AppLocalizations.of(context).translate('we_are'),
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, fontFamily: AppLocalizations.of(context).translate('font_family'), color: Colors.white),),





              Container(

                padding: EdgeInsets.only(top: 4),

                child: Text('+974' + '$phoneNumber', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Mulish', color: Colors.white),),



              ),





              Container(

                  padding: EdgeInsets.only(top: 27),

                  child: CodeInput(
                    length: 6,
                    keyboardType: TextInputType.number,
                    builder: CodeInputBuilders.circle(border: Border.all(), color: Colors.white, textStyle: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600)),
                    onFilled: (value) {
                      checkSMSCode(value);
                    },
                  )

              ),






              Container(

                padding: EdgeInsets.only(top: 25),

                child: Text(AppLocalizations.of(context).translate('resend'),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontFamily: AppLocalizations.of(context).translate('font_family'), fontSize: 15),),

              ),



              Container(

                padding: EdgeInsets.only(top: 15),

                child: Text('$_start',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontFamily: 'Mulish', fontSize: 25),),

              ),





              Container(

                padding: EdgeInsets.only(top: 35),

                child: RaisedButton(



                  onPressed: _start > 0 ? null : (){

                    sendSMSCode();

                    _start = 60;

                    startTimer();

                  },



                  child: Text(
                    AppLocalizations.of(context).translate('resend_code'),
                    style: TextStyle(
                        color: _start > 0 ? Colors.black38 : Colors.black,
                      fontFamily: AppLocalizations.of(context).translate('font_family')
                    ),),

                  color: Colors.white,

                  disabledColor: Colors.grey,



                ),

              )



            ],

          )



        ],

      ),

    );

  }





  Timer _timer;

  int _start = 60;



  void startTimer() {

    const oneSec = const Duration(seconds: 1);

    _timer = new Timer.periodic(

      oneSec,

          (Timer timer) => setState(

            () {

          if (_start < 1) {

            timer.cancel();

          } else {

            _start = _start - 1;

          }

        },

      ),

    );

  }



  @override

  void dispose() {

    _timer.cancel();

    super.dispose();

  }



}*/
