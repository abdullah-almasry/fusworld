import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fus_world/functions/get_total_price.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:fus_world/pages/signup_page.dart';
import 'check_out.dart';


class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {



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

    FirebaseAuth.instance.currentUser().then((user){

      setState(() {
        uid = user.uid;
      });

    });


  }



  @override
  Widget build(BuildContext context) {



    return Scaffold(



      backgroundColor: Colors.black,

      body: currentUser == true ? Column(
        children: <Widget>[


          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.all(15),
            child: GestureDetector(

              child: Text(
                AppLocalizations.of(context).translate('clear_all'),
                style: TextStyle(
                  fontSize: 16,
                    color: Colors.white,
                    fontFamily: AppLocalizations.of(context).translate('font_family')
                ),),

              onTap: ()async{



                Firestore.instance.collection('Carts').document(uid).collection('My Cart').getDocuments().then((snapshot) {
                  for (DocumentSnapshot ds in snapshot.documents){
                    ds.reference.delete();
                  }
                });

                Firestore.instance.collection('Cart Details').document(uid).updateData({'total price': 0 });


              },
            ),
          ),


          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(top: 12,left: 20),
            child: Text( AppLocalizations.of(context).translate('my_cart') + ' ♥ ' ,

              style: TextStyle(
                  fontSize: 34,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppLocalizations.of(context).translate('font_family')
              ),),
          ),

          Container(

            height: MediaQuery.of(context).size.height * 0.5,

            margin: EdgeInsets.all(18),
            alignment: Alignment.center,

            child: StreamBuilder<QuerySnapshot>(

                stream: Firestore.instance.collection('Carts').document(uid).collection('My Cart').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {



                  if (snapshot.hasError)
                    return new Text('Error: ${snapshot.error}');

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Center(
                        child: CircularProgressIndicator(),

                      );

                    default:
                      return snapshot.data.documents.length != 0 ? ListView(

                        scrollDirection: Axis.vertical,

                        children: snapshot.data.documents.map((DocumentSnapshot document) {

                          return new Slidable(

                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,

                            child: Container(

                              margin: EdgeInsets.all(6),


                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.19,

                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.9,

                              alignment: Alignment.center,


                              decoration: BoxDecoration(

                                  color: Colors.white,

                                  borderRadius: BorderRadius.circular(14)

                              ),


                              child: Row(

                                  children: <Widget>[


                                    ClipRRect(

                                      borderRadius: BorderRadius.all(
                                          Radius.circular(14)),

                                      child: Image(
                                        image: NetworkImage(
                                            document.data['image']),
                                        fit: BoxFit.cover,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.35,
                                        height: double.infinity,),


                                    ),


                                    Container(

                                      margin: EdgeInsets.only(top: 5),

                                      //padding: EdgeInsets.all(12),

                                      child: Column(

                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,

                                        children: <Widget>[


                                          Container(

                                            margin: EdgeInsets.only(top: 5),

                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width * 0.51,

                                            child: Text(document.data['name'],
                                              style: TextStyle(

                                                  color: Colors.black,

                                                  fontWeight: FontWeight.w500,

                                                  fontFamily: AppLocalizations.of(
                                                      context)
                                                      .translate('font_family'),

                                                  fontSize: 14

                                              ),),

                                          ),


                                          Container(
                                            margin: EdgeInsets.only(top: 4),

                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              children: [

                                                Text(document.data['quantitiy']
                                                    .toString())

                                              ],
                                            ),
                                          ),


                                          Container(

                                            margin: EdgeInsets.only(top: 4.5),

                                            alignment: Alignment.topLeft,

                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,

                                              children: [


                                                Text(document.data['total price']
                                                    .toString(),
                                                  style: TextStyle(fontSize: 15,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: AppLocalizations
                                                          .of(context)
                                                          .translate(
                                                          'font_family')),),

                                                Text(
                                                  ' ${AppLocalizations.of(context)
                                                      .translate(
                                                      'qr')}', style: TextStyle(
                                                    fontFamily: AppLocalizations
                                                        .of(context)
                                                        .translate('font_family'),
                                                    fontSize: 12),),

                                              ],
                                            ),

                                          )


                                        ],

                                      ),

                                    ),


                                  ]

                              ),


                            ),
                            actions: <Widget>[
                              IconSlideAction(
                                caption: 'Favorite',
                                color: Colors.blueAccent,
                                icon: Icons.favorite,
                                //    onTap: () => _showSnackBar('Archive'),
                              ),

                            ],
                            secondaryActions: <Widget>[

                              IconSlideAction(
                                caption: 'Delete',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () {
                                  Firestore.instance.collection('Carts').document(
                                      uid)
                                      .collection('My Cart').document(
                                      document.documentID)
                                      .delete();


                                  int totalPrice = document['total price'];

                                  //For total price
                                  final DocumentReference priceRef = Firestore
                                      .instance
                                      .collection('Cart Details').document(uid);
                                  Firestore.instance.runTransaction((
                                      Transaction tx) async {
                                    DocumentSnapshot postSnapshot = await tx.get(
                                        priceRef);
                                    if (postSnapshot.exists) {
                                      await tx.update(priceRef,
                                          <String, dynamic>{
                                            'total price': postSnapshot
                                                .data['total price'] -
                                                totalPrice
                                          });
                                    }
                                  });
                                },
                              ),
                            ],
                          );
                        }).toList(),
                      ) : Center(
                        child: Text('Your cart is empty', style: TextStyle(color: Colors.white),),
                      );
                  }
                }
            ),

          ),

          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(15),
              // height: MediaQuery.of(context).size.height * 0.1,
              //   width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,

              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(7),
                    child: Text(AppLocalizations.of(context).translate('total'),
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black87 ,
                          fontFamily: AppLocalizations.of(context).translate('font_family')
                      ),),
                  ),

                  Spacer(),

                  Container(
                    width: 150,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(7),
                    child: getTotalPrice(context, uid),
                  ),
                ],
              ),
            ),
          ),



          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(left: 60, right: 60, top: 15,bottom: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blueGrey,

              ),
              child: GestureDetector(
                child: Center(
                  child: Text('Check Out', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600, fontFamily: 'Mulish'),),
                ),
                onTap: ()async{


                  await Firestore.instance.collection('Carts').document(uid).collection('My Cart').getDocuments().then((snapshot){

                    if(snapshot.documents.length != 0){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOut()));
                    }else{

                    }

                  });



                },
              ),
            ),

          ),







        ],
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

           ),
      )
    );
  }


}

