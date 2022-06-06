import 'package:medicine/calendar/event.dart';
import 'package:medicine/calendar/todo_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

import 'action_button.dart';
import 'expandable_fab.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  //recordList: All todolist events
  List<Map<String, dynamic>> recordList = List.empty(growable: true);

  //showList: 今天或给定一个日期的事件
  List<Map<String, dynamic>> showList = List.empty(growable: true);

  TextEditingController editingController = TextEditingController();
  TextEditingController editingController_2 = TextEditingController()
    ..text = '14';

  @override
  void initState() {
    recordList = DateHistoryStorage.getHistoryList();
    setState(() {
      showList = _getListForDay(selectedDay);
    });
    super.initState();
  }

  List<Map<String, dynamic>> _getListForDay(DateTime date) {
    List<Map<String, dynamic>> events = List.empty(growable: true);
    recordList.forEach((e) {
      final record = DateTime.parse(e['date']);
      if (record.month == date.month &&
          record.year == date.year &&
          record.day == date.day) {
        events.add(e);
      }
    });
    return events;
  }

  @override
  void dispose() {
    // _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar for medicine"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TableCalendar(
            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
                showList = _getListForDay(selectedDay);
              });
              print(focusedDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder:
                  (BuildContext context, DateTime day, DateTime focusedDay) {
                final result = recordList.any((element) {
                  final record = DateTime.parse(element['date']);
                  final recordTitle = element['name'];
                  if (record.month == day.month &&
                      record.year == day.year &&
                      record.day == day.day &&
                      !recordTitle.contains('隔离')) {
                    return true;
                  }
                  return false;
                });
                return Center(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Text(
                        '${DateFormat('d').format(day)}',
                      ),
                      Positioned(
                        bottom: -10,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                            color: result ? Colors.green : Colors.transparent,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              // rangeHighlightBuilder:
              //     (BuildContext context, DateTime day, bool isWithinRange) {
              //   if (day.day == 25) {
              //     isWithinRange = true;
              //   }
              //   return null;
              // },
              rangeEndBuilder: (context, day, focusedDay) {
                selectedDay = day;
                return Text('${day.day}');
              },
              markerBuilder:
                  (BuildContext context, DateTime day, List<Event> events) {
                final result = recordList.any((element) {
                  final record = DateTime.parse(element['date']);
                  final recordTitle = element['name'];
                  if (record.month == day.month &&
                      record.year == day.year &&
                      record.day == day.day &&
                      recordTitle.contains('隔离')) {
                    return true;
                  }
                  return false;
                });

                Text tt;
                if (result) {
                  // cc = Colors.red as Colors?;
                  tt = Text('隔离',
                      style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.red,
                          fontWeight: FontWeight.w400));
                  // decoration = const BoxDecoration(
                  //     shape: BoxShape.circle, color: Colors.red);
                } else {
                  tt = Text('');
                  // decoration = const BoxDecoration(
                  //     shape: BoxShape.circle, color: Colors.transparent);
                }
                return Container(
                  width: 20.0,
                  height: 12.0,
                  child: tt,
                  // color: Colors.yellow,
                  margin: EdgeInsets.only(bottom: 35.0, left: 26.0),
                  // decoration: decoration
                );
              },
            ),
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(19.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              markerDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.red,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Text(
            '  Remind:',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w100),
          ),
          ListView.separated(
            itemBuilder: (context, index) {
              final result = showList[index];
              print('事件：result:' + " " + result.toString());
              return Dismissible(
                key: Key('${index}'),
                child: ListTile(
                  leading: Text(DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(result['date']))),
                  trailing: Text(result['name']),
                ),
                onDismissed: (direction) async {
                  await DateHistoryStorage.removeHistoryListItem(
                      result['name'], result['date']);
                  //刷新数据
                  recordList = DateHistoryStorage.getHistoryList();
                  showList = _getListForDay(selectedDay);
                },
              );
            },
            itemCount: showList.length,
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        ],
      ),
      floatingActionButton: ExpandableFab(
        distance: 112.0,
        children: [
          ActionButton(
            onPressed: () => _addEvent("quarantine"),
            icon: const Icon(
              Icons.description,
              color: Colors.white,
            ),
          ),
          ActionButton(
            onPressed: () => _showAddEventDialog(),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _addEvent(String value) {
    print('addEvent_qq');
    _showQuarantineDatePicker();
  }

  DateTime addQDateTime = DateTime.now();

  void _showQuarantineDatePicker() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(fontSize: 13),
                    )),
                Text('选择隔离开始日期'),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Future.delayed(Duration(milliseconds: 200), () {
                        _showTimeInput();
                      });
                    },
                    child: Text(
                      'Confirm',
                      style: TextStyle(fontSize: 13),
                    )),
              ],
            ),
            Container(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  maximumYear: DateTime.now().year + 1,
                  minimumYear: DateTime.now().year - 1,
                  onDateTimeChanged: (dateTime) {
                    print("${dateTime.year}-${dateTime.month}-${dateTime.day}");
                    addQDateTime = dateTime;
                  }),
            ),
          ]);
        });
  }

  void _showTimeInput() {
    // editingController.value = '14';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Quarantine Time(确认隔离总天数)"),
        content: TextFormField(
          controller: editingController_2,
          // keyboardType: TextInputType.datetime,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')) //设置只允许输入数字
          ],
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("OK"),
            onPressed: () {
              // DateHistoryStorage.putHistoryListItem(
              //     editingController.text, addQDateTime);
              print('隔离开始日期 & 隔离总天数');
              print(addQDateTime);
              print(editingController_2.text);

              _processQEvent(addQDateTime, int.parse(editingController_2.text));

              Navigator.pop(context);
              // editingController.clear();
              setState(() {});
              return;
            },
          ),
        ],
      ),
    );
  }

  void _processQEvent(DateTime startDate, int totalDays) {
    //处理隔离时间的数据
    // 1.将数据加入事件list中，并将其添加时间标题
    DateTime eventDate = startDate;
    for (var i = 1; i <= totalDays; i++) {
      String eventName = '隔离第' + i.toString() + '天';
      // 将事件加入数据库中
      DateHistoryStorage.putHistoryListItem(eventName, eventDate);
      print('事件：' + eventName + " " + eventDate.toString());
      eventDate = eventDate.add(new Duration(days: 1));
    }
    //刷新数据
    recordList = DateHistoryStorage.getHistoryList();
    showList = _getListForDay(selectedDay);
  }

  void _processTodoEvent(DateTime eventDate, String todoEvent) {
    //处理隔离时间的数据
    // 1.将数据加入事件list中，并将其添加时间标题
    String eventName = todoEvent;
    // 将事件加入数据库中
    DateHistoryStorage.putHistoryListItem(eventName, eventDate);
    print('事件：' + eventName + " " + eventDate.toString());
    //刷新数据
    recordList = DateHistoryStorage.getHistoryList();
    showList = _getListForDay(selectedDay);
  }

  void _showAddEventDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Event"),
        content: TextFormField(
          controller: editingController,
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("Ok"),
            onPressed: () {
              if (editingController.text.isEmpty) {
              } else {
                _processTodoEvent(
                    selectedDay, editingController.text.toString());
              }
              Navigator.pop(context);
              editingController.clear();
              setState(() {});
              return;
            },
          ),
        ],
      ),
    );
  }
}
