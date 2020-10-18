import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:fus_world/pages/product_view.dart';
import 'package:fus_world/pages/signup_page.dart';







class Favorite extends StatefulWidget {

  @override

  _FavoriteState createState() => _FavoriteState();

}



class _FavoriteState extends State<Favorite> {


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


  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String msg, Color color, dynamic _class, String codeKey, ) {

    final snackBarContent = SnackBar(
      content: Text(AppLocalizations.of(context).translate('no_shoes'), style: TextStyle(color: Colors.white),),

      backgroundColor: color,

      duration: Duration(seconds: 3),



    );
    _scaffoldkey.currentState.showSnackBar(snackBarContent);

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(


      key: _scaffoldkey,

        appBar: AppBar(

          leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white, size: 26,),
              onPressed: (){
            Navigator.pop(context);
              }
          ),

          backgroundColor: Colors.black,

          title: Text(
            AppLocalizations.of(context).translate('favorite_shoes') + ' 😘 ',
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

            stream: Firestore.instance.collection('Favorites').document(uid).collection('My Favorites').snapshots(),
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



                      return new Slidable(

                        actionPane: SlidableDrawerActionPane(),

                        actionExtentRatio: 0.25,

                        child: GestureDetector(

                          child: Container(

                            margin: EdgeInsets.all(5),

                            height: MediaQuery.of(context).size.height * 0.18,

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



                                  height: MediaQuery.of(context).size.height * 0.16,

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
                                            document.data['price'].toString(),
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



                                    ),






                                  ],

                                ),








                              ],

                            ),

                          ),

                          onTap: ()async{
                            String docId = document.data['doc id'];

                            final snapShot = await Firestore.instance
                                .collection('Shoes')
                                .document(docId)
                                .get();

                            if (snapShot == null || !snapShot.exists) {

                             Firestore.instance.collection('Favorites').document(uid).collection('My Favorites').document(document.documentID).delete();

                            }else{

                              List<String> images = List.from(snapShot['images']);

                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductView(
                                  snapShot.documentID,
                                  snapShot['${AppLocalizations.of(context).translate('name')}'],
                                  snapShot['price'],
                                  snapShot['${AppLocalizations.of(context).translate('shoe-desc')}'],
                                  snapShot['image'],
                                  images,
                                  snapShot['key'],
                                  true
                              )));
                            }

                          },

                        ),

                        actions: <Widget>[

                        /*  IconSlideAction(

                            caption: 'Basket',

                            color: Colors.blueAccent,

                            icon: Icons.shopping_basket,

                            //    onTap: () => _showSnackBar('Archive'),

                          ),*/



                        ],

                        secondaryActions: <Widget>[



                          IconSlideAction(

                            caption: 'Delete',

                            color: Colors.red,

                            icon: Icons.delete,

                               onTap: (){
                                 Firestore.instance.collection('Favorites').document(uid).collection('My Favorites').document(document.documentID).delete();
                               },

                          ),

                        ],

                      );
                    }).toList(),
                  ) : Center(
                    child: Text(AppLocalizations.of(context).translate('favorite_warn'), style: TextStyle(color: Colors.white),),
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

/*Slidable(

                actionPane: SlidableDrawerActionPane(),

                actionExtentRatio: 0.25,

                child: Container(

                  height: MediaQuery.of(context).size.height * 0.2,

                  decoration: BoxDecoration(

                      color: Colors.white70,

                      borderRadius: BorderRadius.all(Radius.circular(5))

                  ),

                  child: Row(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: <Widget>[

                      Container(



                        decoration: BoxDecoration(

                          color: Colors.white70,

                          image: DecorationImage(image: AssetImage('assets/showimg.jpg')),

                          borderRadius: BorderRadius.all(Radius.circular(12)),



                        ),

                        padding: EdgeInsets.all(12),

                        height: MediaQuery.of(context).size.height * 0.2,

                        width: MediaQuery.of(context).size.width * 0.3,

                      ),



                      Column(

                        children: <Widget>[

                          Container(

                            padding: EdgeInsets.all(9),

                            child: Text("Nike Shoes",style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18,fontFamily: 'Mulish'),)

                            ,

                          ),



                          Container(

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



                          ),



                          Row(

                            children: <Widget>[



                              Container(

                                padding: EdgeInsets.all(5),

                                child: IconButton(icon: Icon(Icons.favorite,color: Colors.red, size: 32,), onPressed: null),

                              ),





                              Container(

                                padding: EdgeInsets.all(5),

                                child: ClipOval(

                                  child: Material(

                                    color: Colors.deepPurple, // button color

                                    child: InkWell(

                                      // splashColor: Colors.red, // inkwell color

                                      child: SizedBox(

                                        width: 30, height: 30, child: Icon(Icons.add,color: Colors.amberAccent,),),

                                      onTap: () {},

                                    ),

                                  ),

                                ),

                              )

                            ],

                          )

                        ],

                      ),



                      Spacer(),



                      Container(

                        padding: EdgeInsets.all(12),

                        child: Text("12\$",style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black87, fontSize: 20),),

                      )

                    ],

                  ),

                ),

                actions: <Widget>[

                  IconSlideAction(

                    caption: 'Basket',

                    color: Colors.blueAccent,

                    icon: Icons.shopping_basket,

                    //    onTap: () => _showSnackBar('Archive'),

                  ),



                ],

                secondaryActions: <Widget>[



                  IconSlideAction(

                    caption: 'Delete',

                    color: Colors.red,

                    icon: Icons.delete,

                    //    onTap: () => _showSnackBar('Delete'),

                  ),

                ],

              ),*/