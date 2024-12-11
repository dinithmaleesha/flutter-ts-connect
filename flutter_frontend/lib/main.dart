import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> main() async {
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Error loading .env file: $e");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String message = 'Loading...';
  final String baseUrl = dotenv.env['BASE_URL']!;

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchMessage() async {
    final response = await http.get(Uri.parse('$baseUrl/api/data'));
    if (response.statusCode == 200) {
      setState(() {
        message = json.decode(response.body)['message'];
      });
    } else {
      setState(() {
        message = 'Failed to load message';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter + TypeScript')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                fetchMessage();
              },
              child: Text('Fetch Message'),
            ),
          ],
        ),
      ),
    );
  }
}
