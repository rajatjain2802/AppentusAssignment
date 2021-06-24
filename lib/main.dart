import 'package:appentus_assignment/model/view/PhotoViewModel.dart';
import 'package:appentus_assignment/ui/HomeScreen.dart';
import 'package:appentus_assignment/ui/LoginScreen.dart';
import 'package:appentus_assignment/ui/PhotoScreen.dart';
import 'package:appentus_assignment/ui/RegistrationScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/network/api/BaseApi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    BaseApis.setEnvironment(Environment.STAGING);
  } else {
    BaseApis.setEnvironment(Environment.PROD);
  }
  runApp(ChangeNotifierProvider<PhotoViewModel>(
    create: (context) => PhotoViewModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => RegistrationScreen(),
        '/home': (context) => HomeScreen(),
        '/photo': (context) => PhotoScreen()
      },
    );
  }
}
