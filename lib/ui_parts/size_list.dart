import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AvailableSizes extends StatefulWidget {


  final String documentId;



  AvailableSizes(this.documentId);

  @override
  _AvailableSizesState createState() => _AvailableSizesState();
}

class _AvailableSizesState extends State<AvailableSizes> {

  String get docId => widget.documentId;



  int _value;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(

      stream: Firestore.instance
          .collection('Shoes')
          .document(docId)
          .collection('Available sizes')
          .orderBy('size', descending: false)
          .snapshots(),

      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('');
          default:
            return new GridView.builder(

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 3.0
                ),

                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.documents.length,


                itemBuilder: (context, int index) {



                  DocumentSnapshot ds = snapshot.data.documents[index];

                  int quantity = ds.data['quantity'];


                  return quantity == 0 ?  new InkWell(

                    child: Container(

                      height: 20,
                      width: 20,

                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(15),

                          border: Border.all(
                              color: Colors.white24,
                              width: 1.0,
                              style: BorderStyle.solid
                          )
                      ),

                      child: Center(
                        child: Text(ds.data['size'].toString(),
                          style: TextStyle(
                              color:  Colors.white24
                          ),
                        ),
                      ),
                    ),

                    onTap: (){


                      Flushbar(
                        backgroundColor: Colors.blueGrey,
                        title: AppLocalizations.of(context).translate("title"),
                        message: AppLocalizations.of(context).translate("body"),
                        duration:  Duration(seconds: 3),
                        flushbarStyle: FlushbarStyle.FLOATING,
                        margin: EdgeInsets.all(8),
                        borderRadius: 8,
                      )..show(context);



                    },

                  ) :

                  new InkWell(

                    child: Container(

                      height: 20,
                      width: 20,

                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(15),

                          border: Border.all(
                              color: _value == index ? Colors.white : Colors.blueGrey,
                              width: 1.0,
                              style: BorderStyle.solid
                          )
                      ),

                      child: Center(
                        child: Text(ds.data['size'].toString(),
                          style: TextStyle(
                              color: _value == index ? Colors.white : Colors.blueGrey
                          ),
                        ),
                      ),
                    ),

                    onTap: ()async{


                      setState(() {


                          _value = index;


                      });

                      var sp = await SharedPreferences.getInstance();


                      sp.setInt("size", ds.data['size']);
                      sp.setString("documentId", ds.documentID);





                    },

                  );




                }
            );
        }
      },
    )  ;
  }


}


