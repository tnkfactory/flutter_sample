import 'package:flutter/material.dart';
import 'offerwall.dart';
import 'placement_view.dart';

import 'package:tnk_flutter_rwd/tnk_flutter_rwd.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tnk flutter rwd',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const DEFAULT_VIEW = 1;
const CPS_VIEW = 2;

class _MyHomePageState extends State<MyHomePage> {
  int _selectedType = DEFAULT_VIEW;

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedType = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tnk flutter rwd')),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<int>(
                  value: DEFAULT_VIEW,
                  groupValue: _selectedType,
                  onChanged: _handleRadioValueChange,
                ),
                Text('Default'),

                Radio<int>(
                  value: CPS_VIEW,
                  groupValue: _selectedType,
                  onChanged: _handleRadioValueChange,
                ),
                Text('Cps'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => PlacementViewItem(type: _selectedType),
                  ),
                );
              },
              child: Text(
                'Simple PlacementView',
                style: TextStyle(fontSize: 14),
              ),
            ),

            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => OfferwallItem(),
                      ),
                    );
                  },
                  child: Text(
                    'Offerwall',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
