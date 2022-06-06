import 'package:flutter/material.dart';
import 'package:medicine/pages/mainPage.dart';
import 'package:medicine/repositories/hive.dart';
import 'package:medicine/repositories/medicine_log_repository.dart';
import 'package:medicine/repositories/medicine_repository.dart';
import 'package:medicine/services/notification_service.dart';
import 'package:medicine/calendar/calendar.dart';
import 'package:medicine/calendar/event.dart';
import 'package:medicine/calendar/sp_utils.dart';
import 'package:medicine/calendar/todo_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:medicine/mytodolist/mytodolist.dart';

final notification = NotificationService();
final hive = HiveStorage();
final medicineRepository = MedicineRepository();
final LogRepository = MedicineLogRepository();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notification = NotificationService();
  await notification.initializeTimeZone();
  await notification.initializeNotification();
  await hive.initializeHive();
  await SpUtils().init().then((value) => null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do List',
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  TextEditingController editingController = TextEditingController();

  // DateTime addDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('To Do List With Medicine',
            style: Theme.of(context).textTheme.headline4),
        backgroundColor: Colors.blue[600],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 1,
            ),
            SizedBox(
              height: 150,
              width: 150,
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/icon.png'),
                backgroundColor: Colors.blue[600],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new Calendar()),
                );
              },
              icon: Icon(
                Icons.calendar_month,
                size: 30,
                color: Colors.grey[850],
              ),
              label: Text(
                'Calendar',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey[850],
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue[400],
                  onSurface: Colors.pink,
                  minimumSize: Size(250, 50)),
            ),
            // ElevatedButton.icon(
            //   onPressed: () {
            //     _showCupertinoDatePicker();
            //   },
            //   icon: Icon(
            //     Icons.add_alert_rounded,
            //     size: 30,
            //     color: Colors.grey[850],
            //   ),
            //   label: Text(
            //     'Add Event',
            //     style: TextStyle(
            //       fontSize: 25,
            //       color: Colors.grey[850],
            //     ),
            //   ),
            //   style: ElevatedButton.styleFrom(
            //       primary: Colors.blue[400],
            //       onSurface: Colors.pink,
            //       minimumSize: Size(250, 50)),
            // ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              },
              icon: Icon(
                Icons.add_alert_rounded,
                size: 30,
                color: Colors.grey[850],
              ),
              label: Text(
                'New Medicine',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey[850],
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue[400],
                  onSurface: Colors.pink,
                  minimumSize: Size(250, 50)),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new Mytodolist()),
                );

                print('Check todo list');
              },
              icon: Icon(
                Icons.check_circle,
                size: 30,
                color: Colors.grey[850],
              ),
              label: Text(
                'Daily Survey',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey[850],
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue[400],
                  onSurface: Colors.pink,
                  minimumSize: Size(250, 50)),
            ),
          ],
        ),
      ),
    );
  }

  // void _showCupertinoDatePicker() {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               TextButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: Text(
  //                     'Cancel',
  //                     style: TextStyle(fontSize: 13),
  //                   )),
  //               TextButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                     Future.delayed(Duration(milliseconds: 200), () {
  //                       _showInput();
  //                     });
  //                   },
  //                   child: Text(
  //                     'Confirm',
  //                     style: TextStyle(fontSize: 13),
  //                   )),
  //             ],
  //           ),
  //           Container(
  //             height: MediaQuery.of(context).copyWith().size.height / 3,
  //             child: CupertinoDatePicker(
  //                 mode: CupertinoDatePickerMode.date,
  //                 maximumYear: DateTime.now().year + 60,
  //                 minimumYear: DateTime.now().year - 60,
  //                 onDateTimeChanged: (dateTime) {
  //                   print("${dateTime.year}-${dateTime.month}-${dateTime.day}");
  //                   addDateTime = dateTime;
  //                 }),
  //           ),
  //         ]);
  //       });
  // }
  //
  // void _showInput() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text("Add Event"),
  //       content: TextFormField(
  //         controller: editingController,
  //       ),
  //       actions: [
  //         TextButton(
  //           child: Text("Cancel"),
  //           onPressed: () => Navigator.pop(context),
  //         ),
  //         TextButton(
  //           child: Text("Ok"),
  //           onPressed: () {
  //             DateHistoryStorage.putHistoryListItem(
  //                 editingController.text, addDateTime);
  //
  //             Navigator.pop(context);
  //             editingController.clear();
  //             setState(() {});
  //             return;
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
