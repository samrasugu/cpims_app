import 'package:cpims_app/constants/global_constants.dart';
import 'package:cpims_app/endpoints/dashboard_endpoint.dart';
import 'package:cpims_app/screens/login_screen.dart';
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
          title: const Text(
            'CPIMS App',
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(Icons.logout_rounded),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Dashboard Data',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            responseData.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple,
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      itemCount: responseData.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        final key = responseData.keys.elementAt(index);
                        final value = responseData[key];
                        return Card(
                          margin: const EdgeInsets.all(
                            16.0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  capitalizeFirstLetter(key),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Center(
                                  child: Text(
                                    value.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ));
  }
}
