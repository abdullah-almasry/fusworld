import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:fus_world/pages/product_view.dart';




Widget seeMoreList(BuildContext context, int myKey){


  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('Shoes').where('key', isEqualTo: myKey).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return new ListView(

        scrollDirection: Axis.horizontal,


        children: snapshot.data.documents.map((DocumentSnapshot document) {

          return new GestureDetector(

            child: Container(


                width: MediaQuery.of(context).size.width * 0.45,





                child: Card(

                  semanticContainer: true,


                  clipBehavior: Clip.antiAliasWithSaveLayer,

                  color: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),

                  ),


                  child: Column(

                    textDirection: TextDirection.ltr,

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: <Widget>[

                      ///1
                      Container(
                        height: MediaQuery.of(context).size.height *0.17,
                        width: MediaQuery.of(context).size.width,
                        child: Image(
                          image: NetworkImage(document.data["image"]),
                          fit: BoxFit.cover,
                        ),
                      ),

                      ///2
                      Container(




                        width: MediaQuery.of(context).size.width * 0.4,

                        height: MediaQuery.of(context).size.height * 0.075,

                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 7,  right: 7),
                        child:  Text(
                          document.data['en-name'] ,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontFamily: AppLocalizations.of(context).translate('font_family'),

                          ),
                        ),
                      ),

                      ///3
                      Container(

                        margin: EdgeInsets.all(1),
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 7),
                        child: Text(AppLocalizations.of(context).translate('new'),style: TextStyle(fontSize: 10, color: Colors.green,fontFamily: 'Mulish'),),
                      ),





                      Container(


                        alignment: Alignment.bottomCenter,


                        child: Container(



                          margin: EdgeInsets.only(top: 1),

                          child: Row(


                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              textDirection: TextDirection.ltr,

                              children: <Widget>[

                                Container(

                                  margin: EdgeInsets.only(left: 10, top: 5),

                                  alignment: Alignment.bottomLeft,

                                  width: MediaQuery.of(context).size.width * 0.25,

                                  height: MediaQuery.of(context).size.height * 0.06,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [

                                        Container(
                                          margin: EdgeInsets.only(left: 2, right: 2),
                                          child: Text(
                                            document.data['price'].toString() ,style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            fontFamily: AppLocalizations.of(context).translate('font_family'),

                                          ),),
                                        ),

                                        Text(AppLocalizations.of(context).translate('qr') , style: TextStyle(color: Colors.blueGrey, fontFamily: AppLocalizations.of(context).translate('font_family'), fontSize: 10, fontWeight: FontWeight.w700),)

                                      ],
                                    ),
                                  ),
                                ),

                                //Spacer(),

                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),

                                  ),

                                  height: MediaQuery.of(context).size.height * 0.064,

                                  alignment: Alignment.bottomLeft,

                                  width: MediaQuery.of(context).size.width * 0.12,

                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,

                                    ),
                                  ),
                                ),
                              ]
                          ),
                        ),
                      )

                    ],
                  ),

                )
            ),
            onTap: (){

              List<String> images = List.from(document['images']);


              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductView(

                      document.documentID,
                      document['en-name'],
                      document['price'],
                      document['${AppLocalizations.of(context).translate('shoe-desc')}'],
                      document['image'],
                      images,
                      myKey,
                      false

                  )
                  )
              );
            },
          );

/*
          return new GestureDetector(

            child: Container(


                width: 170,
                height: MediaQuery.of(context).size.height * 0.5,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(

                ),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(

                    textDirection: TextDirection.ltr,


                    children: <Widget>[
                      Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(13),
                        child: Image(
                          image: NetworkImage(document.data["image"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 7, top: 4),
                        child: Text( document.data['en-name'] ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500, color: Colors.black87,fontFamily: AppLocalizations.of(context).translate('font_family')),),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 7,top: 2),
                        child: Text(AppLocalizations.of(context).translate('new'),style: TextStyle(fontSize: 10, color: Colors.green,fontFamily: 'Mulish'),),
                      ),

                      Spacer(),


                      Row(
                          textDirection: TextDirection.ltr,
                          children: <Widget>[

                            Container(
                              //  padding: EdgeInsets.only(left: 5),
                              margin: EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              width: 80,
                              height: 40,
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  children: [

                                    Container(
                                      margin: EdgeInsets.all(2),
                                      child: Text(
                                        document.data['price'].toString() ,style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: AppLocalizations.of(context).translate('font_family'),

                                      ),),
                                    ),

                                    Text(AppLocalizations.of(context).translate('qr') , style: TextStyle(color: Colors.blueGrey, fontFamily: AppLocalizations.of(context).translate('font_family'), fontSize: 10, fontWeight: FontWeight.w700),)

                                  ],
                                ),
                              ),
                            ),

                            Spacer(),

                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),

                              ),
                              height: 40,
                              alignment: Alignment.centerRight,
                              width: 40,
                              child: Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.add,
                                  size: 18,
                                  color: Colors.white,

                                ),
                              ),
                            ),
                          ]
                      )

                    ],
                  ),

                )
            ),
            onTap: (){

              List<String> images = List.from(document['images']);


              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductView(

                      document.documentID,
                      document['${AppLocalizations.of(context).translate('name')}'],
                      document['price'],
                      document['${AppLocalizations.of(context).translate('shoe-desc')}'],
                      document['image'],
                      images,
                      myKey,
                      false

                  )
                  )
              );
            },
          );

*/
        }).toList(),
      );
    },
  );

}

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:fus_world/pages/product_view.dart';




