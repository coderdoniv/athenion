import 'package:athenion/src/components/text_input_field.dart';
import 'package:athenion/src/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:athenion/src/components/date_picker.dart';

class TaskForm extends StatefulWidget {
  TaskForm({super.key, required this.refreshItems, required this.item});

  final Function refreshItems;
  final Map<String, dynamic>? item;

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final TextEditingController _taskNameController = TextEditingController();

  final TextEditingController _taskDescriptionController =
      TextEditingController();

  final TextEditingController _taskStartingOnDateController =
      TextEditingController();

  final TextEditingController _taskStartingOnMonthController =
      TextEditingController();

  final TextEditingController _taskStartingOnYearController =
      TextEditingController();

  final athenion = Hive.box('athenion');

  Future<void> createTask(Map<String, dynamic> newItem) async {
    await athenion.add(newItem);
    widget.refreshItems();
  }

  Future<void> updateTask(int itemKey, Map<String, dynamic> item) async {
    await athenion.put(itemKey, item);
    widget.refreshItems();
  }

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _taskDescriptionController.text = widget.item!['taskdescription'];
      _taskNameController.text = widget.item!['taskname'];
      _taskStartingOnDateController.text = widget.item!['taskstartingondate'];
      _taskStartingOnMonthController.text = widget.item!['taskstartingonmonth'];
      _taskStartingOnYearController.text = widget.item!['taskstartingonyear'];
    } else {
      _taskDescriptionController.text = '';
      _taskNameController.text = '';
      _taskStartingOnDateController.text = '';
      _taskStartingOnMonthController.text = '';
      _taskStartingOnYearController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    bool? isImmediate = false;
    return Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 15,
          left: 15,
          right: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(children: [
            SvgPicture.asset(
              imgTask,
              height: 32,
            ),
            const SizedBox(
              width: 20,
            ),
            (widget.item == null)
                ? Text(
                    'Create your new task here',
                    style: GoogleFonts.montserrat(fontSize: 16),
                  )
                : Text(
                    'Update this task',
                    style: GoogleFonts.montserrat(fontSize: 16),
                  ),
          ]),
          const SizedBox(
            height: 20,
          ),
          TextInputField(
            controller: _taskNameController,
            hintText: 'Task Name',
          ),
          const SizedBox(
            height: 10,
          ),
          TextInputField(
            controller: _taskDescriptionController,
            hintText: 'Description',
            keyboardType: TextInputType.multiline,
            minLines: 2,
            maxLines: 5,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                'Starts',
                style: GoogleFonts.montserrat(fontSize: 16),
              ),
              StatefulBuilder(builder: (ctx, setState) {
                return Checkbox(
                  checkColor: const Color(0xff6750A4),
                  fillColor:
                      MaterialStateProperty.all<Color>(const Color(0xffffffff)),
                  value: isImmediate,
                  onChanged: (value) {
                    setState(() {
                      isImmediate = value;
                    });
                  },
                );
              }),
              Text(
                'Immediate',
                style: GoogleFonts.montserrat(fontSize: 16),
              ),
            ],
          ),
          DatePicker(
              dateController: _taskStartingOnDateController,
              monthController: _taskStartingOnMonthController,
              yearController: _taskStartingOnYearController),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xff6750A4)),
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(200, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(50))))),
              onPressed: () {
                if (widget.item == null) {
                  createTask({
                    "taskname": _taskNameController.text,
                    "taskdescription": _taskDescriptionController.text,
                    "taskstartingondate": _taskStartingOnDateController.text,
                    "taskstartingonmonth": _taskStartingOnMonthController.text,
                    "taskstartingonyear": _taskStartingOnYearController.text
                  });
                } else {
                  updateTask(widget.item!['key'], {
                    "taskname": _taskNameController.text,
                    "taskdescription": _taskDescriptionController.text,
                    "taskstartingondate": _taskStartingOnDateController.text,
                    "taskstartingonmonth": _taskStartingOnMonthController.text,
                    "taskstartingonyear": _taskStartingOnYearController.text
                  });
                }
                _taskNameController.text = '';
                _taskDescriptionController.text = '';
                _taskStartingOnDateController.text = '';
                _taskStartingOnMonthController.text = '';
                _taskStartingOnYearController.text = '';
                Navigator.of(context).pop();
              },
              child: (widget.item == null)
                  ? Text(
                      'Start Tracking',
                      style: GoogleFonts.montserrat(
                          fontSize: 16, color: Colors.white70),
                    )
                  : Text(
                      'Update Task',
                      style: GoogleFonts.montserrat(
                          fontSize: 16, color: Colors.white70),
                    ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
