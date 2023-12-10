import 'package:athenion/src/components/search_box.dart';
import 'package:athenion/src/constants/image_constants.dart';
import 'package:athenion/src/features/tasks/views/taskcard.dart';
import 'package:athenion/src/features/tasks/views/taskform.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TextEditingController _taskNotesController = TextEditingController();
  final TextEditingController _taskSearchController = TextEditingController();

  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    refreshItems();
  }

  final athenion = Hive.box('athenion');

  void refreshItems() {
    final data = athenion.keys.map((key) {
      final item = athenion.get(key);
      return {
        "key": key,
        "taskname": item["taskname"],
        "taskdescription": item["taskdescription"],
        "taskstartingondate": item["taskstartingondate"],
        "taskstartingonmonth": item["taskstartingonmonth"],
        "taskstartingonyear": item["taskstartingonyear"]
      };
    }).toList();
    setState(() {
      items = data.reversed.toList();
    });
  }

  void _showForm(BuildContext ctx, int? itemKey) async {
    Map<String, dynamic>? item;
    if (itemKey != null) {
      item = items.firstWhere((element) => element['key'] == itemKey);
    } else {
      item = null;
    }

    showModalBottomSheet(
      context: ctx,
      elevation: 5,
      isScrollControlled: true,
      showDragHandle: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      // backgroundColor: Colors.lightBlue,
      builder: (_) => TaskForm(
        refreshItems: refreshItems,
        item: item,
      ),
    );
  }

  Future<void> deleteTask(int itemKey) async {
    await athenion.delete(itemKey);
    refreshItems();
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: const Color(0xff6750A4),
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xff6750A4),
          onPressed: () => _showForm(context, null),
          child: const Icon(Icons.add),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 80),
          child: Column(
            children: [
              Text(Moment.now().format('Do MMMM YYYY'),
                  style: GoogleFonts.montserrat(
                      fontSize: 24, color: Colors.white)),
              const SizedBox(
                height: 10,
              ),
              SearchBox(taskSearchController: _taskSearchController),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: items.isNotEmpty
                    ? ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (_, index) {
                          final currentItem = items[index];
                          return TaskCard(
                              key: UniqueKey(),
                              currentItem: currentItem,
                              deleteProc: deleteTask,
                              notesController: _taskNotesController,
                              showForm: _showForm);
                        },
                      )
                    : Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              imgTask,
                              height: 100,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text('There are no tasks for today!',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 20,
                                )),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
