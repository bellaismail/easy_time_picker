import 'package:easy_time_picker/easy_time_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter easy time picker example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter show easy time picker page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('show time picker..')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            ElevatedButton(
              onPressed: () async => await context.showEasyTimePicker(
                selectedTime: _selectedTime,
                confirmationWidget: Text('bilal'),
                onSelect: (time) => setState(() {
                  _selectedTime = time;
                }),
              ),
              child: Text('show time'),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: _selectedTime != null
                  ? Text('hours: ${_selectedTime?.hour}, minutes: ${_selectedTime?.minute}')
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
