import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:fus_world/pages/successful_order.dart';

import 'home_page.dart';


class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {


  String phoneNumber, name,  address, zoneNumber, streetNumber, houseNumber;

  bool _validateName = false;

  bool _validateAddress = false;

  bool _validatePhoneNumber = false;

  bool _validateZoneNumber = false;

  bool _validateStreetNumber = false;

  bool _validateHouseNumber = false;

  final _textName = TextEditingController();

  final _textAddress = TextEditingController();

  final _textZoneNumber = TextEditingController();

  final _textStreetNumber = TextEditingController();

  final _textHouseNumber = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseAuth.instance.currentUser().then((user){

      Firestore.instance.collection('Users').document(user.uid).get().then((DocumentSnapshot snapshot) {

        setState(() {
          phoneNumber = snapshot.data['phone number'];
        });

      });

    });

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,

        leading: IconButton(icon: Icon(Icons.arrow_back_ios, size: 24, color: Colors.white,), onPressed: null),

      ),

      body: SingleChildScrollView(

        child: Container(

          height: MediaQuery.of(context).size.height * 0.8,

          margin: EdgeInsets.only(top: 10),

          alignment: Alignment.center,

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,

            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [


              ///Name

              Container(

                width: MediaQuery.of(context).size.width * 0.7,

                child: Column(


                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[

                    Text(AppLocalizations.of(context).translate('tf_name'), style: TextStyle(

                        fontSize: 15,

                        fontFamily:  AppLocalizations.of(context).translate('font_family'),


                        fontWeight: FontWeight.w400,

                        color: Colors.white

                    ),),

                    SizedBox(height: 5,),

                    TextFormField(


                      controller: _textName,

                      style: TextStyle(
                          color: Colors.white
                      ),

                      cursorColor: Colors.white,




                      onChanged: (txt){

                        setState(() {
                          name = txt;
                        });




                      },


                      decoration: InputDecoration(

                       errorText: _validateName ? 'Name Field field is empty!' : null,


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

                 //   SizedBox(height: 5,),

                  ],

                ),
              ),






              ///phone number
              Container(

                width: MediaQuery.of(context).size.width * 0.7,

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[

                    Text(AppLocalizations.of(context).translate('phone_number'), style: TextStyle(

                        fontSize: 15,

                        fontFamily:  AppLocalizations.of(context).translate('font_family'),


                        fontWeight: FontWeight.w400,

                        color: Colors.white

                    ),),

                    SizedBox(height: 5,),

                    TextFormField(

                      controller: TextEditingController(
                          text: phoneNumber
                      ),

                      style: TextStyle(
                          color: Colors.white
                      ),

                      cursorColor: Colors.white,




                      onChanged: (txt){


                        setState(() {


                          phoneNumber = txt;


                        });


                      },


                      decoration: InputDecoration(

                           errorText: _validatePhoneNumber ? 'Phone number field is empty!' : null,


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

                   // SizedBox(height: 5,),

                  ],

                ),
              ),




              ///Address
              Container(

                width: MediaQuery.of(context).size.width * 0.7,

                child: Column(


                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[

                    Text(AppLocalizations.of(context).translate('tf_address'), style: TextStyle(

                        fontSize: 15,

                        fontFamily:  AppLocalizations.of(context).translate('font_family'),


                        fontWeight: FontWeight.w400,

                        color: Colors.white

                    ),),

                    SizedBox(height: 5,),

                    TextFormField(


                      controller: _textAddress,

                      style: TextStyle(
                          color: Colors.white
                      ),

                      cursorColor: Colors.white,




                      onChanged: (txt){

                        setState(() {
                          address = txt;
                        });




                      },


                      decoration: InputDecoration(

                        errorText: _validateAddress ? 'Address Field field is empty!' : null,


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

                   // SizedBox(height: 5,),

                  ],

                ),
              ),


              ///Row

              Container(

                width: MediaQuery.of(context).size.width * 0.7,

                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,


                  children: [



                    ///Zone number

                    Container(

                      width: MediaQuery.of(context).size.width * 0.22,

                      child: Column(


                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[

                          Text(AppLocalizations.of(context).translate('zone_number'), style: TextStyle(

                              fontSize: 14,

                              fontFamily:  AppLocalizations.of(context).translate('font_family'),


                              fontWeight: FontWeight.w400,

                              color: Colors.white

                          ),),

                          SizedBox(height: 5,),

                          TextFormField(

                            keyboardType: TextInputType.numberWithOptions(),

                            controller: _textZoneNumber,

                            style: TextStyle(
                                color: Colors.white
                            ),

                            cursorColor: Colors.white,




                            onChanged: (txt){

                              setState(() {
                                zoneNumber = txt;
                              });




                            },


                            decoration: InputDecoration(

                              errorText: _validateAddress ? 'Zone Number Field field is empty!' : null,


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

                        //  SizedBox(height: 5,),

                        ],

                      ),
                    ),






                    Container(

                      width: MediaQuery.of(context).size.width * 0.22,

                      child: Column(


                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[

                          Text(AppLocalizations.of(context).translate('street_number'), style: TextStyle(

                              fontSize: 15,

                              fontFamily:  AppLocalizations.of(context).translate('font_family'),


                              fontWeight: FontWeight.w400,

                              color: Colors.white

                          ),),

                          SizedBox(height: 5,),

                          TextFormField(

                            keyboardType: TextInputType.numberWithOptions(),

                            controller: _textStreetNumber,

                            style: TextStyle(
                                color: Colors.white
                            ),

                            cursorColor: Colors.white,




                            onChanged: (txt){

                              setState(() {
                                streetNumber = txt;
                              });




                            },


                            decoration: InputDecoration(

                              errorText: _validateAddress ? 'Street number Field field is empty!' : null,


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

                        //  SizedBox(height: 5,),

                        ],

                      ),
                    ),






                    Container(

                      width: MediaQuery.of(context).size.width * 0.22,

                      child: Column(


                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[

                          Text(AppLocalizations.of(context).translate('house_number'), style: TextStyle(

                              fontSize: 15,

                              fontFamily:  AppLocalizations.of(context).translate('font_family'),


                              fontWeight: FontWeight.w400,

                              color: Colors.white

                          ),),

                          SizedBox(height: 5,),

                          TextFormField(

                            keyboardType: TextInputType.numberWithOptions(),

                            controller: _textHouseNumber,

                            style: TextStyle(
                                color: Colors.white
                            ),

                            cursorColor: Colors.white,




                            onChanged: (txt){

                              setState(() {
                                houseNumber = txt;
                              });




                            },


                            decoration: InputDecoration(

                              errorText: _validateAddress ? 'House number Field field is empty!' : null,


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

                        //  SizedBox(height: 5,),

                        ],

                      ),
                    ),



                  ],
                ),


              ),



              GestureDetector(
                child: Container(

                  height: MediaQuery.of(context).size.height * 0.09,
                  width: MediaQuery.of(context).size.width * 0.6,

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),


                  child: Center(
                    child: Text(

                      AppLocalizations.of(context).translate('request_order'),

                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: AppLocalizations.of(context).translate('font_family'),
                          fontWeight: FontWeight.w600,
                          fontSize: 16
                      ),

                    ),
                  ),


                ),
                onTap: () async{





                  setState(() {
                    _textName.text.isEmpty ? _validateName = true : _validateName = false;
                    _textAddress.text.isEmpty ? _validateAddress = true : _validateAddress = false;
                    _textZoneNumber.text.isEmpty ? _validateZoneNumber = true : _validateZoneNumber = false;
                    _textHouseNumber.text.isEmpty ? _validateHouseNumber = true : _validateHouseNumber = false;
                    _textStreetNumber.text.isEmpty ? _validateStreetNumber = true : _validateStreetNumber = false;
                  });

                  if(_textName.text.isNotEmpty & _textAddress.text.isNotEmpty & phoneNumber.isNotEmpty & _textZoneNumber.text.isNotEmpty & _textStreetNumber.text.isNotEmpty & _textHouseNumber.text.isNotEmpty){





                   await  Firestore.instance.collection('Orders').add({
                     'name': '$name',
                     'address':'$address',
                     'phone number': '$phoneNumber',
                     'zone number': zoneNumber,
                     'street number': streetNumber,
                     'house number': houseNumber,

                   }).then(( mainSnapshot) {


                             FirebaseAuth.instance.currentUser().then((user) {

                               Firestore.instance.collection('Carts').document(user.uid).collection('My Cart').getDocuments().then((snapshot) {




                                 snapshot.documents.forEach((orderContent) {

                                   decreaseQuantity(orderContent.data['documetId'], orderContent.data['size doc Id'],  orderContent.data['name'], orderContent.data['quantitiy']);

                                   print(orderContent.data['size doc Id']);
                                   

                                   Firestore.instance.collection('Previous Orders').document(user.uid).collection('My Previous Orders').add(orderContent.data);

                                   Firestore.instance.collection('Orders').document(mainSnapshot.documentID).collection('User Order').add(orderContent.data);
                                 });

                                 for (DocumentSnapshot ds in snapshot.documents){
                                   ds.reference.delete();
                                 }

                                 Firestore.instance.collection('Cart Details').document(user.uid).updateData({'total price': 0});

                               });



                             });


                    });



                  }

                  Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessfulOrder()));

                },
              )


            ],

          ),
        ),

      )

    );
  }

 void decreaseQuantity(String documentPath, document2Path, shoesName, int quantity)async{

    Firestore.instance.collection('Shoes').document('$documentPath').collection('Available sizes').document('$document2Path').get().then((snapshot){

      var currentQuantity = snapshot.data['quantity'];

      if(snapshot.data['quantity'] == 1){

       Firestore.instance.collection('Alert').add({

         'name': '$shoesName',
         'size': snapshot.data['size']

       });

       Firestore.instance.collection('Shoes').document(documentPath).updateData({
         'Available': '0'
       });

      }



      Firestore.instance.collection('Shoes').document('$documentPath')
          .collection('Available sizes').document('$document2Path')
          .updateData({'quantity': currentQuantity - quantity });


    });





 }


}


