import 'package:flutter/material.dart';
import 'package:moneyfreedom/src/app.dart';

class about_page extends StatelessWidget {
  const about_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.grey.shade300,
    appBar: AppBar(
      title: const Text('Tentang'),
    ),
    body:Center(
        child: Container(
          height: 580,
          width: 380,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: 150,
                height: 150,
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage(
                        'images/logo_bg_putih.png',
                      ),
                      fit: BoxFit.fill
                  ),
                ),
              ),
              const Text(
                'Money Freedom',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontFamily: 'Bungee',
                ),
              ),
              Container(
                height: 300,
                width: 330,
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: const Text(
                    'MoneyFreedom adalah aplikasi mobile yang memberikan solusi '
                        'untuk memantau dan mengelola keuangan pribadi. Dengan menginput '
                        'data pengeluaran, aplikasi ini dapat membantu pengguna untuk '
                        'memahami dan menganalisis penggunaan keuangan mereka. Aplikasi ini '
                        'memberikan tampilan yang mudah digunakan dan informasi yang bermanfaat '
                        'bagi pengguna untuk membuat keputusan keuangan yang lebih baik.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.25,
                      color: Colors.black,
                      fontFamily: 'Hind Vadodara',
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
  ) ;
}