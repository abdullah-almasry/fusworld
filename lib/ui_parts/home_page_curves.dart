import 'package:flutter/material.dart';



class HomePageCurves extends StatelessWidget {



  final double _radiusCircular,_height,_width;

  final Color _color;

  final Widget child;





  HomePageCurves(this._radiusCircular,this._height, this._color, this._width, this.child);



  @override

  Widget build(BuildContext context) {

    return ClipRRect(



      borderRadius: BorderRadius.only(bottomRight: Radius.circular(_radiusCircular)),



      child: Container(



        height: MediaQuery.of(context).size.height * _height,



        width: _width,



        color: _color,



        child: child,



      ),



    );

  }

}