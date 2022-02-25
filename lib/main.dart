import 'package:flutter/material.dart';
import 'package:graphql_demo/view_model/character_provider.dart';
import 'package:graphql_demo/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType){
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: CharacterProvider(),),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          ),
        );
      }
    );
  }
}
