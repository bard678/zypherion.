
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zypherion/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
TextEditingController _email=TextEditingController();
TextEditingController _password=TextEditingController();
TextEditingController _user=TextEditingController();
class _LoginScreenState extends State<LoginScreen> {
  Future signUp(String email,String password)async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    User user0=FirebaseAuth.instance.currentUser!;
   print( user0.uid);
    await FirebaseFirestore.instance.collection("for").doc("doc").update({"data":4});
    await FirebaseFirestore.instance.collection("for").doc("doc").update({user0.email!:user0.uid});
    // final user=FirebaseAuth.instance.currentUser;
    // ToggleUser(user!);
  }
  Future signIn(String email,String password)async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
   final user=FirebaseAuth.instance.currentUser;
   if(user!.emailVerified){
   Get.defaultDialog(title: user!.email!);
   }
    ToggleUser(user!);
  }
  Future fire()async{

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width/1.1,
          height:MediaQuery.of(context).size.height/1.1,
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black38,
                    offset: Offset(4, 4)
                ),  BoxShadow(
                    color: Colors.white10,
                    offset: Offset(-4,- 4)
                ),
              ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 15,),
                  const Text("Zypherion",style: TextStyle(fontSize: 40,fontFamily: "python"),),
                  SvgPicture.asset(

                    "assets/zypherion.svg",height: 90,width: 90,),const SizedBox(width: 10,),


                ],
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: SizedBox(
                  width:MediaQuery.of(context).size.width/1.5,
                  child:  TextField(
                    controller: _email,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black38)
                        ),
                        border:  OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black38)
                        ),
                        hintText: "Email"
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: SizedBox(
                  width:MediaQuery.of(context).size.width/1.5,
                  child:  TextField(
                    controller: _password,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black38)
                      ),
                      border:  OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black38)
                      ),
                      hintText: "Password"
                  ),),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    GestureDetector(
               onTap: (){
                 if(_password.text.isNotEmpty&&_email.text.isNotEmpty)
                   {
                  // signUp(_email.text, _password.text);
                    signIn(_email.text, _password.text);
                   }
               },
                      child: Container(

                        height: 50,
                        width: MediaQuery.of(context).size.width/2,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)

                        ),

                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock_open,),
                            SizedBox(width: 20,),
                            Text("Sign in",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Forgot account?",style: TextStyle(fontSize: 15,color: Colors.red),),SizedBox(width: 8,),
                        Text("Sign up for Zypherion?",style: TextStyle(fontSize: 15,color: Colors.green),),
                      ],
                    ),const SizedBox(height: 50,)
                    ,Row(

                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Row(
                          children: [
                            SvgPicture.asset("assets/google.svg",width: 40,height: 40,), const SizedBox(width: 7,),
                            const Text("Google"),
                          ],
                        ),
                        const Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage("assets/github.png",),radius: 22,),
                            SizedBox(width: 7,),
                            Text("GitHub"),
                          ],
                        ),

                        // SvgPicture.asset("assets/github.svg",width: 40,height: 40,),
                      ],)
                  ],
                ),
              )

            ],),
        ),
      ),
    );
  }
}
