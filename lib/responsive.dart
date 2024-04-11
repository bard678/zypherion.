import 'package:flutter/material.dart';


class ResponsiveLay extends StatefulWidget {
  final webScreen;
  final mobileScreen;
  const ResponsiveLay({super.key,required this.mobileScreen,required this.webScreen});

  @override
  State<ResponsiveLay> createState() => _ResponsiveLayState();
}

class _ResponsiveLayState extends State<ResponsiveLay> {
  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(builder: (context,constrain){
      if(constrain.maxWidth>600){
        return widget.webScreen;
      }
      else
        {
          return widget.mobileScreen;
        }
    });
  }
}
