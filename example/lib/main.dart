import 'package:flutter/material.dart';
import 'package:quick_toast/quick_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'QuickToast Demo Home Page'),
      builder: QuickToast.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            ElevatedButton(
              onPressed: () => QuickToast.showToast("Hello, world!"),
              child: const Text("showToast"),
            ),

            ElevatedButton(
              onPressed: () => QuickToast.showError("Hello, world!"),
              child: const Text("showError"),
            ),

            ElevatedButton(
              onPressed: () => QuickToast.showSuccess("Hello, world!"),
              child: const Text("showSuccess"),
            ),

            ElevatedButton(
              onPressed: () {
                QuickToast.showLoading(status: "Loading...");
                Future.delayed(const Duration(seconds: 2)).then((value) {
                  QuickToast.dismiss();
                });
              },
              child: const Text("showLoading"),
            ),

            ElevatedButton(
              onPressed: () async {
                  const durations = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95];
                  QuickToast.showProgress(durations.first, status: "Uploading...");

                  for (int i = 1; i < durations.length; i++) {
                      await Future.delayed(const Duration(milliseconds: 500));
                      QuickToast.showProgress(durations[i], status: "Uploading...");
                  }

                  await Future.delayed(const Duration(milliseconds: 800));
                  QuickToast.dismiss();
              },
              child: const Text("showProgress"),
            ),


            ElevatedButton(
              onPressed: () => QuickToast.showInfo("Hello, world!"),
              child: const Text("showInfo"),
            ),

            ElevatedButton(
              onPressed: () => QuickToast.show(status: "Danger!!!!", widget: const Icon(Icons.report_problem, color: Colors.amber, size: 40,)),
              child: const Text("show widget"),
            ),
    
            ElevatedButton(
              onPressed: () => QuickToast.showWidget(
                  widget: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        color: Colors.red,
                      )
                    ],
                  )
                ),
              child: const Text("show widget"),
            ),

            ElevatedButton(
              onPressed: () => QuickToast.dismiss(),
              child: const Text("dismiss"),
            ),

          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
