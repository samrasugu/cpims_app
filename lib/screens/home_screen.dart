import 'package:cpims_app/endpoints/dashboard_endpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.accessToken,
  });
  final String accessToken;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> responseData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      Map<String, dynamic> data = await fetchDashboardData(
          context: context, accessToken: widget.accessToken);
      setState(() {
        responseData = data;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CPIMS App'),
      ),
      body: ListView.builder(
        itemCount: responseData.length,
        itemBuilder: (context, index) {
          final key = responseData.keys.elementAt(index);
          final value = responseData[key];
          return Card(
            margin: const EdgeInsets.all(
              16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  key,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  value.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
