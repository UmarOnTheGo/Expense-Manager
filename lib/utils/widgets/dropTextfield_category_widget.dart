import 'package:expense_manager/model/tag_model.dart';
import 'package:flutter/material.dart';

class DropTagWidget extends StatefulWidget {
  final GlobalKey _fieldKey = GlobalKey();
  final List<Tag> options;
  final TextEditingController controller;
  final String text;

  DropTagWidget({
    super.key,
    required this.options,
    required this.controller,
    required this.text,
  });

  @override
  State<DropTagWidget> createState() => _DropTagWidgetState();
}

class _DropTagWidgetState extends State<DropTagWidget> {
  void _showDropdownMenu() async {
    final RenderBox renderBox =
        widget._fieldKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;
    if (widget.options.isEmpty) {
      showMenu(
        position: RelativeRect.fromLTRB(
          offset.dx,
          offset.dy + size.height, // Show below the field
          offset.dx + size.width,
          offset.dy,
        ),
        context: context,
        items: [
          PopupMenuItem(
            child: Container(
              padding: EdgeInsets.only(left: 40, right: 40),
              width: double.infinity,
              child: Text('No Category set yet'),
            ),
          ),
        ],
      );
      return;
    }
    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height, // Show below the field
        offset.dx + size.width,
        offset.dy,
      ), // Adjust as needed
      items: widget.options
          .map(
            (option) => PopupMenuItem<String>(
              value: option.tagName,
              child: Center(child: Text(option.tagName)),
            ),
          )
          .toList(),
    );
    if (selected != null) {
      widget.controller.text = selected;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: widget._fieldKey,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: 'Choose or type ${widget.text}',
        suffixIcon: IconButton(
          icon: const Icon(Icons.arrow_drop_down),
          onPressed: _showDropdownMenu,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
