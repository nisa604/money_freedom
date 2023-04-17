import 'package:flutter/material.dart';
import 'menu_button.dart';

// class splash_page extends StatelessWidget {
//   const splash_page({Key? key}) : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           child: Text('Splash Screen', style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold
//           ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class Splash_Page extends StatefulWidget {
  const Splash_Page({Key? key}) : super(key: key);

  @override
  State<Splash_Page> createState() => _Splash_PageState();
}

class _Splash_PageState extends State<Splash_Page> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(Duration(seconds: 2),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MenuButton()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          children: [
            Container(
              width: 400,
              height: 250,
              margin: const EdgeInsets.only(
                bottom: 10,
              ),
              // decoration: BoxDecoration(
              //   color: Colors.grey.shade200,
              //   borderRadius: BorderRadius.circular(16.0),
              // ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  // Container(
                  //
                  // ),
                  // Container(
                  //
                  // ),
                ],
              ),
            ),
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 20,
              ),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(
                      'images/logo_bg_biru.png',
                    ),
                    fit: BoxFit.fill
                ),
              ),
            ),
          const Text('MoneyFreedom',
            style: TextStyle(
              fontSize: 28,
              fontFamily:'Bungee',
              fontWeight: FontWeight.bold,
              // backgroundColor: Colors.white
            ),
            ),
          ],
          // decoration: BoxDecoration(
          //   color: Colors.grey.shade300,
          //   borderRadius: const BorderRadius.all(Radius.circular(10)),
          // ),
        ),
      ),
    );
  }
}


