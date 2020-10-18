import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:fus_world/pages/signup_page.dart';







class PreviousOrders extends StatefulWidget {

  @override

  _FavoriteState createState() => _FavoriteState();

}



class _FavoriteState extends State<PreviousOrders> {


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



  String uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkCurrentUser();

    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        uid = user.uid;
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
            AppLocalizations.of(context).translate('previous_orders'),
            style: TextStyle(
                fontFamily: AppLocalizations.of(context).translate('font_family'),
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white),),

          centerTitle: true,

          elevation: 0.0,

        ),



        backgroundColor: Colors.black,

        body: currentUser == true ? Container(

          margin: EdgeInsets.all(6),

          child: StreamBuilder<QuerySnapshot>(

            stream: Firestore.instance.collection('Previous Orders').document(uid).collection('My Previous Orders').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {







              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting: return new Center(
                  child: CircularProgressIndicator(),

                );

                default:
                  return snapshot.data.documents.length != 0  ? ListView(

                    scrollDirection: Axis.vertical,
                    children: snapshot.data.documents.map((DocumentSnapshot document) {



                      return new Container(

                        margin: EdgeInsets.only(top: 5, bottom: 5, right: 20, left: 20),

                        height: MediaQuery.of(context).size.height * 0.19,

                        decoration: BoxDecoration(

                            color: Colors.white,

                            borderRadius: BorderRadius.all(Radius.circular(5))

                        ),

                        child: Row(

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: <Widget>[

                            Container(



                              decoration: BoxDecoration(

                                color: Colors.white70,

                                image: DecorationImage(image: NetworkImage(document.data['image'])),

                                borderRadius: BorderRadius.all(Radius.circular(12)),



                              ),



                              height: MediaQuery.of(context).size.height * 0.17,

                              width: MediaQuery.of(context).size.width * 0.3,

                            ),



                            Column(

                              children: <Widget>[

                                Container(

                                  margin: EdgeInsets.only(top: 4),

                                  child: Text(
                                    document.data['name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: AppLocalizations.of(context).translate('font_family')
                                    ),)

                                  ,

                                ),

                                Container(

                                  margin: EdgeInsets.all( 2.5),



                                  child: Row(


                                    children: [



                                      Text(
                                        document.data['total price'].toString(),
                                        style: TextStyle(
                                            fontFamily: AppLocalizations.of(context).translate('font_family'),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700
                                        ),
                                      ),

                                      Container(

                                        margin: EdgeInsets.only(left: 2, right: 2, bottom: 2.5),

                                        child: Text(

                                          AppLocalizations.of(context).translate('qr'),

                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              color: Colors.blueGrey,
                                              fontSize: 12.5,
                                              fontFamily: AppLocalizations.of(context).translate('font_family')
                                          ),),
                                      ),

                                    ],
                                  ),

                                ),


                               Container(

                                 margin: EdgeInsets.all(1),

                                 child: Row(
                                   children: [

                                     Text(
                                       AppLocalizations.of(context).translate('_quantity'),
                                       style: TextStyle(
                                           color: Colors.black,
                                           fontSize: 13,
                                           fontFamily: AppLocalizations.of(context).translate('font_family')
                                       ),),

                                     Text(document.data['quantitiy'].toString(), style: TextStyle(color: Colors.blueGrey),),

                                   ],
                                 ),
                               ),

                                Container(

                                  margin: EdgeInsets.all(1),

                                  child: Row(
                                    children: [


                                      Text(AppLocalizations.of(context).translate('_size'), style: TextStyle(fontSize: 13,color: Colors.black, fontFamily: AppLocalizations.of(context).translate('font_family') ),),

                                      Text(document.data['size'].toString(), style: TextStyle(color: Colors.blueGrey),),



                                    ],
                                  ),
                                ),




                               /* Container(

                                  child: RatingBarIndicator(

                                    rating: 4.23,

                                    itemBuilder: (context, index) => Icon(

                                      Icons.star,

                                      color: Colors.amber,

                                    ),

                                    itemCount: 5,

                                    itemSize: 20.0,

                                    direction: Axis.horizontal,

                                  ),



                                ),*/






                              ],

                            ),








                          ],

                        ),

                      );
                    }).toList(),
                  ) : Center(
                    child: Text('You have no previous orders', style: TextStyle(color: Colors.white),),
                  );
              }
            },
          ),

        ) : Center(
          child: Padding(
            padding: EdgeInsets.only(top: 120),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 320,
                    width: MediaQuery.of(context).size.width - 80,
                    child: new SvgPicture.asset('assets/login.svg',),
                  ),
                  Text(AppLocalizations.of(context).translate('no_account'),style: TextStyle(
                      color: Color(0xFF7BA0F2),
                      fontSize: 20,
                      fontFamily: AppLocalizations.of(context).translate('font_family')
                  ),),
                  Container(
                    margin: EdgeInsets.only(top: 6),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: Text(
                        AppLocalizations.of(context).translate('create_account'),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            fontFamily: AppLocalizations.of(context).translate('font_family')
                        ),),
                    ),
                  )
                ],
              ),
            ),

          )
          ,
        )

    );

  }

}