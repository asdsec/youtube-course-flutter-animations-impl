import 'package:flutter/material.dart';

void main() {
  const title = 'Flutter App';

  runApp(
    MaterialApp(
      title: title,
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    ),
  );
}

const imagePath = 'assets/image/image.jpg';
const defaultWith = 100.0;
const duration = Duration(milliseconds: 370);

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _isZoomedIn = false;
  var _buttonTitle = 'Zoom In';
  var _width = defaultWith;
  var _curve = Curves.bounceOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedContainer(
              curve: _curve,
              duration: duration,
              width: _width,
              child: Image.asset(imagePath),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _isZoomedIn = !_isZoomedIn;
                _width = _isZoomedIn
                    ? MediaQuery.of(context).size.width
                    : defaultWith;
                _buttonTitle = _isZoomedIn ? 'Zoom Out' : 'Zoom In';
                _curve = _isZoomedIn ? Curves.bounceInOut : Curves.bounceOut;
              });
            },
            child: Text(_buttonTitle),
          ),
        ],
      ),
    );
  }
}
