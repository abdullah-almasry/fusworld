import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:fus_world/pages/product_view.dart';
import 'package:fus_world/pages/shoes_view.dart';
import 'package:photo_view/photo_view.dart';

import 'cart_page.dart';
import 'filter_card.dart';


class Products extends StatefulWidget {






  @override

  _ProductsState createState() => _ProductsState();

}



class _ProductsState extends State<Products> {








  @override
  Widget build(BuildContext context) {



    return Scaffold(
        backgroundColor: Colors.black,


        appBar: AppBar(


          leading: IconButton(icon: Icon(Icons.filter_list, size: 26, color: Colors.white,),
              onPressed: (){


                Navigator.push(context, MaterialPageRoute(builder: (context) => SowFilterDialog()));



              }
          ),

          elevation: 0.0,

          backgroundColor: Colors.black,

          actions: <Widget>[





            Spacer(),



            IconButton(
                icon: Icon(Icons.shopping_basket, size: 26, color: Colors.white,),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
                }
            ),





          ],

        ),
        body: Container(
          height: MediaQuery.of(context).size.height,

          child: ListView(

            children: <Widget>[

              Container(

                child:  Column(


                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[

                    Container(



                      padding: EdgeInsets.all(12),

                      child:  Text(AppLocalizations.of(context).translate('coming_soon'),
                        style: TextStyle(

                            fontSize: 17,

                            color: Colors.white,

                            fontWeight: FontWeight.w600,

                            fontFamily: AppLocalizations.of(context).translate('font_family')

                        ),),

                    ),





                    Container(


                      child:  StreamBuilder(

                        stream: Firestore.instance.collection('Coming Soon').snapshots(),

                        builder: (context, snapshot) {




                          if (!snapshot.hasData)
                            return new Center(child: CircularProgressIndicator(),);




                          return new CarouselSlider.builder(



                            options:  CarouselOptions(


                                height: MediaQuery.of(context).size.height * 0.25,


                                autoPlay: true




                            ),


                            itemCount: snapshot.data.documents.length,

                            itemBuilder: (context, index ) => _buildListItem(snapshot.data.documents[index], index),



                          );
                        },
                      ),

                      /* child: CarouselSlider(

                        options: CarouselOptions(

                            height: 170.0,

                            autoPlay: true

                        ),



                        items: [1,2,3,4,5].map((i) {

                          return Builder(

                            builder: (BuildContext context) {

                              return Container(

                                  width: MediaQuery.of(context).size.width,

                                  margin: EdgeInsets.symmetric(horizontal: 5.0),

                                  decoration: BoxDecoration(

                                      color: Colors.deepPurple,

                                      borderRadius: BorderRadius.circular(20),

                                      image: DecorationImage(

                                          image: AssetImage('assets/tst.jpg'),

                                          fit: BoxFit.fill

                                      )

                                  ),

                                  child: Container(

                                    decoration: BoxDecoration(



                                    ),

                                  )

                              );

                            },

                          );

                        }).toList(),

                      ),*/

                    ),



                    Container(

                      padding: EdgeInsets.all(15),


                      margin: EdgeInsets.only(top: 15),

                      child:  Text(AppLocalizations.of(context).translate('available_now'),
                        style: TextStyle(

                            fontSize: 18,

                            color: Colors.white,

                            fontWeight: FontWeight.w800,

                            fontFamily: AppLocalizations.of(context).translate('font_family')

                        ),),

                    ),
                  ],
                ),
              ),

              Container(



                child: StreamBuilder<QuerySnapshot>(

                  stream: Firestore.instance.collection('Shoes').snapshots(),

                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                    if (snapshot.hasError)
                      return new Center(
                        child: CircularProgressIndicator(),
                      );

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        return new ListView(

                          physics: NeverScrollableScrollPhysics(),

                          scrollDirection: Axis.vertical,

                          shrinkWrap: true,

                          children: snapshot.data.documents.map((DocumentSnapshot document) {
                            return new GestureDetector(
                              child: Container(

                                margin: EdgeInsets.all(12),



                                height: MediaQuery.of(context).size.height * 0.2,

                                width: MediaQuery.of(context).size.width * 0.9,

                                alignment: Alignment.center,



                                decoration: BoxDecoration(

                                    color: Colors.white,

                                    borderRadius: BorderRadius.circular(14)

                                ),



                                child: Row(

                                    children: <Widget>[



                                      Container(
                                        child: ClipRRect(

                                          borderRadius: BorderRadius.all(Radius.circular(14)),


                                          child: Image(image: NetworkImage(document.data['image']), fit: BoxFit.cover,width: MediaQuery.of(context).size.width * 0.34, height: double.infinity,),


                                        ),
                                        margin: EdgeInsets.all(3),
                                      ),




                                      Container(


                                        child: Column(

                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: <Widget>[



                                            Container(

                                              margin: EdgeInsets.only(top: 5),

                                              width: MediaQuery.of(context).size.width * 0.51,

                                              child: Text(document.data['en-name'],
                                                style: TextStyle(

                                                    color: Colors.black,

                                                    fontWeight: FontWeight.w500,

                                                    fontFamily: AppLocalizations.of(context).translate('font_family'),

                                                    fontSize: double.tryParse(AppLocalizations.of(context).translate('font_size'))

                                                ),),

                                            ),



                                            Container(
                                              margin: EdgeInsets.only(top: 4),

                                              child: RatingBarIndicator(


                                                rating: 4.8,

                                                itemBuilder: (context, index) => Icon(

                                                  Icons.star,

                                                  color: Colors.amber,

                                                ),

                                                itemCount: 5,

                                                itemSize: 25.0,

                                                direction: Axis.horizontal,

                                              ),
                                            ),



                                            Container(

                                              margin: EdgeInsets.only(top: 4.5),

                                              alignment: Alignment.topLeft,

                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,

                                                children: [


                                                  Text( document.data['price'].toString(), style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, fontFamily: AppLocalizations.of(context).translate('font_family')),),

                                                  Text(' ${AppLocalizations.of(context).translate('qr')}', style: TextStyle(fontFamily: AppLocalizations.of(context).translate('font_family'), fontSize: 12, color: Colors.blueGrey),),

                                                ],
                                              ),

                                            )







                                          ],

                                        ),

                                      ),





                                    ]

                                ),



                              ),
                              onTap: (){


                                print(document['key']);

                                List<String> images = List.from(document['images']);

                                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    ProductView(
                                        document.documentID,
                                        document['en-name'],
                                        document['price'],
                                        document['${AppLocalizations.of(context).translate('shoe-desc')}'],
                                        document['image'],
                                        images,
                                        document['key'],
                                        true
                                    )));

                              },
                            );

                          }).toList(),
                        );
                    }
                  },
                ),
              )

            ],
          ),
        )
    );
  }

  Widget _buildListItem(DocumentSnapshot document, int index){

    return GestureDetector(
      child:  Container(

          width: MediaQuery.of(context).size.width,

          margin: EdgeInsets.symmetric(horizontal: 5.0),

          decoration: BoxDecoration(

              color: Colors.deepPurple,

              borderRadius: BorderRadius.circular(20),

              image: DecorationImage(

                  image: NetworkImage(document.data['image']),

                  fit: BoxFit.fill

              )

          ),

          child: Container(

            decoration: BoxDecoration(



            ),

          )

      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ShoesView(document.data['image'])));
      },
    );
  }


}



