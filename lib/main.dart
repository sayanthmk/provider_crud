import 'package:crud_provider/addstudent.dart';
import 'package:crud_provider/changenotifier.dart';
import 'package:crud_provider/gridview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(
  //   MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(create: (_) => StudentProvider()),
  //     ],
  //     child: const MyApp(),
  //   ),
  // );
  //muliprovder for the state for the timecomplexty of the state in the value of the value change the value for the change the value
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StudentProvider(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Student Database',
            theme: ThemeData(
              primarySwatch: Colors.amber,
            ),
            home: const HomeScreen(),
          ),
        ),
      ],
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Center(
            child: Text(
          'Student Database',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
        )),
      ),
      body: const GridList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddStudentWidget()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
