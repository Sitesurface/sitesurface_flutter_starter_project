import 'package:flutter/material.dart';

import '../../util/styles/colors/pallet.dart';

class DropdownTextField extends StatefulWidget {
  final void Function(String?) onChanged;
  final String label;
  final List<String> list;
  final String heading;
  final String? Function(String?)? validator;
  final int? maxLines;
  final String? initialText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  const DropdownTextField({
    Key? key,
    required this.onChanged,
    required this.label,
    this.validator,
    required this.heading,
    this.maxLines,
    this.initialText,
    this.keyboardType,
    this.maxLength,
    this.textCapitalization,
    required this.list,
  }) : super(key: key);

  @override
  State<DropdownTextField> createState() => _DropdownTextFieldState();
}

class _DropdownTextFieldState extends State<DropdownTextField> {
  final List<String> _selectedList = [];
  final _textController = TextEditingController();

  @override
  void initState() {
    _textController.text = widget.initialText ?? "";
    var tempArray = widget.initialText?.split(',') ?? [];
    var array = <String>[];
    for (var element in tempArray) {
      if (element.isNotEmpty) {
        array.add(element.trim());
      }
    }
    if (array.isNotEmpty) {
      _selectedList.addAll(array);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.heading,
        ),
        const SizedBox(
          height: 5,
        ),
        InkWell(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) =>
                  StatefulBuilder(builder: (context, innerSetState) {
                return AlertDialog(
                  title: Text(widget.heading),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: List.generate(widget.list.length, (index) {
                        return CheckboxListTile(
                            title: Text(
                              widget.list[index],
                            ),
                            value: _selectedList.contains(widget.list[index]),
                            onChanged: (value) {
                              if (_selectedList.contains(widget.list[index])) {
                                _selectedList.remove(widget.list[index]);
                              } else {
                                _selectedList.add(widget.list[index]);
                              }
                              innerSetState(() {});
                            });
                      }),
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            widget.onChanged(_selectedList.join(','));
                            _textController.text = _selectedList.join(',');
                          });
                          Navigator.pop(context);
                        },
                        child: const Text("Ok")),
                  ],
                );
              }),
            );
          },
          child: AbsorbPointer(
            absorbing: true,
            child: TextFormField(
              controller: _textController,
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.none,
              validator: widget.validator,
              onChanged: widget.onChanged,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              keyboardType: widget.keyboardType,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                helperText: ' ',
                counterText: '',
                filled: true,
                fillColor: Theme.of(context).colorScheme.background,
                focusColor: Theme.of(context).colorScheme.primary,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 14.5, horizontal: 12),
                labelText: widget.label,
                labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).colorScheme.grey),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