class FilterProducts extends StatefulWidget {


  String gender = "All";
  int greatestPrice = 400;

  FilterProducts(this.gender, this.greatestPrice);




  @override

  _FilterProductsState createState() => _FilterProductsState();

}



class _FilterProductsState extends State<FilterProducts> {




  String get gender => widget.gender;
  int get price => widget.greatestPrice;





  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.black,


      appBar: AppBar(


        elevation: 0.0,

        backgroundColor: Colors.black,

        actions: <Widget>[





          Spacer(),



          IconButton(
              icon: Icon(Icons.shopping_basket, size: 26, color: Colors.white,),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
              }
          ),





        ],

      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('Shoes')
            .where('price', isLessThanOrEqualTo: price ).where('gender', isEqualTo: gender).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if(!snapshot.hasData){
            return Center(child: Text('No Shoes matches your filter',style: TextStyle(color: Colors.white),),);
          }

          if (snapshot.hasError)
            return new Center(
              child: CircularProgressIndicator(),
            );

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Center(
                child: CircularProgressIndicator(),
              );
            default:
              return new ListView(

                physics: NeverScrollableScrollPhysics(),

                scrollDirection: Axis.vertical,

                shrinkWrap: true,

                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  return new GestureDetector(
                    child: Container(

                      margin: EdgeInsets.all(12),



                      height: MediaQuery.of(context).size.height * 0.2,

                      width: MediaQuery.of(context).size.width * 0.9,

                      alignment: Alignment.center,



                      decoration: BoxDecoration(

                          color: Colors.white,

                          borderRadius: BorderRadius.circular(14)

                      ),



                      child: Row(

                          children: <Widget>[



                            GestureDetector(
                              child: Container(
                                child: ClipRRect(

                                  borderRadius: BorderRadius.all(Radius.circular(14)),


                                  child: Image(image: NetworkImage(document.data['image'], ), fit: BoxFit.cover,width: MediaQuery.of(context).size.width * 0.34, height: double.infinity,),



                                ),
                                margin: EdgeInsets.all(3),
                              ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ShoesView(document.data['image']) ));
                              },
                            ),




                            Container(


                              child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: <Widget>[



                                  Container(

                                    margin: EdgeInsets.only(top: 5),

                                    width: MediaQuery.of(context).size.width * 0.51,

                                    child: Text(document.data['en-name'],
                                      style: TextStyle(

                                          color: Colors.black,

                                          fontWeight: FontWeight.w500,

                                          fontFamily: AppLocalizations.of(context).translate('font_family'),

                                          fontSize: double.tryParse(AppLocalizations.of(context).translate('font_size'))

                                      ),),

                                  ),



                                  Container(
                                    margin: EdgeInsets.only(top: 4),

                                    child: RatingBarIndicator(


                                      rating: 4.8,

                                      itemBuilder: (context, index) => Icon(

                                        Icons.star,

                                        color: Colors.amber,

                                      ),

                                      itemCount: 5,

                                      itemSize: 25.0,

                                      direction: Axis.horizontal,

                                    ),
                                  ),



                                  Container(

                                    margin: EdgeInsets.only(top: 4.5),

                                    alignment: Alignment.topLeft,

                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [


                                        Text( document.data['price'].toString(), style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, fontFamily: AppLocalizations.of(context).translate('font_family')),),

                                        Text(' ${AppLocalizations.of(context).translate('qr')}', style: TextStyle(fontFamily: AppLocalizations.of(context).translate('font_family'), fontSize: 12, color: Colors.blueGrey),),

                                      ],
                                    ),

                                  )







                                ],

                              ),

                            ),





                          ]

                      ),



                    ),
                    onTap: (){

                      List<String> images = List.from(document['images']);

                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          ProductView(
                              document.documentID,
                              document['${AppLocalizations.of(context).translate('name')}'],
                              document['price'],
                              document['${AppLocalizations.of(context).translate('shoe-desc')}'],
                              document['image'],
                              images,
                              document['key'],
                              true
                          )));

                    },
                  );

                }).toList(),
              );
          }
        },
      ),
    );
  }



}
/*import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:fus_world/pages/product_view.dart';

import 'cart_page.dart';
import 'filter_card.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.filter_list,
                size: 26,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SowFilterDialog()));
              }),
          elevation: 0.0,
          backgroundColor: Colors.black,
          actions: <Widget>[
            Spacer(),
            IconButton(
                icon: Icon(
                  Icons.shopping_basket,
                  size: 26,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                }),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        AppLocalizations.of(context).translate('coming_soon'),
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppLocalizations.of(context)
                                .translate('font_family')),
                      ),
                    ),
                    Container(
                      child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('Coming Soon')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return new Center(
                              child: CircularProgressIndicator(),
                            );

                          return new CarouselSlider.builder(
                            options: CarouselOptions(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                autoPlay: true),
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) => _buildListItem(
                                snapshot.data.documents[index], index),
                          );
                        },
                      ),

                      /* child: CarouselSlider(

                        options: CarouselOptions(

                            height: 170.0,

                            autoPlay: true

                        ),



                        items: [1,2,3,4,5].map((i) {

                          return Builder(

                            builder: (BuildContext context) {

                              return Container(

                                  width: MediaQuery.of(context).size.width,

                                  margin: EdgeInsets.symmetric(horizontal: 5.0),

                                  decoration: BoxDecoration(

                                      color: Colors.deepPurple,

                                      borderRadius: BorderRadius.circular(20),

                                      image: DecorationImage(

                                          image: AssetImage('assets/tst.jpg'),

                                          fit: BoxFit.fill

                                      )

                                  ),

                                  child: Container(

                                    decoration: BoxDecoration(



                                    ),

                                  )

                              );

                            },

                          );

                        }).toList(),

                      ),*/
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.only(top: 15),
                      child: Text(
                        AppLocalizations.of(context).translate('available_now'),
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontFamily: AppLocalizations.of(context)
                                .translate('font_family')),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('Shoes').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return new Center(
                        child: CircularProgressIndicator(),
                      );

                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        return new ListView(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            return new GestureDetector(
                              child: Container(
                                margin: EdgeInsets.all(12),
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.9,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14)),
                                child: Row(children: <Widget>[
                                  Container(
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(14)),
                                      child: Image(
                                        image: NetworkImage(
                                            document.data['image']),
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.34,
                                        height: double.infinity,
                                      ),
                                    ),
                                    margin: EdgeInsets.all(3),
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.51,
                                          child: Text(
                                            document.data[
                                                '${AppLocalizations.of(context).translate('name')}'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: AppLocalizations.of(
                                                        context)
                                                    .translate('font_family'),
                                                fontSize: double.tryParse(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            'font_size'))),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 4),
                                          child: RatingBarIndicator(
                                            rating: 4.8,
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: 25.0,
                                            direction: Axis.horizontal,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 4.5),
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                document.data['price']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                'font_family')),
                                              ),
                                              Text(
                                                ' ${AppLocalizations.of(context).translate('qr')}',
                                                style: TextStyle(
                                                    fontFamily:
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                'font_family'),
                                                    fontSize: 12,
                                                    color: Colors.blueGrey),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                              onTap: () {
                                print(document['key']);

                                List<String> images =
                                    List.from(document['images']);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductView(
                                            document.documentID,
                                            document[
                                                '${AppLocalizations.of(context).translate('name')}'],
                                            document['price'],
                                            document[
                                                '${AppLocalizations.of(context).translate('shoe-desc')}'],
                                            document['image'],
                                            images,
                                            document['key'],
                                            true)));
                              },
                            );
                          }).toList(),
                        );
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildListItem(DocumentSnapshot document, int index) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: NetworkImage(document.data['image']), fit: BoxFit.fill)),
        child: Container(
          decoration: BoxDecoration(),
        ));
  }
}

