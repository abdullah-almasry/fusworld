import 'package:carousel_slider/carousel_slider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:fus_world/pages/shoes_view.dart';
import 'package:fus_world/pages/signup_page.dart';
import 'package:fus_world/ui_parts/see_more_list.dart';
import 'package:fus_world/ui_parts/size_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_page.dart';
import 'favorite_page.dart';

class ProductView extends StatefulWidget {
  final String _documentId, _name, _description, _image;

  final List myImagesList;

  final int _price, _key;

  final bool showWidget;

  ProductView(this._documentId, this._name, this._price, this._description,
      this._image, this.myImagesList, this._key, this.showWidget);

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  void showSnackBar(
    String msg,
    Color color,
    dynamic _class,
    String codeKey,
  ) {
    final snackBarContent = SnackBar(
      content: Text(
        "$msg",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
      duration: Duration(seconds: 5),
      action: SnackBarAction(
          label: AppLocalizations.of(context).translate('$codeKey'),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => _class));
          }),
    );
    _scaffoldkey.currentState.showSnackBar(snackBarContent);
  }

  String get documentId => widget._documentId;

  String get name => widget._name;

  String get description => widget._description;

  String get image => widget._image;

  int get myKey => widget._key;

  int get price => widget._price;

  List get images => widget.myImagesList;

  bool get showWidget => widget.showWidget;

  int _quantity = 1;

  int addValue = 0;

  int favValue = 0;

  double sliderValue = 37.0;

  String colorCode;

  int size;

  StreamBuilder _sream;

  Widget fetchAvailableSize;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _sream = seeMoreList(context, myKey);

    fetchAvailableSize = AvailableSizes(documentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 27,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: IconButton(
                    icon: Icon(
                      Icons.shopping_basket,
                      color: Colors.white,
                      size: 27,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Cart()));
                    }),
                onPressed: null,
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.78,
              child: ListView(
                children: <Widget>[
                  CarouselSlider(
                    options: CarouselOptions(height: 170.0, autoPlay: true),
                    items: [0, 1, 2, 3].map((i) {
                      return GestureDetector(
                        child: Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(images[i]),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(12)));
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShoesView(images[i])));
                        },
                      );
                    }).toList(),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            name,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: AppLocalizations.of(context)
                                    .translate('font_family'),
                                color: Colors.white,
                                fontSize: 18),
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(3),
                              child: Text(price.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 17)),
                            ),
                            Text(AppLocalizations.of(context).translate('qr'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                    fontSize: 14,
                                    fontFamily: AppLocalizations.of(context)
                                        .translate('font_family')))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //  alignment: Alignment.topLeft,

                    padding: EdgeInsets.only(left: 13, bottom: 20, right: 13),

                    child: RatingBarIndicator(
                      rating: 4.2,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 30.0,
                      direction: Axis.horizontal,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      AppLocalizations.of(context).translate('sizes'),
                      style: TextStyle(
                          fontFamily: AppLocalizations.of(context)
                              .translate('font_family'),
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: fetchAvailableSize),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      AppLocalizations.of(context).translate('quantity'),
                      style: TextStyle(
                          fontFamily: AppLocalizations.of(context)
                              .translate('font_family'),
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Colors.white),
                            child: Icon(
                              Icons.remove,
                              color: Colors.black87,
                              size: 20,
                            ),
                          ),
                          onTap: () {
                            if (_quantity > 1) {
                              //setState(() {
                              _quantity = _quantity - 1;
                              //  });
                            }
                          },
                        ),
                        Container(
                          padding: EdgeInsets.all(7),
                          margin: EdgeInsets.all(4),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          child: Center(
                            child: Text(
                              _quantity.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.all(4),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                color: Colors.white),
                            child: Icon(
                              Icons.add,
                              color: Colors.black87,
                              size: 20,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _quantity = _quantity + 1;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 11, left: 15, bottom: 11),
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)
                                .translate('total_cost'),
                            style: TextStyle(
                                fontFamily: AppLocalizations.of(context)
                                    .translate('font_family'),
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ' ${_quantity * price}',
                            style: TextStyle(
                                fontFamily: AppLocalizations.of(context)
                                    .translate('font_family'),
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            ' ${AppLocalizations.of(context).translate('qr')} ',
                            style: TextStyle(
                                fontFamily: AppLocalizations.of(context)
                                    .translate('font_family'),
                                fontSize: 14,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                      AppLocalizations.of(context).translate('desc'),
                      style: TextStyle(
                          fontFamily: AppLocalizations.of(context)
                              .translate('font_family'),
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(9),
                    child: Text(
                      description,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: AppLocalizations.of(context)
                              .translate('font_family'),
                          color: Colors.white,
                          fontSize: 14),
                    ),
                  ),
                  Container(
                      child: showWidget == true
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('see_more'),
                                    style: TextStyle(
                                        fontFamily: AppLocalizations.of(context)
                                            .translate('font_family'),
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.38,
                                  child: Scaffold(
                                    backgroundColor: Colors.black,
                                    body: _sream,
                                  ),
                                ),
                              ],
                            )
                          : Container()),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 28, right: 28),
                height: MediaQuery.of(context).size.height * 0.09,
                padding: EdgeInsets.all(4),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 120,
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            color: addValue == 0
                                ? Colors.blueGrey
                                : Colors.greenAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                            child: addValue == 0
                                ? Text(
                                    AppLocalizations.of(context)
                                        .translate('add_to_cart'),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontFamily: AppLocalizations.of(context)
                                            .translate('font_family'),
                                        fontWeight: FontWeight.w800),
                                  )
                                : Text(
                                    AppLocalizations.of(context)
                                        .translate('added'),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontFamily: AppLocalizations.of(context)
                                            .translate('font_family'),
                                        fontWeight: FontWeight.w800),
                                  )),
                      ),
                      onTap: () async {
                        FirebaseUser user =
                            await FirebaseAuth.instance.currentUser();

                        if (user != null) {
                          addProductToCart().then((value) {
                            showSnackBar(
                                AppLocalizations.of(context).translate('cart'),
                                Colors.green,
                                Cart(),
                                'btn_cart');
                          });
                        } else {
                          showSnackBar(
                              AppLocalizations.of(context)
                                  .translate('no_account'),
                              Colors.blueGrey,
                              SignUp(),
                              'create_account');
                        }
                      },
                    ),
                    Container(
                      child: GestureDetector(
                        child: favValue == 0
                            ? Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 38,
                              )
                            : Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 38,
                              ),
                        onTap: () async {
                          FirebaseUser user =
                              await FirebaseAuth.instance.currentUser();

                          if (user != null) {
                            FirebaseAuth.instance.currentUser().then((user) {
                              Firestore.instance
                                  .collection('Favorites')
                                  .document(user.uid)
                                  .collection('My Favorites')
                                  .add({
                                'image': '$image',
                                'name': '$name',
                                'price': price,
                                'doc id': '$documentId'
                              }).then((value) {
                                setState(() {
                                  favValue = 1;
                                });

                                showSnackBar(
                                    AppLocalizations.of(context)
                                        .translate('fav'),
                                    Colors.green,
                                    Favorite(),
                                    'btn_fav');
                              });
                            });
                          } else {
                            showSnackBar(
                                AppLocalizations.of(context)
                                    .translate('no_account'),
                                Colors.blueGrey,
                                SignUp(),
                                'create_account');
                          }
                        },
                      ),
                    )
                  ],
                ))
          ],
        ));
  }

  Future<void> addProductToCart() async {
    if (addValue == 0) {
      var sp = await SharedPreferences.getInstance();
      var size = sp.getInt("size");

      var docIdForSize = sp.getString("documentId");

      FirebaseAuth.instance.currentUser().then((user) async {
        await Firestore.instance
            .collection('Carts')
            .document(user.uid)
            .collection('My Cart')
            .add({
          'name': '$name',
          'total price': _quantity * price,
          'quantitiy': _quantity,
          'image': '$image',
          'size': size,
          'documetId': documentId,
          'size doc Id': docIdForSize
        });

        int totP = _quantity * price;

        final DocumentReference priceRef =
            Firestore.instance.collection('Cart Details').document(user.uid);
        Firestore.instance.runTransaction((Transaction tx) async {
          DocumentSnapshot postSnapshot = await tx.get(priceRef);
          if (postSnapshot.exists) {
            await tx.update(priceRef, <String, dynamic>{
              'total price': postSnapshot.data['total price'] + totP
            });
          }
        });

        setState(() {
          addValue = 1;
        });
      });
    }
  }
}

