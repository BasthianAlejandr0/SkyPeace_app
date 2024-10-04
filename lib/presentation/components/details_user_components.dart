import 'package:flutter/material.dart';

class DetailsUsers extends StatelessWidget {
  final String text;
  final String sectionName;
  const DetailsUsers({
    super.key, 
    required this.text,
    required this.sectionName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
        ),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      
                    }, 
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.blue,
                      size: 20,
                    ),
                  ),
                ],
              ),
              Text(
                text,
                style: const TextStyle(
                fontSize: 15
            ),
          ),
        ],
      ),
    );
  }
}