class FilterProducts extends StatefulWidget {
  String gender = "All";
  int greatestPrice = 400;

  FilterProducts(this.gender, this.greatestPrice);

  @override
  _FilterProductsState createState() => _FilterProductsState();
}

class _FilterProductsState extends State<FilterProducts> {
  String get gender => widget.gender;
  int get price => widget.greatestPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
        actions: <Widget>[
          Spacer(),
          IconButton(
              icon: Icon(
                Icons.shopping_basket,
                size: 26,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              }),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('Shoes')
            .where('price', isLessThanOrEqualTo: price)
            .where('gender', isEqualTo: gender)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'No Shoes matches your filter',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          if (snapshot.hasError)
            return new Center(
              child: CircularProgressIndicator(),
            );

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Center(
                child: CircularProgressIndicator(),
              );
            default:
              return new ListView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return new GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(12),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.9,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14)),
                      child: Row(children: <Widget>[
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                            child: Image(
                              image: NetworkImage(document.data['image']),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.34,
                              height: double.infinity,
                            ),
                          ),
                          margin: EdgeInsets.all(3),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                width: MediaQuery.of(context).size.width * 0.51,
                                child: Text(
                                  document.data[
                                      '${AppLocalizations.of(context).translate('name')}'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: AppLocalizations.of(context)
                                          .translate('font_family'),
                                      fontSize: double.tryParse(
                                          AppLocalizations.of(context)
                                              .translate('font_size'))),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                child: RatingBarIndicator(
                                  rating: 4.8,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 25.0,
                                  direction: Axis.horizontal,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 4.5),
                                alignment: Alignment.topLeft,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      document.data['price'].toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              AppLocalizations.of(context)
                                                  .translate('font_family')),
                                    ),
                                    Text(
                                      ' ${AppLocalizations.of(context).translate('qr')}',
                                      style: TextStyle(
                                          fontFamily:
                                              AppLocalizations.of(context)
                                                  .translate('font_family'),
                                          fontSize: 12,
                                          color: Colors.blueGrey),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                    ),
                    onTap: () {
                      List<String> images = List.from(document['images']);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductView(
                                  document.documentID,
                                  document[
                                      '${AppLocalizations.of(context).translate('name')}'],
                                  document['price'],
                                  document[
                                      '${AppLocalizations.of(context).translate('shoe-desc')}'],
                                  document['image'],
                                  images,
                                  document['key'],
                                  true)));
                    },
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}
*/