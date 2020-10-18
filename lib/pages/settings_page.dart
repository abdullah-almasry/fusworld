import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:fus_world/pages/signup_page.dart';
import 'package:fus_world/pages/splash_screen.dart';

import '../main.dart';



class Settings extends StatefulWidget {
    @override
    _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {




    Future<void> navigateToHomePage(){

        return Future.delayed(Duration(seconds: 3)).then((value) =>
            Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreenPage()))
        );
    }


    final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

    void showSnackBar(String msg, Color color) {

        final snackBarContent = SnackBar(
            content: Text("$msg", style: TextStyle(color: Colors.white),),

            backgroundColor: color,

            duration: Duration(seconds: 4),

            action: SnackBarAction(label: AppLocalizations.of(context).translate('create_account'), onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
            }) ,

        );
        _scaffoldkey.currentState.showSnackBar(snackBarContent);

    }






    int selectedLanguageIndex;
    ///Note
    ///English Index is 0
    ///Arabic Index is 1
    ///this method for checkbox

    void setData(BuildContext context)async{

        Locale myLocale = Localizations.localeOf(context);

        FirebaseUser user = await FirebaseAuth.instance.currentUser();


        if (user != null){
            FirebaseAuth.instance.currentUser().then((user){

                Firestore.instance.collection('Users').document(user.uid).get().then((DocumentSnapshot snapshot){

                    if(snapshot.data['lang code'] == "en"){
                        setState(() {

                            selectedLanguageIndex = 0;

                        });
                    }else{
                        setState(() {

                            selectedLanguageIndex = 1 ;

                        });
                    }

                });

            });





        }else{



            if (myLocale.toString() == "ar"){
                setState(() {
                    selectedLanguageIndex = 1 ;
                });
            }else{
                setState(() {
                    selectedLanguageIndex = 0 ;
                });
            }

        }




    }




    @override
    Widget build(BuildContext context) {


        setData(context);



        return Scaffold(

            backgroundColor: Colors.black,
            key: _scaffoldkey,
            appBar: AppBar(

                centerTitle: true,
                title: Text(AppLocalizations.of(context).translate('settings'),
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppLocalizations.of(context).translate('font_family')
                    ),
                ),
                backgroundColor: Colors.black,
                leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 24, color: Colors.white,), onPressed: null),
            ),


            body: Builder(
                builder: (BuildContext context){
                    return Column(

                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[

                            Container(
                                padding: EdgeInsets.all( 10),
                                child: Text(AppLocalizations.of(context).translate('account'),
                                    style: TextStyle(color: Colors.blueGrey, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: AppLocalizations.of(context).translate('font_family')),),
                            ),


                            GestureDetector(
                                child: Container(
                                    padding: EdgeInsets.only(left: 10, right: 10, top: 12),

                                    child: Row(
                                        children: <Widget>[
                                            Icon(Icons.person, color: Colors.white, size: 28,),

                                            Container(
                                                padding: EdgeInsets.all(7),
                                                child: Text(AppLocalizations.of(context).translate('logout'),

                                                    style: TextStyle(color: Colors.white, fontSize: 17, fontFamily: AppLocalizations.of(context).translate('font_family'), fontWeight: FontWeight.w600 ),),
                                            ),

                                            Spacer(),



                                            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14,),

                                        ],
                                    ),
                                ),
                                onTap: ()async{

                                    FirebaseUser firebaseuser = await FirebaseAuth.instance.currentUser();

                                    if(firebaseuser == null){

                                        showSnackBar(AppLocalizations.of(context).translate('no_account'), Colors.red);


                                    }else{

                                        logout().then((value) => showSnackBar("You signed out successfully", Colors.green));



                                    }



                                },
                            ),

                           Container(

                                padding: EdgeInsets.all( 16),
                                child: Text(AppLocalizations.of(context).translate('languages'),

                                    style: TextStyle(
                                        color: Colors.blueGrey,

                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppLocalizations.of(context).translate('font_family')
                                    ),),
                            ),




                            Container(
                                margin: EdgeInsets.all(10),

                                child:  Column(


                                    children: [

                                        buildLanguageItem('en', 0 ),

                                        buildLanguageItem('ar', 1),




                                    ],
                                ),
                            )




                        ],

                    );
                }
            )

        );
    }


    Widget buildLanguageItem(String langCode , int langIndex ){

        return GestureDetector(

            child: Container(

                margin: EdgeInsets.all(8),

                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                        Text(AppLocalizations.of(context).translate(langCode),

                            style: TextStyle(

                                color: Colors.white,

                                fontFamily: AppLocalizations.of(context).translate('font_family'),
                                fontSize: 16, fontWeight: FontWeight.w500),),


                        Padding(
                            padding: EdgeInsets.only(left: 9),
                            child:  selectedLanguageIndex == langIndex ? Icon(
                                Icons.check, color: Colors.blue,
                                size: 22,
                            ) : null
                        )

                    ],

                ),

            ),
            onTap: ()async{

                FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();


                if( firebaseUser == null){





                    showSnackBar(AppLocalizations.of(context).translate('no_account'), Colors.blueGrey);



                }else{

                    if(selectedLanguageIndex == langIndex){

                    }else{


                        FirebaseAuth.instance.currentUser().then((user){



                            Firestore.instance.collection('Users').document(user.uid).updateData({'lang code': '$langCode'});

                            setState(() {

                                MyApp.setLocale(context, Locale(langCode));


                                selectedLanguageIndex = langIndex;
                            });

                        });



                    }



                }

            },

        );
    }



    Future<void> logout() async {

        try {

            await FirebaseAuth.instance.signOut();



        } catch (e) {

            print(e.toString());
        }
    }

}
