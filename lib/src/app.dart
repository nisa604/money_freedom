import 'package:flutter/material.dart';
import '../Screens/menu_button.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MenuButton(),
    );
  }

}