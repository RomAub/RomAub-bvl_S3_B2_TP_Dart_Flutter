import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Dark Mode',
        theme: theme,
        darkTheme: darkTheme,
        home: MyHomePage(title: 'Flutter Dark Mode'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool darkmode = false;
  dynamic savedThemeMode;
  String? iconAdress;

  void initState() {
    super.initState();
    getCurrentTheme();
  }

  Future getCurrentTheme() async {
    savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode.toString() == 'AdaptiveThemeMode.dark') {
      print('thème sombre');
      setState(() {
        darkmode = true;
        iconAdress = 'assets/icon/dark-icon.png';
      });
    } else {
      print('thème clair');
      setState(() {
        darkmode = false;
        iconAdress = 'assets/icon/light-icon.png';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              child: iconAdress != null
                  ? Image.asset(iconAdress!)
                  : Container(),
            ),
            SizedBox(height: 70),
            Text(
              'Changez de thème',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              width: 250,
              child: Text(
                "Vous pouvez changer le thème de l'interface de votre application.",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text('Mode sombre'),
              activeColor: Colors.orange,
              secondary: const Icon(Icons.nightlight_round),
              value: darkmode,
              onChanged: (bool value) {
                print(value);
                if (value == true) {
                  AdaptiveTheme.of(context).setDark();
                  iconAdress = 'icon/dark-icon.png';
                } else {
                  AdaptiveTheme.of(context).setLight();
                  iconAdress = 'icon/light-icon.png';
                }
                setState(() {
                  darkmode = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
