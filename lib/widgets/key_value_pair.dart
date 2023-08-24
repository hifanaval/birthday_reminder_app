import 'package:flutter/material.dart';

class KeyValuePairWidget extends StatelessWidget {
  const KeyValuePairWidget({
    super.key,
    required this.text,
    required this.label,
  });

  final String text;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '$label : ',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
