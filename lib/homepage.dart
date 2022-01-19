import 'package:flutter/material.dart';

class Relogio1 extends StatefulWidget {
  const Relogio1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Relogio1State();
  }
}

class Relogio1State extends State<Relogio1>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;

//  Relogio1State();

  _currentTime() {
    return "${DateTime.now().hour} : ${DateTime.now().minute}";
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animationController.addListener(() {
      if (animationController.isCompleted) {
        animationController.reverse();
      } else if (animationController.isDismissed) {
        animationController.forward();
      }
      setState(() {});
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    animation =
        Tween<double>(begin: -0.5, end: 0.5).animate(animationController)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              animationController.forward();
            }
          });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.deepOrange,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Relógiummm...',
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Material(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                elevation: 10.0,
                color: Colors.brown.shade900,
                child: SizedBox(
                  width: 230,
                  height: 220,
                  child: Center(
                    child: Text(
                      _currentTime(),
                      style: const TextStyle(
                          fontSize: 60.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Transform(
                alignment: const FractionalOffset(0.5, 0.1),
                transform: Matrix4.rotationZ(animation.value),
                child: Image.asset(
                  'assets/imagens/pendulo1.png',
                  width: 100,
                  height: 250,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
