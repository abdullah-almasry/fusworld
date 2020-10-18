import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'localizations.dart';




Widget getTotalPrice(BuildContext context, String uid) {


  return StreamBuilder(
      stream: Firestore.instance.collection('Cart Details').document(uid).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        var userDocument = snapshot.data;

        return Row(
          children: [



            Container(
              margin: EdgeInsets.all(2),
              child:  Text(userDocument["total price"].toString(), style: TextStyle(fontWeight: FontWeight.w800,fontSize: 22, color: Colors.black ) ),
            ),

            Text(   AppLocalizations.of(context).translate("qr",),
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontFamily: AppLocalizations.of(context).translate("font_family",),
                  fontSize: 15
              ),),
          ],
        );
      }
  );


}


