import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String? hintText;
  final List<String> items;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;
  final Color? borderColor;
  final String? value; // Add this line

  const CustomDropdownFormField({
    super.key,
    this.hintText,
    required this.items,
    this.onChanged,
    this.onSaved,
    this.borderColor,
    this.value, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    final defaultBorderColor =
        Theme.of(context).colorScheme.onSurface.withOpacity(0.38);
    final finalBorderColor = borderColor ?? defaultBorderColor;

    return DropdownButtonFormField<String>(
      value: value, // Add this line
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: finalBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: finalBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: finalBorderColor),
        ),
        hintText: hintText,
      ),
      hint: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          hintText ?? 'Select',
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Color(0xffD8D8D8),
          ),
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select an item.';
        }
        return null;
      },
      onChanged: onChanged,
      onSaved: onSaved,
    );
  }
}
