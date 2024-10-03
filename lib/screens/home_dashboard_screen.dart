import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_scanner/widgets.dart';
import 'package:sizing/sizing.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan',style: Theme.of(context).textTheme.headlineMedium,),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.ss),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 0.15.sw,),

                SizedBox(
                  width: 0.6.sw,
                    child: RichText(text: TextSpan(text: 'Align the QR Code within the frame to scan',style: Theme.of(context).textTheme.headlineSmall),softWrap: true,textAlign: TextAlign.center,
                    )
                ),

                SizedBox(height: 30.ss,),

                Expanded(child: QRScanner()),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
        BottomNavigationBarItem(label: '', icon: Expanded(child: SizedBox())),
        BottomNavigationBarItem(icon: Icon(Icons.history),label: 'History'),
      ],
      currentIndex: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: (){},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0.5.sh))),
        child: SvgPicture.asset('assets/icons/qr_scanner_icon.svg',width: 25,height: 25,),
      ),
    );
  }



}
