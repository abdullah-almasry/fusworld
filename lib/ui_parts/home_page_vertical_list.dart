import 'package:flutter/material.dart';

class HomePageVerticalList extends StatelessWidget {

  final IconData _icon;
   final Widget _class;
   HomePageVerticalList(this._icon, this._class)


;build(BuildContext context) {
    return Expanded(

        flex: 3,

        child: IconButton(

          icon: Icon(

            _icon,

            color: Colors.black,

            size: 25,

          ),

          onPressed: (){

            Navigator.push(context, MaterialPageRoute(builder: (context) => _class));

          },

        )

    );
  }
}
