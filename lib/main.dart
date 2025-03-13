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
      title: 'TNK Flutter Sample',
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

/**
 * PlacementView Type 정의
 */
const DEFAULT_VIEW = 1; // default view
const CPS_VIEW = 2; // cps view

class _MyHomePageState extends State<MyHomePage> {

  int _selectedType = DEFAULT_VIEW; // 선택된 PlacementView Type

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedType = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tnk Flutter Sample')),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("placementView",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                // Margin
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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

                VerticalDivider(),

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
                  style: ElevatedButton.styleFrom(
                  ),
                  child: Text(
                    'Show',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],


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
