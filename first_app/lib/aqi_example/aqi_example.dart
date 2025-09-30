import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


const String token = '035e6c402ac5ccf6d6e549b3914b8a64c0690c6e';

const String defaultCity = 'bangkok';

class ApiExample extends StatefulWidget {
  const ApiExample({super.key});

  @override
  State<ApiExample> createState() => _ApiExampleState();
}

class _ApiExampleState extends State<ApiExample> {
  bool loading = true;
  String cityName = '';
  int aqi = 0;
  double tempC = 0;

  double? humidity;
  double? wind;
  double? pressure;
  double? pm25;
  double? pm10;
  String? updateText;

  String? error; 

  @override
  void initState() {
    super.initState();
    fetchData(); 
  }

  Future<void> fetchData() async {
    setState(() {
      loading = true;
      error = null;
    });

    final url = 'https://api.waqi.info/feed/$defaultCity/?token=$token';

    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode != 200) {
        throw Exception('HTTP ${res.statusCode}');
      }

      final body = json.decode(res.body);
      if (body['status'] != 'ok') {
        throw Exception('API status: ${body['status']}');
      }

      final data = body['data'];
      setState(() {
        aqi = data['aqi'] ?? 0;
        cityName = data['city']?['name'] ?? defaultCity;
        tempC = (data['iaqi']?['t']?['v'] ?? 0).toDouble();

 
        humidity = (data['iaqi']?['h']?['v'] as num?)?.toDouble();
        wind = (data['iaqi']?['w']?['v'] as num?)?.toDouble();
        pressure = (data['iaqi']?['p']?['v'] as num?)?.toDouble();
        pm25 = (data['iaqi']?['pm25']?['v'] as num?)?.toDouble();
        pm10 = (data['iaqi']?['pm10']?['v'] as num?)?.toDouble();

        final ts = data['time']?['s'] as String?;
        if (ts != null) {
          updateText = prettyTime(ts);
        }

        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }


  String prettyTime(String s) {
    final parts = s.split(' ');
    final datePart = parts[0];
    final timePart = parts[1].substring(0, 5);

    final date = DateTime.parse("$datePart $timePart:00");
    const weekdays = [
      'วันจันทร์','วันอังคาร','วันพุธ',
      'วันพฤหัสบดี','วันศุกร์','วันเสาร์','วันอาทิตย์'
    ];
    final weekday = weekdays[date.weekday - 1];
    return 'อัปเดตล่าสุด: $weekday เวลา $timePart';
  }


  Map<String, dynamic> aqiStyle(int aqi) {
    if (aqi <= 50) {
      return {"color": const Color.fromARGB(255, 19, 20, 19), "label": "Good"};
    } else if (aqi <= 100) {
      return {"color": const Color.fromARGB(255, 9, 9, 9), "label": "Moderate"};
    } else if (aqi <= 150) {
      return {"color": const Color.fromARGB(255, 33, 33, 32), "label": "Unhealthy SG"};
    } else if (aqi <= 200) {
      return {"color": const Color.fromARGB(255, 23, 22, 22), "label": "Unhealthy"};
    } else if (aqi <= 300) {
      return {"color": const Color.fromARGB(255, 21, 21, 21), "label": "Very Unhealthy"};
    } else {
      return {"color": const Color.fromARGB(255, 28, 27, 27), "label": "Hazardous"};
    }
  }


  Widget header({required Widget child}) {
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(236, 108, 215, 37), 
          Color.fromARGB(255, 160, 244, 135), 
        ],
      ),
    ),
    padding: EdgeInsets.all(16),
    child: child,
  );
}


Widget aqiBigBlock() {
  final style = aqiStyle(aqi);
  String emoji = "🙂";

  if (aqi <= 50) emoji = "😃";          
  else if (aqi <= 100) emoji = "😊";    
  else if (aqi <= 150) emoji = "😷";    
  else if (aqi <= 200) emoji = "🤒";    
  else if (aqi <= 300) emoji = "🤢";    
  else emoji = "☠️";                   

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center, // ให้อยู่กลาง
    children: [
      Text(
        "$aqi $emoji",   // ตัวเลข + อิโมจิ
        style: TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.bold,
          color: style["color"],
        ),
      ),
      SizedBox(height: 8),
      Text("Air Quality Index", style: TextStyle(fontSize: 16)),
      Text(style["label"], style: TextStyle(fontWeight: FontWeight.bold)),
    ],
  );
}


 Widget observationCard() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Current Observation",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2, 
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(), 
            childAspectRatio: 3, 
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: [
              miniTile(Icons.thermostat, "Temp", "${tempC.toStringAsFixed(1)} °C"),
              miniTile(Icons.water_drop, "Humidity", humidity == null ? "-" : "${humidity!.toStringAsFixed(1)}%"),
              miniTile(Icons.air, "Wind", wind == null ? "-" : "${wind!.toStringAsFixed(1)} m/s"),
              miniTile(Icons.compress, "Pressure", pressure == null ? "-" : "${pressure!.toStringAsFixed(1)} hPa"),
              miniTile(Icons.cloud, "PM2.5", pm25 == null ? "-" : "${pm25!.toStringAsFixed(1)} µg/m³"),
              miniTile(Icons.cloud_queue, "PM10", pm10 == null ? "-" : "${pm10!.toStringAsFixed(1)} µg/m³"),
            ],
          )
        ],
      ),
    ),
  );
}

  Widget miniTile(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 140, 240, 120), 
    appBar: AppBar(
      title: Text("Air Quality Index (AQI)"),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 175, 243, 132), 
    ),
    body: loading
        ? Center(child: CircularProgressIndicator())
        : error != null
            ? Center(
                child: Text(
                  "Error: $error",
                  style: TextStyle(color: Colors.white), 
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    header(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Icon(Icons.place, color: Colors.white), 
                            SizedBox(width: 5),
                            Text(cityName,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          ]),
                          if (updateText != null)
                            Text(updateText!,
                                style: TextStyle(color: Colors.white70)),
                          const SizedBox(height: 12),
                          aqiBigBlock(),
                        ],
                      ),
                    ),
                    observationCard(),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: fetchData,
                      icon: Icon(Icons.refresh),
                      label: Text("Refresh"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 40, 38, 41), 
                        foregroundColor: const Color.fromARGB(255, 230, 221, 221),
                      ),
                    )
                  ],
                ),
              ),
  );
}
}


