import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_scanner/screens/history_screen.dart';
import 'package:qr_scanner/screens/scanner_screen.dart';
import 'package:qr_scanner/screens/setting_screen.dart';
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
              headlineMedium: TextStyle(fontSize: 28.fss.self(allow: true),fontWeight: FontWeight.w500,),
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
  int currentIndex = 1;
  List<Widget> screen = [SettingScreen(),ScannerScreen(),HistoryScreen()];

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screen[currentIndex],

      bottomNavigationBar:  BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
        BottomNavigationBarItem(label: '', icon: Expanded(child: SizedBox())),
        BottomNavigationBarItem(icon: Icon(Icons.history),label: 'History'),
      ],
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: (){
        setState(() {
          currentIndex = 1;
        });
     },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0.5.sh))),
        child: SvgPicture.asset('assets/icons/qr_scanner_icon.svg',width: 25,height: 25,),
      ),
    );
  }
}
