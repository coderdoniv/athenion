import 'package:athenion/src/components/date_picker.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  MyWidget({super.key});
  final TextEditingController dateEditController = TextEditingController();
  final TextEditingController monthEditController = TextEditingController();
  final TextEditingController yeaEditController = TextEditingController();
  final TextEditingController dummy1Controller = TextEditingController();
  final TextEditingController dummy2Controller = TextEditingController();

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: widget.dummy1Controller,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: widget.dummy2Controller,
            ),
            const SizedBox(
              height: 20,
            ),
            DatePicker(
                dateController: widget.dateEditController,
                monthController: widget.monthEditController,
                yearController: widget.yeaEditController)
          ],
        ),
      ),
    ));
  }
}
