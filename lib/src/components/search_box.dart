import 'package:athenion/src/components/text_input_field.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required TextEditingController taskSearchController,
  }) : _taskSearchController = taskSearchController;

  final TextEditingController _taskSearchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextInputField(
        controller: _taskSearchController,
        hintText: 'Enter your search text here',
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}
