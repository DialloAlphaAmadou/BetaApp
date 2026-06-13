import 'package:flutter/material.dart';

class Pages extends StatefulWidget{
  const Pages({super.key});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages>{

  @override
  Widget build(BuildContext context){
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Page ',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.green),
        ),
        const SizedBox(height: 16),
        const Text(
          'Important Page',
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}