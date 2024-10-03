import 'package:flutter/material.dart';
import 'package:qr_scanner/screens/home_dashboard_screen.dart';
import 'package:sizing/sizing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizingBuilder(
      systemFontScale: true,
      builder: () {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: TextTheme(
              headlineMedium: TextStyle(fontSize: 28.fss.self(allow: true),fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.onPrimary),
              headlineSmall: TextStyle(fontSize: 20.fss.self(allow: true),fontWeight: FontWeight.w400,color: Colors.black,)
            )
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return HomeDashboardScreen();
  }
}
