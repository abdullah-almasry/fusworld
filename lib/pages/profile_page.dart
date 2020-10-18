

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:fus_world/pages/previous_order.dart';
import 'package:fus_world/pages/settings_page.dart';

import 'favorite_page.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String name = " ";
  String phone = " ";


  bool currentUser;

  checkCurrentUser()async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    if(user == null){
      setState(() {
        currentUser = false;
      });
    }else{
      setState(() {
        currentUser = true;
      });
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkCurrentUser();

    FirebaseAuth.instance.currentUser().then((user) {

      Firestore.instance.collection('Users').document(user.uid).get().then((snapshot) {
          setState(() {
            name  = snapshot.data['name'];
            phone  = snapshot.data['phone number'];
          });
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white, size: 26,),
            onPressed: (){
              Navigator.pop(context);
            }
        ),

        backgroundColor: Colors.black,

        title: Text(
          AppLocalizations.of(context).translate('profile'),
          style: TextStyle(
              fontFamily: AppLocalizations.of(context).translate('font_family'),
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.white),),

        centerTitle: true,

        elevation: 0.0,

      ),


      backgroundColor: Colors.black,

      body: currentUser == true ? Center(
        child: Container(

          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.8,

          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [


              Container(

                height: MediaQuery.of(context).size.height * 0.1,

                child: Column(
                  children: [

                    Text(name, style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: AppLocalizations.of(context).translate('font_family')
                    ),
                    ),
                    Text(phone, style: TextStyle(color: Colors.white),)

                  ],
                ),

              ),




              buildButton(context, Icons.shopping_basket, 'previous_orders', PreviousOrders()),

              buildButton(context, Icons.favorite, 'favorite_list', Favorite()),

              buildButton(context, Icons.settings, '_settings', Settings()),

              GestureDetector(
                child:  Container(

                  height: MediaQuery.of(context).size.height * 0.085,

                  width: MediaQuery.of(context).size.width ,

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius: BorderRadius.circular(8),


                  ),

                  child: Row(

                    crossAxisAlignment: CrossAxisAlignment.center,


                    children: [

                      Container(
                        margin: EdgeInsets.all(10),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.blueGrey,
                          size: 21,

                        ),

                      ),

                      Text(AppLocalizations.of(context).translate('logout'),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppLocalizations.of(context).translate('font_family')),)

                    ],

                  ),

                ),
                onTap: (){
                  FirebaseAuth.instance.signOut().then((value) => Navigator.pop(context));
                },
              )










            ],

          ),
        ),
      ) : Center(
        child: Text('Your need to login first', style: TextStyle(color: Colors.white),),
      )

    );
  }

  buildButton(BuildContext context, IconData iconName, String mainName, Widget _class){

    return GestureDetector(
      child:  Container(

        height: MediaQuery.of(context).size.height * 0.085,

        width: MediaQuery.of(context).size.width ,

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius: BorderRadius.circular(8),


        ),

        child: Row(

          crossAxisAlignment: CrossAxisAlignment.center,


          children: [

            Container(
              margin: EdgeInsets.all(10),
              child: Icon(
                iconName,
                color: Colors.blueGrey,
                size: 21,

              ),

            ),

            Text(AppLocalizations.of(context).translate(mainName),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppLocalizations.of(context).translate('font_family')),)

          ],

        ),

      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => _class));
      },
    );
  }
}






