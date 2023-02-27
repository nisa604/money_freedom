import 'package:flutter/material.dart';

class profil_page extends StatelessWidget {
  const profil_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profil'),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          height: 590,
          width: 385,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(
                        'images/man (2).png',
                      ),
                      fit: BoxFit.fill
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (){
                  settingOption(context, 'Ganti Avatar');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.blue.shade300,
                ),
                  child: const Text("Ganti Avatar",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                  ),
              ),
              Container(
                width: 300,
                margin: const EdgeInsets.only(
                  top: 25,
                  bottom: 40,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Nama',
                    // hintText: 'User'
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.blue.shade500,
                ),
                child: const Text("Simpan",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
  GestureDetector settingOption(BuildContext context, String title){
    return GestureDetector(
      onTap: (){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("Option 1"),
                Text("Option 2"),
              ],
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              },
                  child: const Text("Close")
              )
            ],
          );
        });
      },
    );
}
