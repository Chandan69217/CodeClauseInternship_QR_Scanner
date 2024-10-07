import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/database_helper/qr_code_database.dart';
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
        if(snapshot.hasData){
          if(snapshot.data!.isNotEmpty){
            return ListView.separated(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context,int index){
                return ListTile(
                  leading: Text('${index+1}'),
                  title: Text(snapshot.data![index][Consts.SCAN_TYPE]),
                  subtitle: Text(snapshot.data![index][Consts.SCAN_DATA]),
                  onLongPress: (){
                    delete(context, snapshot.data![index][Consts.SERIAL_NO]);
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10.ss,);
              },
            );
          }else{
            return Center(child: Text('Empty'),);
          }
        }else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            if(_data!.isNotEmpty)
              deleteAll(context);
      },label: Text('Delete All'),
          icon: Icon(Icons.delete)),
    );
  }

  Future<List<Map<String,dynamic>>> getAllData() async{
    _data = await _databaseRef!.getAllData();
    _data = _data!.reversed.toList();
    return _data!;
  }

  @override
  void dispose() {
    super.dispose();
    _databaseRef!.closeDatabase();
  }

  void delete(BuildContext context,int serialNo) async {
    showGeneralDialog(context: context, pageBuilder: (buildContext,animation,secondaryAnimation){
      return PopScope( canPop: false, child: AlertDialog(
        title: Row(
          children: [
            Icon(Icons.delete),
            SizedBox(width: 5.ss,),
            Text('Delete'),
          ],
        ),
        content: Text('Are you sure to delete?'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(buildContext);
          }, child: const Text('No')),

          TextButton(onPressed: ()async{
            Navigator.pop(context);
            var isRowEffected = await _databaseRef!.delete(serialNo);
            if(isRowEffected){
              setState(() {
              });
            }
          }, child: const Text('Yes')),
        ],
      )
      );
    });
  }

  void deleteAll(BuildContext context){
    showGeneralDialog(context: context, pageBuilder: (buildContext,animation,secondaryAnimation){
      return PopScope( canPop: false, child: AlertDialog(
        title: Row(
          children: [
            Icon(Icons.delete),
            SizedBox(width: 5.ss,),
            Text('Delete All'),
          ],
        ),
        content: Text('Are you sure to delete all the history?'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(buildContext);
          }, child: const Text('No')),

          TextButton(onPressed: ()async{
            Navigator.pop(context);
            var isRowEffected = await _databaseRef!.deleteAll();
            if(isRowEffected){
              setState(() {
              });
            }
          }, child: const Text('Yes')),
        ],
      )
      );
    });
  }

}
