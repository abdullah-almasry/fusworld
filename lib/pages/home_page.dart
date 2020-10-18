import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:fus_world/pages/product_view.dart';
import 'package:fus_world/pages/products_page.dart';
import 'package:fus_world/pages/profile_page.dart';
import 'package:fus_world/pages/settings_page.dart';
import 'package:fus_world/ui_parts/home_page_curves.dart';
import 'package:fus_world/ui_parts/home_page_vertical_list.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cart_page.dart';

import 'favorite_page.dart';

import 'signup_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 729, height: 1491, allowFontScaling: false);

    return Scaffold(
        body: Stack(
      textDirection: TextDirection.ltr,
      children: <Widget>[
        HomePageCurves(0, 1, Colors.black, double.infinity, null),
        HomePageCurves(40, 0.5, Colors.white, double.infinity, null),
        HomePageCurves(
            40,
            0.45,
            Colors.black,
            MediaQuery.of(context).size.width * 0.8,
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 6),
              child: Text(
                AppLocalizations.of(context).translate('home_page_title'),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(40),
                    fontWeight: FontWeight.bold,
                    fontFamily:
                        AppLocalizations.of(context).translate('font_family')),
              ),
            )),
        Positioned(
          top: 5,
          right: 5,
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Container(
            child: Column(
              children: <Widget>[
                HomePageVerticalList(Icons.person, Profile()),
                HomePageVerticalList(Icons.favorite, Favorite()),
                HomePageVerticalList(Icons.shopping_basket, Cart()),
                HomePageVerticalList(Icons.settings, Settings()),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Image(image: AssetImage('assets/logo.jpg')),
        ),
        Align(
          alignment: Alignment(0, 0.5),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.363,
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('Shoes')
                  .orderBy('time', descending: true)
                  .limit(5)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return new Center(
                    child: CircularProgressIndicator(),
                  );

                return new CarouselSlider.builder(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.5,
                    viewportFraction: 0.5,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) =>
                      _buildListItem(snapshot.data.documents[index], index),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 50,
          child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.37,
                  height: MediaQuery.of(context).size.width * 0.28,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 7),
                          child: Icon(
                            Icons.chat_bubble_outline,
                            size: 25,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('contact_us'),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppLocalizations.of(context)
                                    .translate('font_family'),
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            'FUS World Help Center',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Mulish',
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  FlutterOpenWhatsapp.sendSingleMessage("+97450039078", '');
                },
              )),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.width * 0.25,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(20))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 7),
                          child: Icon(
                            Icons.person_add,
                            size: 25,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            AppLocalizations.of(context).translate('join_now'),
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppLocalizations.of(context)
                                    .translate('font_family'),
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            'FUS World',
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Mulish',
                                color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              },
            )),
      ],
    ));
  }

  Widget _buildListItem(DocumentSnapshot document, int index) {
    if (index == 3) {
      return GestureDetector(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.3,
            //height: 170,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(),
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.32,
                    padding: EdgeInsets.only(top: 33),
                    child: Text(
                      AppLocalizations.of(context).translate('click_here'),
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppLocalizations.of(context)
                              .translate('font_family')),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      Icons.navigate_next,
                      size: 30,
                      color: Colors.blueGrey,
                    ),
                  )
                ],
              ),
            )),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Products()));
        },
      );
    }

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
                  height: MediaQuery.of(context).size.height * 0.17,
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
                  margin: EdgeInsets.only(left: 7, right: 7),
                  child: Text(
                    document.data['en-name'],
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      fontFamily:
                          AppLocalizations.of(context).translate('font_family'),
                    ),
                  ),
                ),

                ///3
                Container(
                  margin: EdgeInsets.all(1),
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 7),
                  child: Text(
                    AppLocalizations.of(context).translate('new'),
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.green,
                        fontFamily: 'Mulish'),
                  ),
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
                                      document.data['price'].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: AppLocalizations.of(context)
                                            .translate('font_family'),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate('qr'),
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontFamily: AppLocalizations.of(context)
                                            .translate('font_family'),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          ),

                          //Spacer(),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20)),
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
                        ]),
                  ),
                )
              ],
            ),
          )),
      onTap: () {
        List<String> images = List.from(document['images']);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductView(
                    document.documentID,
                    document['en-name'],
                    document['price'],
                    document[
                        '${AppLocalizations.of(context).translate('shoe-desc')}'],
                    document['image'],
                    images,
                    document['key'],
                    true)));
      },
    );
  }
}
