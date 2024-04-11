import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zypherion/maindrawer.dart';
import 'package:zypherion/mainstories.dart';
import 'package:zypherion/topbar.dart';


class WebScreenLayout extends StatefulWidget {
 final  String email;
  const WebScreenLayout({super.key,required this.email});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: MainDrawer(),

      floatingActionButton: FloatingActionButton(onPressed: ()async{FilePickerResult? result = await FilePicker.platform.pickFiles();await FirebaseStorage.instance.ref("").child("image.png").putFile(File(result!.files.single.xFile.path));},child: Icon(Icons.add),),
      appBar:
      AppBar(
      toolbarHeight: 70,
      backgroundColor:Colors.black87,
      // title: Text("Zypherion${widget.email}"),
        title: Text("Zypherion"),
      // leading: Padding(
      //   padding: const EdgeInsets.all(4),
      //   child: CircleAvatar(
      //
      //     backgroundImage: AssetImage("assets/natural.jpg"),),
      // ),
      actions: [
      Row(

      children: [

      SizedBox(width: 2,),
      Container(

        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage("assets/natural.jpg"),),
        ),
      ),

      FilledButton(

          style: FilledButton.styleFrom(backgroundColor: Colors.black38,shape:CircleBorder() ,minimumSize: Size(50, 50)),

          onPressed: (){}, child: Icon(Icons.notifications,color: Colors.white,))
      ,

      ],
    ),
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width/2,
          child: TextField(

            decoration: InputDecoration(
              hintText: "Search",
             enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.black)
                 ,borderRadius: BorderRadius.circular(30)
             ),

         disabledBorder:OutlineInputBorder(
             borderSide: BorderSide(color: Colors.black)
             ,borderRadius: BorderRadius.circular(10)
         ) ,
         border: OutlineInputBorder(
           borderSide: BorderSide(color: Colors.black)
               ,borderRadius: BorderRadius.circular(30)
         ),
enabled: true
            ),
          ),
        ),
        SizedBox(width: 30,),
        IconButton(onPressed: (){}, icon: Icon(Icons.search_outlined)), SizedBox(width: 30,),
        IconButton(onPressed: (){}, icon: Icon(Icons.message)),  SizedBox(width: 30,),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),  SizedBox(width: 20,),

      ],
    ),body:
    Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        
        Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 600,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              TopBar(),
              MainStories(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: SizedBox(
                height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                return Shimmer(
                  direction: ShimmerDirection.rtl,
                  period: Duration(milliseconds: 500),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                       Padding(
                         padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                         child: Container(
                          width: MediaQuery.of(context).size.width/3,
                                     height: 50,
                                     decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                                     color: Colors.black
                                     ),
                                     ),
                       ),
                      Container(
                        width: 500,
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      color: Colors.black
                      ),
                      ),
                    ],
                  ),
                ), gradient: LinearGradient(colors: [Color.lerp(Colors.grey, Theme.of(context).scaffoldBackgroundColor, 0.9)!,Theme.of(context).scaffoldBackgroundColor]));
                  },itemCount: 10,),
                ),
              )
              ],
              ),
            ),
          ),
        ),
      ],
    ),
      
    );
  }
}



