import 'package:athenion/src/components/text_input_field.dart';
import 'package:athenion/src/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DatePicker extends StatelessWidget {
  const DatePicker(
      {super.key,
      required this.dateController,
      required this.monthController,
      required this.yearController});
  final TextEditingController dateController;
  final TextEditingController monthController;
  final TextEditingController yearController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: TextInputField(
            controller: dateController,
            hintText: 'DD',
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          '/',
          style: GoogleFonts.montserrat(fontSize: 16),
        ),
        const SizedBox(
          width: 20,
        ),
        Flexible(
          flex: 2,
          child: TextInputField(
            controller: monthController,
            hintText: 'MM',
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          '/',
          style: GoogleFonts.montserrat(fontSize: 16),
        ),
        const SizedBox(
          width: 20,
        ),
        Flexible(
          flex: 3,
          child: TextInputField(
            controller: yearController,
            hintText: 'YYYY',
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        InkWell(
            child: SvgPicture.asset(
              imgCalendar,
              height: 32,
            ),
            onTap: () async {
              DateTime? startedOn = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2030));
              if (startedOn != null) {
                dateController.text = startedOn.day.toString();
                monthController.text = startedOn.month.toString();
                yearController.text = startedOn.year.toString();
              }
            }),
      ],
    );
  }
}
