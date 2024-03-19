import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login_signup/components/Screens/delivery_stops%20.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  bool isClockIn = false;
  late Timer _timer;
  int _start = 0;

  String formatTimer(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds ~/ 60) % 60;
    int secs = seconds % 60;
    return '$hours:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          _start++;
        },
      ),
    );
  }

  void stopTimer() {
    _timer.cancel();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Timer: ${formatTimer(_start)}',
              style: TextStyle(fontSize: 20, ),
            ),
            IconButton(
              onPressed: () {
                if (isClockIn) {
                  stopTimer();
                } else {
                  startTimer();
                }
                setState(() {
                  isClockIn = !isClockIn;
                });
              },
              icon: Icon(
                isClockIn ? Icons.timer_off : Icons.timer,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedLogo(),
                SizedBox(height: 4),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapSample()),
                    );
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.transparent;
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return Colors.transparent;
                        return null;
                      },
                    ),
                  ),
                  child: Text(
                    'Tap to Add Stops',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NotoSerif',
                      color: const Color(0xffae2012),
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isClockIn) {
            stopTimer();
          } else {
            startTimer();
          }
          setState(() {
            isClockIn = !isClockIn;
          });
        },
        child: Icon(
          isClockIn ? Icons.timer_off : Icons.timer,
          color: Colors.white,
        ),
        backgroundColor: Color(0xffae2012),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class AnimatedLogo extends StatefulWidget {
  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: Image.asset(
        'assets/images/stopicon.png',
        height: 249,
        width: 200,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
