import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:qr_scanner/screens/history_screen.dart';
import 'package:qr_scanner/screens/setting_screen.dart';
import 'package:sizing/sizing.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<ScannerScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  double zoom = 0;


  @override
  Widget build(BuildContext context) {
    if(result!=null){

    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () async{
          await controller!.toggleFlash();
          setState(() {
          });
        }, icon: FutureBuilder(future: controller?.getFlashStatus(), builder: (context,snapshot){
          if(snapshot.hasData){
            return snapshot.data! ?Icon(Icons.flash_on):Icon(Icons.flash_off);
          }else{
            return CircularProgressIndicator();
          }
    })
        ),
        actions: <Widget>[
          IconButton(onPressed: ()async{
            await controller!.flipCamera();
            setState((){
            });
          }, icon: Icon(Icons.flip_camera_ios))
        ],
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
                SizedBox(height: 0.01.sw,),

                SizedBox(
                  width: 0.6.sw,
                    child: RichText(text: TextSpan(text: 'Align the QR Code within the frame to scan',style: Theme.of(context).textTheme.headlineSmall),softWrap: true,textAlign: TextAlign.center,
                    )
                ),

                SizedBox(height: 20.ss,),

                Expanded(child: _buildQrView(context)),
                SizedBox(height: 30.ss,),
                Text('Scanning...',style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: 30.ss,),

              ],
            ),
          ),
        ),
      ),

    );
  }


  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Theme.of(context).colorScheme.inversePrimary,
            borderRadius: 20,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: scanArea),
        onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      ),
        Padding(
          padding: EdgeInsets.only(top: 340.ss,left: 30.ss,right: 30.ss),
          child: Slider(value: zoom, onChanged: (value){
            setState(() {
              zoom = value;
            });
          },
          max: 10,
          divisions: 100,
          label: 'Zoom ' + zoom.round().toString() +'X',),
        ),
      ]
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        showDialogBox(context, result!);
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void showDialogBox(BuildContext context,Barcode result) async{
    await controller?.pauseCamera();
    
    showGeneralDialog(context: context, pageBuilder: (buildContext,animation,secondaryAnimation){
      return PopScope( canPop: false, child: AlertDialog(
        title: Row(
          children: [
            SvgPicture.asset('assets/icons/qr_scanner_icon.svg',width: 25.ss,height: 25.ss,),
            SizedBox(width: 5.ss,),
            Text(result.format.name),
          ],
        ),
        content: Text(result.code.toString()),
        actions: [
          TextButton(onPressed: ()async{
            await controller?.resumeCamera();
            Navigator.pop(buildContext);
          }, child: Text('OK')),
        ],
      )
      );
    });
  }

}
