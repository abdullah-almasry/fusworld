import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:fus_world/pages/verify_phone_number.dart';
import 'package:simple_animations/simple_animations.dart';


class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();

}

class _SignUpState extends State<SignUp> {


  String _fontFamily;



  void setData()async{

    Locale myLocale = Localizations.localeOf(context);

    FirebaseUser user = await FirebaseAuth.instance.currentUser();


    if(user != null){


      FirebaseAuth.instance.currentUser().then((user){

        Firestore.instance.collection('Users').document(user.uid).get().then((DocumentSnapshot snapshot){

          if(snapshot.data['lang code'] == "ar"){

            setState(() {
              _fontFamily = 'Kufi';

            });

          }else{
            setState(() {
              _fontFamily = 'Mulish';

            });
          }


        });

      });



    }else{

      if (myLocale.toString() == "ar" ){
        setState(() {
          _fontFamily = 'Kufi';

        });
      }else{
        setState(() {
          _fontFamily = 'Mulish';

        });
      }



    }

  }


  String txtName ,txtPhoneNumber, txtPassword;


  final tween = MultiTrackTween([

    Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),

    Track("translateY").add(

        Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),

        curve: Curves.easeOut)

  ]);





  bool _validate1 = false;
  bool _validate2 = false;
  bool _validate3 = false;

  final _text1 = TextEditingController();
  final _text2 = TextEditingController();
  final _text3 = TextEditingController();


  @override

  Widget build(BuildContext context) {

    setData();

    return Scaffold(



        backgroundColor: Colors.black,

        appBar: AppBar(

          elevation: 0,

          brightness: Brightness.light,

          backgroundColor: Colors.black,

          leading: IconButton(

            onPressed: () {

              Navigator.pop(context);

            },

            icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white,),

          ),

        ),

        body: SingleChildScrollView(

          scrollDirection: Axis.vertical,

          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: <Widget>[

              Column(

                children: <Widget>[

                  FadeAnimation(1, Text( AppLocalizations.of(context).translate("join_us"), style: TextStyle(

                      fontSize: 30,

                      fontWeight: FontWeight.bold,

                      color: Colors.white,

                      fontFamily: _fontFamily

                  ),)),

                  SizedBox(height: 20,),

                  FadeAnimation(1.2, Text(AppLocalizations.of(context).translate('join_us_title'), style: TextStyle(

                      fontSize: 15,

                      color: Colors.white70,

                      fontFamily: _fontFamily

                  ),)),

                ],

              ),

              Padding(

                padding: EdgeInsets.symmetric(horizontal: 40),

                child: Column(

                  children: <Widget>[


                    ///Name
                    ControlledAnimation(

                      delay: Duration(milliseconds: (500 * 1.2).round()),

                      duration: tween.duration,

                      tween: tween,

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[

                          Text(AppLocalizations.of(context).translate('tf_name'), style: TextStyle(

                              fontSize: 15,

                              fontFamily: _fontFamily,


                              fontWeight: FontWeight.w400,

                              color: Colors.white

                          ),),

                          SizedBox(height: 5,),

                          TextFormField(

                            style: TextStyle(
                                color: Colors.white
                            ),

                            cursorColor: Colors.white,

                            controller: _text1,


                            onChanged: (txt){

                              txtName = txt;



                            },
                            //   obscureText: ,

                            decoration: InputDecoration(

                              errorText: _validate1 ? 'Name field is empty!' : null,


                              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),

                              enabledBorder: OutlineInputBorder(

                                  borderSide: BorderSide(color: Colors.white70)

                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 3.0),
                              ),



                              border: OutlineInputBorder(

                                borderSide: BorderSide(color: Colors.white70),

                              ),

                            ),

                          ),

                          SizedBox(height: 30,),

                        ],

                      ),

                      builderWithChild: (context, child, animation) => Opacity(

                        opacity: animation["opacity"],

                        child: Transform.translate(

                            offset: Offset(0, animation["translateY"]),

                            child: child

                        ),

                      ),

                    ),



                    ///phone number
                    ControlledAnimation(

                      delay: Duration(milliseconds: (500 * 1.2).round()),

                      duration: tween.duration,

                      tween: tween,

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[

                          Text(AppLocalizations.of(context).translate('phone_number'), style: TextStyle(

                              fontSize: 15,

                              fontFamily: _fontFamily,


                              fontWeight: FontWeight.w400,

                              color: Colors.white

                          ),),

                          SizedBox(height: 5,),

                          TextFormField(

                            style: TextStyle(
                                color: Colors.white
                            ),

                            cursorColor: Colors.white,

                            controller: _text2,

                            keyboardType: TextInputType.numberWithOptions(),


                            onChanged: (txt){

                              txtPhoneNumber = txt;



                            },
                            //   obscureText: ,

                            decoration: InputDecoration(

                              errorText: _validate2 ? 'Phone number field is empty!' : null,


                              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),

                              enabledBorder: OutlineInputBorder(

                                  borderSide: BorderSide(color: Colors.white70)

                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 3.0),
                              ),



                              border: OutlineInputBorder(

                                borderSide: BorderSide(color: Colors.white70),

                              ),

                            ),

                          ),

                          SizedBox(height: 30,),

                        ],

                      ),

                      builderWithChild: (context, child, animation) => Opacity(

                        opacity: animation["opacity"],

                        child: Transform.translate(

                            offset: Offset(0, animation["translateY"]),

                            child: child

                        ),

                      ),

                    ),



                    ///Password
                    ControlledAnimation(

                      delay: Duration(milliseconds: (500 * 1.2).round()),

                      duration: tween.duration,

                      tween: tween,

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[

                          Text(AppLocalizations.of(context).translate('password'), style: TextStyle(

                              fontSize: 15,

                              fontWeight: FontWeight.w400,

                              color: Colors.white,

                              fontFamily: _fontFamily

                          ),),

                          SizedBox(height: 5,),

                          TextFormField(

                            cursorColor: Colors.white,

                            style: TextStyle(
                                color: Colors.white
                            ),

                            obscureText: true,

                            controller: _text3,

                            onChanged: (txt){

                              txtPassword = txt;



                            },
                            //   obscureText: ,

                            decoration: InputDecoration(

                              errorText: _validate3 ? 'Password field is empty!' : null,

                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white, width: 3.0),
                              ),

                              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),

                              enabledBorder: OutlineInputBorder(

                                  borderSide: BorderSide(color: Colors.grey[400])

                              ),

                              border: OutlineInputBorder(

                                  borderSide: BorderSide(color: Colors.grey[400])

                              ),

                            ),

                          ),

                          SizedBox(height: 30,),

                        ],

                      ),

                      builderWithChild: (context, child, animation) => Opacity(

                        opacity: animation["opacity"],

                        child: Transform.translate(

                            offset: Offset(0, animation["translateY"]),

                            child: child

                        ),

                      ),

                    ),



                  ],

                ),

              ),

             FadeAnimation(
               1.4,
               GestureDetector(
                 child: Container(
                   height: MediaQuery.of(context).size.height * 0.1,
                   width: MediaQuery.of(context).size.width * 0.6,

                   decoration: BoxDecoration(
                     color: Colors.white,
                     shape: BoxShape.rectangle,
                     borderRadius: BorderRadius.circular(50)
                   ),
                   child: Center(
                     child: Text(AppLocalizations.of(context).translate('join_us'), style: TextStyle(

                         fontWeight: FontWeight.w600,

                         fontSize: 18,

                         color: Colors.black,

                         fontFamily: _fontFamily

                     ),
                     ),
                   ),

                 ),
                 onTap: (){
                   print('////////////////////////////////////////////////////////////////////////////f');
                   setState(() {
                     _text1.text.isEmpty ? _validate1 = true : _validate1 = false;
                     _text2.text.isEmpty ? _validate2 = true : _validate2 = false;
                     _text3.text.isEmpty ? _validate3 = true : _validate3 = false;
                   });

                   if( _text2.text.isNotEmpty &  _text3.text.isNotEmpty & _text1.text.isNotEmpty){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyPhoneNumber(txtName, txtPhoneNumber,txtPassword)));
                   }
                 },
               )
             )

              /*FadeAnimation(1.4, Padding(

                  padding: EdgeInsets.symmetric(horizontal: 40),

                  child: GestureDetector(
                    child: Container(

                      padding: EdgeInsets.only(top: 3, left: 3),

                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(50),

                          border: Border(

                            bottom: BorderSide(color: Colors.black),

                            top: BorderSide(color: Colors.black),

                            left: BorderSide(color: Colors.black),

                            right: BorderSide(color: Colors.black),

                          )

                      ),

                      child: MaterialButton(

                        minWidth: double.infinity,

                        height: 60,

                        onPressed: () {},

                        color: Colors.white,

                        elevation: 0,

                        shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(50)

                        ),

                        child: Text(AppLocalizations.of(context).translate('join_us'), style: TextStyle(

                            fontWeight: FontWeight.w600,

                            fontSize: 18,

                            color: Colors.black,

                            fontFamily: _fontFamily

                        ),
                        ),

                      ),

                    ),
                    onTap: (){

                      print('////////////////////////////////////////////////////////////////////////////f');
                      setState(() {
                        _text1.text.isEmpty ? _validate1 = true : _validate1 = false;
                        _text2.text.isEmpty ? _validate2 = true : _validate2 = false;
                        _text3.text.isEmpty ? _validate3 = true : _validate3 = false;
                      });

                      if( _text2.text.isNotEmpty &  _text3.text.isNotEmpty & _text1.text.isNotEmpty){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyPhoneNumber(txtName, txtPhoneNumber,txtPassword)));
                      }
                    },
                  )

              ),
              ),*/



            ],

          ),
        )

    );



  }







}









class FadeAnimation extends StatelessWidget {

  final double delay;

  final Widget child;



  FadeAnimation(this.delay, this.child);



  @override

  Widget build(BuildContext context) {

    final tween = MultiTrackTween([

      Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),

      Track("translateY").add(

          Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),

          curve: Curves.easeOut)

    ]);



    return ControlledAnimation(

      delay: Duration(milliseconds: (500 * delay).round()),

      duration: tween.duration,

      tween: tween,

      child: child,

      builderWithChild: (context, child, animation) => Opacity(

        opacity: animation["opacity"],

        child: Transform.translate(

            offset: Offset(0, animation["translateY"]),

            child: child

        ),

      ),

    );

  }

}