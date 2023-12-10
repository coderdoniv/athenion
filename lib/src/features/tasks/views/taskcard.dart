import 'package:athenion/src/components/text_input_field.dart';
import 'package:athenion/src/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskCard extends StatelessWidget {
  TaskCard(
      {super.key,
      required this.currentItem,
      required this.notesController,
      required this.deleteProc,
      required this.showForm});
  final dynamic currentItem;
  final TextEditingController notesController;
  final Function(int itemKey) deleteProc;
  final Function(BuildContext ctx, int? itemKey) showForm;
  final TextEditingController _taskNotesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: ExpansionTile(
          // collapsedTextColor: const Color(0xff6750A4),
          textColor: Colors.black,
          title: Text(currentItem['taskname'],
              style: GoogleFonts.montserrat(
                  fontSize: 12, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          subtitle: Text(currentItem['taskdescription'],
              style: GoogleFonts.montserrat(fontSize: 12)),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          onExpansionChanged: (value) {
            print(value);
          },
          leading: SvgPicture.asset(
            imgTask,
            height: 32,
          ),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            const Text("05:58"),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow),
              color: const Color(0xff6750A4),
            )
          ]),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          children: [
            Column(
              children: [
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xff6750A4),
                            radius: 15,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.check_rounded),
                              iconSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xff6750A4),
                            radius: 15,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.check_rounded),
                              iconSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            backgroundColor: const Color(0xff6750A4),
                            radius: 15,
                            child: IconButton(
                              onPressed: () =>
                                  showForm(context, currentItem['key']),
                              icon: const Icon(Icons.edit),
                              iconSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            backgroundColor: const Color(0xff6750A4),
                            radius: 15,
                            child: IconButton(
                              onPressed: () => deleteProc(currentItem['key']),
                              icon: const Icon(Icons.delete),
                              iconSize: 15,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                    ]),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