/*import 'package:carousel_slider/carousel_slider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:fus_world/pages/shoes_view.dart';
import 'package:fus_world/pages/signup_page.dart';
import 'package:fus_world/ui_parts/see_more_list.dart';
import 'package:fus_world/ui_parts/size_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_page.dart';
import 'favorite_page.dart';


class ProductView extends StatefulWidget {



  final String _documentId , _name , _description, _image;

  final List myImagesList;

  final int _price, _key;

  final bool showWidget;


  ProductView(this._documentId, this._name, this._price, this._description, this._image, this.myImagesList, this._key, this.showWidget);



  @override

  _ProductViewState createState() => _ProductViewState();

}



class _ProductViewState extends State<ProductView> {



  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String msg, Color color, dynamic _class, String codeKey, ) {

    final snackBarContent = SnackBar(
      content: Text("$msg", style: TextStyle(color: Colors.white),),

      backgroundColor: color,

      duration: Duration(seconds: 5),

      action: SnackBarAction(label: AppLocalizations.of(context).translate('$codeKey'),
          onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => _class));
          }
      ),

    );
    _scaffoldkey.currentState.showSnackBar(snackBarContent);

  }




  String get documentId => widget._documentId;



  String get name => widget._name;



  String get description => widget._description;


  String get image => widget._image;


  int get myKey => widget._key;

  int get price => widget._price;

  List get images => widget.myImagesList;

  bool get showWidget => widget.showWidget;



  int _quantity = 1;

  int addValue = 0;

  int favValue = 0;

  double sliderValue = 37.0;

  String colorCode;

  int size;


  StreamBuilder _sream;

 Widget fetchAvailableSize;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _sream = seeMoreList(context, myKey);

    fetchAvailableSize = AvailableSizes(documentId);

  }


  @override

  Widget build(BuildContext context) {







    return Scaffold(

      key: _scaffoldkey,

      backgroundColor: Colors.black,

      appBar: AppBar(

        backgroundColor: Colors.black,

        elevation: 0.0,

        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white, size: 27,),
            onPressed: (){
                  Navigator.pop(context);
            }
        ),

        actions: <Widget>[

          Align(

            alignment: Alignment.centerRight,

            child: IconButton(

              icon: IconButton(
                  icon: Icon(Icons.shopping_basket,color: Colors.white, size: 27,),
                  onPressed: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));


                  }
              ),

              onPressed: null,

            ),

          )

        ],

      ),

      body: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[



          Container(

           height: MediaQuery.of(context).size.height * 0.78 ,

            child: ListView(


              children: <Widget>[




                CarouselSlider(

                  options: CarouselOptions(
                      height: 170.0,
                      autoPlay: true
                  ),


                  items: [0,1,2,3].map((i) {

                    return GestureDetector(
                      child: Builder(

                        builder: (BuildContext context) {

                          return Container(

                              width: MediaQuery.of(context).size.width,

                              margin: EdgeInsets.symmetric(horizontal: 5.0),

                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(images[i]),
                                      fit: BoxFit.cover
                                  ),
                                  borderRadius: BorderRadius.circular(12)
                              )



                          );





                        },

                      ),

                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ShoesView(images[i])));
                      },

                    );

                  }).toList(),

                ),



                Container(

                  padding: EdgeInsets.all(20),

                  child: Row(

                    children: <Widget>[



                      Container(

                        width: MediaQuery.of(context).size.width * 0.5,

                        child: Text( name ,style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: AppLocalizations.of(context).translate('font_family'),
                            color: Colors.white,fontSize: 18),),

                      ),



                      Spacer(),


                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            child: Text(price.toString(),style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 17)),
                          ),
                          Text(AppLocalizations.of(context).translate('qr'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                  fontSize: 14,
                                  fontFamily: AppLocalizations.of(context).translate('font_family')
                              ))
                        ],
                      ),






                    ],

                  ),

                ),



                Container(

                  //  alignment: Alignment.topLeft,

                  padding: EdgeInsets.only(left: 13,bottom: 20,right: 13),

                  child: RatingBarIndicator(



                    rating: 4.2,



                    itemBuilder: (context, index) => Icon(



                      Icons.star,



                      color: Colors.amber,



                    ),



                    itemCount: 5,



                    itemSize: 30.0,



                    direction: Axis.horizontal,



                  ),

                ),








                Container(

                  padding: EdgeInsets.all(15),



                  child: Text(AppLocalizations.of(context).translate('sizes'),
                    style: TextStyle(
                        fontFamily: AppLocalizations.of(context).translate('font_family'),
                        fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),),

                ),





                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  child: fetchAvailableSize
                ),




                Container(

                  padding: EdgeInsets.all( 15),


                  child: Text(
                    AppLocalizations.of(context).translate('quantity'),
                    style: TextStyle(
                        fontFamily: AppLocalizations.of(context).translate('font_family'),
                        fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),),

                ),




                Container(
                  padding: EdgeInsets.all(12),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Row(
                    children: <Widget>[

                      GestureDetector(

                        child: Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              color: Colors.white
                          ),
                          child: Icon(Icons.remove, color: Colors.black87, size: 20,),
                        ),
                        onTap: (){
                          if(_quantity > 1){
                            //setState(() {
                              _quantity = _quantity - 1;
                          //  });
                          }
                        },
                      ),

                      Container(
                        padding: EdgeInsets.all(7),
                        margin: EdgeInsets.all(4),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),

                            border: Border.all(color: Colors.white, width: 2)
                        ),

                        child: Center(
                          child: Text(_quantity.toString(), style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),),
                        ),
                      ),

                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.all(4),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              color: Colors.white
                          ),
                          child: Icon(Icons.add, color: Colors.black87, size: 20,),
                        ),
                        onTap: (){

                          setState(() {
                           _quantity = _quantity + 1;
                         });
                        },
                      )


                    ],
                  ),
                ),




                Container(

                    padding: EdgeInsets.only(top: 11, left: 15, bottom: 11),

                    alignment: Alignment.topLeft,

                    child: Row(
                      children: <Widget>[
                        Text(AppLocalizations.of(context).translate('total_cost'),style: TextStyle(fontFamily: AppLocalizations.of(context).translate('font_family'), fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),),

                        Text(' ${_quantity * price}',style: TextStyle(fontFamily: AppLocalizations.of(context).translate('font_family'), fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),),

                        Text(' ${AppLocalizations.of(context).translate('qr')} ',
                          style: TextStyle(
                              fontFamily: AppLocalizations.of(context).translate('font_family'), fontSize: 14, color: Colors.blueGrey, fontWeight: FontWeight.w700),),
                      ],
                    )

                ),









                Container(

                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(top: 4),



                  child: Text(AppLocalizations.of(context).translate('desc'),style: TextStyle(fontFamily: AppLocalizations.of(context).translate('font_family'), fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),),

                ),



                Container(

                  width: MediaQuery.of(context).size.width * 0.9,



                  alignment: Alignment.center,

                  padding: EdgeInsets.all( 9),

                  child: Text(

                    description,

                    style: TextStyle(fontWeight: FontWeight.w500, fontFamily: AppLocalizations.of(context).translate('font_family') , color: Colors.white,fontSize: 14),

                  ),

                ),



                Container(

                    child: showWidget == true ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(

                          padding: EdgeInsets.all( 15),



                          child: Text(AppLocalizations.of(context).translate('see_more'),style: TextStyle(fontFamily: AppLocalizations.of(context).translate('font_family'), fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),),

                        ),





                      Container(

                          height: MediaQuery.of(context).size.height * 0.38,

                          child:  Scaffold(

                            backgroundColor: Colors.black,

                            body: _sream,

                          ),
                        ),


                      ],
                    ) : Container(

                    )
                ),



              ],

            ),

          ),



          Container(

              margin: EdgeInsets.only(left: 28, right: 28),



              height: MediaQuery.of(context).size.height * 0.09,

              padding: EdgeInsets.all(4),

              alignment: Alignment.center,


              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  GestureDetector(
                    child: Container(

                      height: MediaQuery.of(context).size.height,

                      alignment: Alignment.center,

                      width: MediaQuery.of(context).size.width - 120,

                      padding: EdgeInsets.only(top: 5,bottom: 5),

                      decoration: BoxDecoration(

                          color: addValue == 0 ? Colors.blueGrey : Colors.greenAccent,

                          borderRadius: BorderRadius.all(Radius.circular(20))

                      ),

                      child: Center(

                          child: addValue == 0 ? Text(AppLocalizations.of(context).translate('add_to_cart'), style: TextStyle(fontSize: 15,color: Colors.white, fontFamily: AppLocalizations.of(context).translate('font_family'), fontWeight: FontWeight.w800),)
                              : Text(AppLocalizations.of(context).translate('added'), style: TextStyle(fontSize: 15,color: Colors.white, fontFamily: AppLocalizations.of(context).translate('font_family'), fontWeight: FontWeight.w800),)

                      ),

                    ),
                    onTap: () async{

                      FirebaseUser user = await FirebaseAuth.instance.currentUser();

                      if(user != null){

                        addProductToCart().then((value){
                          showSnackBar(AppLocalizations.of(context).translate('cart'), Colors.green, Cart(), 'btn_cart');
                        });

                      }else{

                        showSnackBar(AppLocalizations.of(context).translate('no_account'), Colors.blueGrey, SignUp(), 'create_account');


                      }




                    },
                  ),

                  Container(
                    child: GestureDetector(
                      child: favValue == 0 ? Icon(Icons.favorite_border, color: Colors.white, size: 38,) :
                      Icon(Icons.favorite, color: Colors.red, size: 38,),

                      onTap: () async{

                        FirebaseUser user = await FirebaseAuth.instance.currentUser();

                        if(user != null){
                          FirebaseAuth.instance.currentUser().then((user){
                            Firestore.instance.collection('Favorites').document(user.uid).collection('My Favorites').add({
                              'image':'$image',
                              'name':'$name',
                              'price': price,
                              'doc id': '$documentId'
                            }).then((value){

                              setState(() {
                                favValue = 1 ;
                              });

                              showSnackBar(AppLocalizations.of(context).translate('fav'), Colors.green, Favorite(), 'btn_fav');
                            });
                          });

                        }else{
                          showSnackBar(AppLocalizations.of(context).translate('no_account'), Colors.blueGrey, SignUp(), 'create_account');
                        }

                      },
                    ),
                  )
                ],
              )

          )





        ],

      )

    );

  }

  Future<void> addProductToCart()async{


    if (addValue == 0 ){

      var sp = await SharedPreferences.getInstance();
      var size = sp.getInt("size");

      var docIdForSize = sp.getString("documentId");



      FirebaseAuth.instance.currentUser().then((user) async {
        await Firestore.instance.collection('Carts').document(user.uid).collection('My Cart').add({
          'name': '$name',
          'total price' : _quantity * price ,
          'quantitiy': _quantity,
          'image':'$image',
          'size': size,
          'documetId': documentId,
          'size doc Id': docIdForSize
        });

        int totP = _quantity * price;

        final DocumentReference priceRef = Firestore.instance.collection('Cart Details').document(user.uid);
        Firestore.instance.runTransaction((Transaction tx) async {
          DocumentSnapshot postSnapshot = await tx.get(priceRef);
          if (postSnapshot.exists) {
            await tx.update(priceRef, <String, dynamic>{'total price': postSnapshot.data['total price'] + totP });
          }
        });


        setState(() {
          addValue = 1;

        });
      });



    }




  }





}

*/
