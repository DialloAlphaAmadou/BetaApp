import 'package:flutter/material.dart';

class ServicePage extends StatefulWidget{
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage>{

  @override
  Widget build(BuildContext context){
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Page Service',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.green),
        ),
        const SizedBox(height: 16),
        const Text(
          'Important',
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