Widget seeMoreList(BuildContext context, int myKey){


  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('Shoes').where('key', isEqualTo: myKey).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text('Something went wrong');
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return new ListView(

        scrollDirection: Axis.horizontal,


        children: snapshot.data.documents.map((DocumentSnapshot document) {

          return new GestureDetector(

            child: Container(


                width: MediaQuery.of(context).size.width * 0.45,





                child: Card(

                  semanticContainer: true,


                  clipBehavior: Clip.antiAliasWithSaveLayer,

                  color: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),

                  ),


                  child: Column(

                    textDirection: TextDirection.ltr,

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: <Widget>[

                      ///1
                      Container(
                        height: MediaQuery.of(context).size.height *0.17,
                        width: MediaQuery.of(context).size.width,
                        child: Image(
                          image: NetworkImage(document.data["image"]),
                          fit: BoxFit.cover,
                        ),
                      ),

                      ///2
                      Container(




                        width: MediaQuery.of(context).size.width * 0.4,

                        height: MediaQuery.of(context).size.height * 0.075,

                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 7,  right: 7),
                        child:  Text(
                          document.data['en-name'] ,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontFamily: AppLocalizations.of(context).translate('font_family'),

                          ),
                        ),
                      ),

                      ///3
                      Container(

                        margin: EdgeInsets.all(1),
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 7),
                        child: Text(AppLocalizations.of(context).translate('new'),style: TextStyle(fontSize: 10, color: Colors.green,fontFamily: 'Mulish'),),
                      ),





                      Container(


                        alignment: Alignment.bottomCenter,


                        child: Container(



                          margin: EdgeInsets.only(top: 1),

                          child: Row(


                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              textDirection: TextDirection.ltr,

                              children: <Widget>[

                                Container(

                                  margin: EdgeInsets.only(left: 10, top: 5),

                                  alignment: Alignment.bottomLeft,

                                  width: MediaQuery.of(context).size.width * 0.25,

                                  height: MediaQuery.of(context).size.height * 0.06,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [

                                        Container(
                                          margin: EdgeInsets.only(left: 2, right: 2),
                                          child: Text(
                                            document.data['price'].toString() ,style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            fontFamily: AppLocalizations.of(context).translate('font_family'),

                                          ),),
                                        ),

                                        Text(AppLocalizations.of(context).translate('qr') , style: TextStyle(color: Colors.blueGrey, fontFamily: AppLocalizations.of(context).translate('font_family'), fontSize: 10, fontWeight: FontWeight.w700),)

                                      ],
                                    ),
                                  ),
                                ),

                                //Spacer(),

                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),

                                  ),

                                  height: MediaQuery.of(context).size.height * 0.064,

                                  alignment: Alignment.bottomLeft,

                                  width: MediaQuery.of(context).size.width * 0.12,

                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,

                                    ),
                                  ),
                                ),
                              ]
                          ),
                        ),
                      )

                    ],
                  ),

                )
            ),
            onTap: (){

              List<String> images = List.from(document['images']);


              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductView(

                      document.documentID,
                      document['${AppLocalizations.of(context).translate('name')}'],
                      document['price'],
                      document['${AppLocalizations.of(context).translate('shoe-desc')}'],
                      document['image'],
                      images,
                      myKey,
                      false

                  )
                  )
              );
            },
          );

/*
          return new GestureDetector(

            child: Container(


                width: 170,
                height: MediaQuery.of(context).size.height * 0.5,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(

                ),
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(

                    textDirection: TextDirection.ltr,


                    children: <Widget>[
                      Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(13),
                        child: Image(
                          image: NetworkImage(document.data["image"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 7, top: 4),
                        child: Text( document.data['en-name'] ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500, color: Colors.black87,fontFamily: AppLocalizations.of(context).translate('font_family')),),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 7,top: 2),
                        child: Text(AppLocalizations.of(context).translate('new'),style: TextStyle(fontSize: 10, color: Colors.green,fontFamily: 'Mulish'),),
                      ),

                      Spacer(),


                      Row(
                          textDirection: TextDirection.ltr,
                          children: <Widget>[

                            Container(
                              //  padding: EdgeInsets.only(left: 5),
                              margin: EdgeInsets.all(2),
                              alignment: Alignment.centerLeft,
                              width: 80,
                              height: 40,
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  children: [

                                    Container(
                                      margin: EdgeInsets.all(2),
                                      child: Text(
                                        document.data['price'].toString() ,style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: AppLocalizations.of(context).translate('font_family'),

                                      ),),
                                    ),

                                    Text(AppLocalizations.of(context).translate('qr') , style: TextStyle(color: Colors.blueGrey, fontFamily: AppLocalizations.of(context).translate('font_family'), fontSize: 10, fontWeight: FontWeight.w700),)

                                  ],
                                ),
                              ),
                            ),

                            Spacer(),

                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),

                              ),
                              height: 40,
                              alignment: Alignment.centerRight,
                              width: 40,
                              child: Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.add,
                                  size: 18,
                                  color: Colors.white,

                                ),
                              ),
                            ),
                          ]
                      )

                    ],
                  ),

                )
            ),
            onTap: (){

              List<String> images = List.from(document['images']);


              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductView(

                      document.documentID,
                      document['${AppLocalizations.of(context).translate('name')}'],
                      document['price'],
                      document['${AppLocalizations.of(context).translate('shoe-desc')}'],
                      document['image'],
                      images,
                      myKey,
                      false

                  )
                  )
              );
            },
          );

*/
        }).toList(),
      );
    },
  );

}*/