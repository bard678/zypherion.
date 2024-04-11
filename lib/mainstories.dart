import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zypherion/topbar.dart';



class MainStories extends StatefulWidget {

  const MainStories({super.key});

  @override
  State<MainStories> createState() => _MainStoriesState();
}

class _MainStoriesState extends State<MainStories> {
  String _path="";
  Future getUrl(String fileName)async{
     String path=await FirebaseStorage.instance.ref(FirebaseAuth.instance.currentUser!.uid).child(fileName).getDownloadURL();
    _path=path;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return    Row(
mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(2),
          child:
          Column(children: [
            Container(
              width: 180,
              height: 200,
              child:Padding(
                padding: const EdgeInsets.all(1),
                child: FutureBuilder<FilePickerResult?>(future: result, builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  else if(snapshot.hasData){
                    final image=snapshot.data;

                FirebaseStorage.instance.ref("").child("path.png").putFile(File(image!.files.single.path!));
                 getUrl(image.files.single.name);
                    return  Image.network(_path);

                  }
                  else return SizedBox(

                    child: IconButton(
                        onPressed: ()async{
                        result=    FilePicker.platform.pickFiles(
                            type: FileType.image
                        ); FilePickerResult? result0=  await  FilePicker.platform.pickFiles(
                            type: FileType.image
                        );
                        await   FirebaseStorage.instance.ref(FirebaseAuth.instance.currentUser!.uid).child(result0!.files.single.name).putFile(File(result0!.files.single.path!));

                        setState(() {

                        });

                        if(result.isNull){}
                        else{
                          MainStories();
                        }

                      },
                        icon: Icon(Icons.add_circle_rounded,color: Colors.green,size: 20,),splashRadius: 2,),
                  );
                }),
              )
                 ,
              decoration: BoxDecoration(
color: Colors.black,
                  borderRadius: BorderRadius.circular(10)
              ),
            )
          ],),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: 200*2,

            height: 220,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){

                  return Padding(
                    padding: const EdgeInsets.all(2),
                    // child: Shimmer.fromColors(child:
                    // Column(children: [
                    //   Container(
                    //     width: 100,
                    //     height: 120,
                    //     decoration: BoxDecoration(
                    //         color: Colors.black,
                    //         borderRadius: BorderRadius.circular(10)
                    //     ),
                    //   )
                    // ],),
                    //     baseColor: Colors.grey.shade700, highlightColor: Colors.black),
                  child:  Column(children: [
                    Container(
                      width: 180,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)
                      ),
                    )
                  ],),
                  );
                },itemCount: 2,),
            ),
          ),
        ),
      ],
    );
  }
}