import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Function to fetch data from the API
Future<String> fetchData() async {
  final response = await http.get(Uri.parse('https://itpart.net/mobile/api/product0.php'));

  if (response.statusCode == 200) {
    final jsonBody = json.decode(response.body); // Assuming you're going to use the decoded response later
    String strBody = response.body.toString();  // Convert the response body to string
    debugPrint(strBody);  // For debugging purposes
    return strBody;  // Returning the string response
  } else {
    throw Exception('Problem fetching data...');
  }
}

class HttpBasic extends StatefulWidget {
  const HttpBasic({super.key});

  @override
  State<HttpBasic> createState() => _HttpBasicState();
}

class _HttpBasicState extends State<HttpBasic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP Request Example'),
      ),
      body: FutureBuilder<String>(
        future: fetchData(), // Call the fetchData function
        builder: (context, snapshot) {
          // Handle different states of the future
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Show error if there's an issue
          } else if (snapshot.hasData) {
            return Center(child: Text('Data: ${snapshot.data}')); // Show the data if successful
          } else {
            return const Center(child: Text('No data found')); // Handle empty data
          }
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HttpBasic(),
  ));
}
