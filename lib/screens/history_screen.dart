import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/qr_code_database.dart';
import 'package:qr_scanner/utilities/consts.dart';
import 'package:sizing/sizing.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  QrCodeDatabase? _databaseRef;
  List<Map<String,dynamic>>? _data;

  @override
  void initState(){
    super.initState();
    _databaseRef = QrCodeDatabase.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        elevation: 12.ss,
      ),
      body: FutureBuilder(future: getAllData(), builder: (context,snapshot){
        if(snapshot.hasData && snapshot.data!.isNotEmpty){
          return ListView.separated(
            itemCount: snapshot.data!.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context,int index){
              return ListTile(
                leading: Text('${index+1}'),
                title: Text(snapshot.data![index][Consts.SCAN_TYPE]),
                subtitle: Text(snapshot.data![index][Consts.SCAN_DATA]),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10.ss,);
            },
          );
        }else if(snapshot.data!.isEmpty){
          return Center(child: Text('Empty'),);
        }else {
          return CircularProgressIndicator();
        }
      })
    );
  }

  Future<List<Map<String,dynamic>>> getAllData() async{
    _data = await _databaseRef!.getAllData();
    _data = _data!.reversed.toList();
    return _data!;
  }

}
