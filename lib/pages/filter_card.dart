import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fus_world/functions/localizations.dart';
import 'package:fus_world/pages/products_page.dart';
import 'package:group_radio_button/group_radio_button.dart';


class SowFilterDialog extends StatefulWidget {
  @override
  _SowFilterDialogState createState() => _SowFilterDialogState();
}

class _SowFilterDialogState extends State<SowFilterDialog> {




  double sliderValue = 400.0;

  String genderValue;

  String _fontFamily;



  void setData()async{

    Locale myLocale = Localizations.localeOf(context);

    FirebaseUser user = await FirebaseAuth.instance.currentUser();


    if(user != null){


      FirebaseAuth.instance.currentUser().then((user){

        Firestore.instance.collection('Users').document(user.uid).get().then((DocumentSnapshot snapshot){

          if(snapshot.data['lang code'] == "ar"){

            setState(() {
              _fontFamily = 'Kufi';

            });

          }else{
            setState(() {
              _fontFamily = 'Mulish';

            });
          }


        });

      });



    }else{

      if (myLocale.toString() == "ar" ){
        setState(() {
          _fontFamily = 'Kufi';

        });
      }else{
        setState(() {
          _fontFamily = 'Mulish';

        });
      }



    }

  }

  String _verticalGroupValue = 'All';


  List<String> _status = ['All', 'Men','Women'];


  @override
  Widget build(BuildContext context) {

    setData();


    return Scaffold(


      body: Container(
        margin: EdgeInsets.all(15),
        child: Center(
          child: Column(
              children: <Widget>[


          Container(

          margin: EdgeInsets.all(7),
          child: Text(AppLocalizations.of(context).translate('gender'), style: TextStyle(color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 17,
              fontFamily: _fontFamily
          ),
          ),

        ),

        RadioGroup <String>.builder(

        groupValue:_verticalGroupValue,

        onChanged: (value){
          setState(() {
            _verticalGroupValue = value;
          });
        },

        items: _status,
        itemBuilder: (item) => RadioButtonBuilder(item),
      ),


      Container(

        margin: EdgeInsets.all(13),
        child: Text(AppLocalizations.of(context).translate('price'), style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 17,
            fontFamily: _fontFamily
        ),
        ),

      ),


      Container(
        margin: EdgeInsets.only(top: 3),
        child: Slider(




            value: sliderValue,

            min: 250.0,

            max: 450.0,



            activeColor: Colors.blueGrey,

            inactiveColor: Colors.blue,

            divisions: 20,

            label: '${sliderValue.round()}',


            onChanged: (double value) {
              setState(() {
                sliderValue = value;
              });
            }

        ),
      ),


      Container(

          margin: EdgeInsets.all(3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('${AppLocalizations.of(context).translate('greatest_price')} ', style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  fontFamily: _fontFamily
              ),
              ),
              Text('${sliderValue.round().toString()}', style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  fontFamily: _fontFamily
              ),
              ),
            ],
          )

      ),


      GestureDetector(
        child: Container(


          margin: EdgeInsets.all(20),


          height: 50,

          width: 150,

          decoration: BoxDecoration(

              color: Colors.blueGrey,

              borderRadius: BorderRadius.circular(20)

          ),

          child: Center(
            child: Text(AppLocalizations.of(context).translate('filter'), style: TextStyle(fontFamily: _fontFamily,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15),),
          ),


        ),
        onTap: () {

          Navigator.push(context, MaterialPageRoute(builder: (context) => FilterProducts(_verticalGroupValue, sliderValue.round())));

        },
      )

      ],
    ),)
    ,
    )
    );
  }
}