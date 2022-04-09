import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:managerweb/widgets/qr_create_page.dart';
import 'package:managerweb/widgets/signup/signupmanager.dart';
import 'Background/homeback.dart';
import 'Login.dart';

class Home extends StatelessWidget {
  String uid="mCh2OcakXlSMhbpYaZyhISaYgFY2";
  //Home({Key? key,required this.uid});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:<Widget> [
        const HomeBack(),
        Home2(uid: this.uid,),
      ],
    );
  }
}

class Home2 extends StatefulWidget {
  String uid;
  Home2({Key? key,required this.uid});
  @override
  _home createState() => _home(uid: this.uid);
}

class _home extends State<Home2> {
  String uid;
  _home({Key? key,required this.uid});
  String uname='';
  String uemail='';

  getData() async {
    DocumentReference data = FirebaseFirestore.instance.collection("employee").doc(uid);
    var dbu = await data.get();
    setState(() {
      uname = dbu.get("first name") + ' ' + dbu.get("last name");
      uemail = dbu.get("email");
    });
  }
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) =>Scaffold(
    appBar: AppBar(title:const Text('Home'),),
    backgroundColor: Colors.transparent,
    body: Row(
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width) /4,
          height: MediaQuery. of(context). size.height  ,
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Menu(context),
          ),
        ),
      ],
    ),

  );
  Widget Menu(context){
    return Padding(
      padding: EdgeInsets.only(left:10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text("Manager:  $uname",style: TextStyle(color: Colors.white,fontSize: 20),),

            FlatButton(onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => signupmanager()));
            },
              child:const Text("New Manager" ,style: TextStyle(color: Colors.white,fontSize: 22),),
            ),

            FlatButton(onPressed:(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => signupmanager()));
            },
              child:const Text("New Waiter" ,style: TextStyle(color: Colors.white,fontSize: 22),),
            ),


            FlatButton(
              onPressed:(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => QRCreatePage()));
              },
              child: const Text("Generate QR Codes" ,style: TextStyle(color: Colors.white,fontSize: 22),),
            ),

            Text("Arrange tables" ,style: TextStyle(color: Colors.white,fontSize: 22),),

            FlatButton(
              onPressed:()async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>Loginmanager() ));

              },
              child: const Text("Log out" ,style: TextStyle(color: Colors.white,fontSize: 22),),
            ),
          ],
        ),
      ),
    );

  }
}