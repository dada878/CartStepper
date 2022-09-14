import 'package:flutter/material.dart';

import 'package:cart_stepper/cart_stepper.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: "Cart Stepper View",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counterInit = 0;
  int _counter = 1;
  int _counterLimit = 1;

  double _dCounter = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text('普通调用:'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CartStepperInt(
                    style: CartStepperStyle.fromTheme(
                      Theme.of(context),
                      radius: Radius.zero,
                    ),
                    elevation: 7,
                    value: _counterInit,
                    didChangeCount: (count) {
                      setState(() {
                        _counterInit = count;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CartStepperDouble(
                    value: _dCounter,
                    stepper: 0.01,
                    didChangeCount: (count) {
                      setState(() {
                        _dCounter = count;
                      });
                    },
                  ),
                ),
              ],
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text('纵向:'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CartStepperInt(
                    value: _counter,
                    axis: Axis.vertical,
                    didChangeCount: (count) {
                      setState(() {
                        _counter = count;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CartStepperDouble(
                    value: _dCounter,
                    stepper: 0.01,
                    axis: Axis.vertical,
                    didChangeCount: (count) {
                      setState(() {
                        _dCounter = count;
                      });
                    },
                  ),
                ),
              ],
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text('不同尺寸/设置颜色:'),
              ),
            ),
            Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: CartStepperInt(
                      value: _counter,
                      size: 20,
                      didChangeCount: (count) {
                        setState(() {
                          _counter = count;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: CartStepperInt(
                      value: _counter,
                      size: 30,
                      style: const CartStepperStyle(
                        deActiveForegroundColor: Colors.red,
                        activeForegroundColor: Colors.white,
                        activeBackgroundColor: Colors.pinkAccent,
                        radius: Radius.zero,
                      ),
                      didChangeCount: (count) {
                        setState(() {
                          _counter = count;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: CartStepperInt(
                      value: _counter,
                      size: 30,
                      numberSize: 6,
                      style: const CartStepperStyle(
                        deActiveForegroundColor: Colors.red,
                        activeForegroundColor: Colors.white,
                        activeBackgroundColor: Colors.pinkAccent,
                        radius: Radius.zero,
                      ),
                      didChangeCount: (count) {
                        setState(() {
                          _counter = count;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: CartStepperInt(
                      value: _counter,
                      size: 80,
                      didChangeCount: (count) {
                        setState(() {
                          _counter = count;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 25),
                child: Text('限制最小值:'),
              ),
            ),
            Center(
              child: CartStepperInt(
                value: _counterLimit,
                style: CartStepperStyle.fromTheme(
                  Theme.of(context),
                  radius: const Radius.circular(3),
                ),
                size: 30,
                didChangeCount: (count) {
                  if (count < 1) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('数量不能小于 1 哦~'),
                      backgroundColor: Colors.orangeAccent,
                    ));
                    return;
                  }
                  setState(() {
                    _counterLimit = count;
                  });
                },
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
