

import 'package:qr_scanner/utilities/consts.dart';

class QRData{
  String logo;
  String scanType;
  String scanData;
  String dateTime;

  QRData._privateContructor({required this.logo,required this.dateTime,required this.scanData,required this.scanType});

  factory QRData(Map<String,dynamic> data){
    return QRData._privateContructor(logo: data[Consts.LOGO], dateTime: data[Consts.DATE_TIME], scanData: data[Consts.SCAN_DATA], scanType: data[Consts.SCAN_TYPE]);
  }

}