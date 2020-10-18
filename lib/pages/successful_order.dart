import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'home_page.dart';


class SuccessfulOrder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Column(
              children: [


                Container(
                  height: 320,
                  width: MediaQuery.of(context).size.width - 80,
                  child: new SvgPicture.asset('assets/success.svg',),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 12),
                  child:   Text(
                    'We recieved your order successfully',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                    ),),
                ),


                GestureDetector(
                  child: Text(
                    'Click here to go to main page',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    ),
                  ),

                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                  },
                ),



              ],
            )
        )
    );
  }

}