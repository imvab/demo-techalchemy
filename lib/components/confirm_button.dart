//@dart=2.9

import 'package:demo_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum ButtonState { idle, loading, success, error }

class RoundedLoadingButton extends StatefulWidget {
  final ConfirmButtonController controller;
  final VoidCallback onPressed;
  final Widget child;
  final Color color;

  const RoundedLoadingButton({Key key, this.controller, this.onPressed, this.child, this.color = Colors.lightBlue})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => RoundedLoadingButtonState();
}

class RoundedLoadingButtonState extends State<RoundedLoadingButton> with TickerProviderStateMixin {
  AnimationController _buttonController;
  AnimationController _borderController;
  AnimationController _checkButtonControler;

  Animation _squeezeAnimation;
  Animation _bounceAnimation;
  Animation _borderAnimation;

  final _state = BehaviorSubject<ButtonState>.seeded(ButtonState.idle);

  @override
  Widget build(BuildContext context) {
    var _check = Container(
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.all(Radius.circular(_bounceAnimation.value / 2)),
        ),
        width: _bounceAnimation.value,
        height: _bounceAnimation.value,
        child: _bounceAnimation.value > 20
            ? const Icon(
                Icons.check,
                color: Colors.white,
              )
            : null);

    var _cross = Container(
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(_bounceAnimation.value / 2)),
        ),
        width: _bounceAnimation.value,
        height: _bounceAnimation.value,
        child: _bounceAnimation.value > 20
            ? const Icon(
                Icons.cancel,
                color: Colors.red,
              )
            : null);

    var _loader = const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)));

    var childStream = StreamBuilder(
      stream: _state,
      builder: (context, snapshot) {
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: snapshot.data == ButtonState.loading ? _loader : widget.child);
      },
    );

    final _btn = ButtonTheme(
        shape: RoundedRectangleBorder(borderRadius: _borderAnimation.value),
        disabledColor: Colors.grey,
        padding: const EdgeInsets.all(0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            onSurface: Colors.grey,
            minimumSize: Size(_squeezeAnimation.value, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            primary: widget.color,
            elevation: 60,
            padding: const EdgeInsets.all(0),
          ),
          onPressed: widget.onPressed == null ? null : _btnPressed,
          child: childStream,
        ));

    return SizedBox(
        height: 50,
        child: Center(
            child: _state.value == ButtonState.error
                ? _cross
                : _state.value == ButtonState.success
                    ? _check
                    : _btn));
  }

  @override
  void initState() {
    super.initState();

    _buttonController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);

    _checkButtonControler = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);

    _borderController = AnimationController(duration: const Duration(milliseconds: 250), vsync: this);

    _bounceAnimation = Tween<double>(begin: 0, end: 30)
        .animate(CurvedAnimation(parent: _checkButtonControler, curve: Curves.elasticOut));
    _bounceAnimation.addListener(() {
      setState(() {});
    });

    _squeezeAnimation = Tween<double>(begin: 300, end: 50)
        .animate(CurvedAnimation(parent: _buttonController, curve: Curves.easeInOutCirc));

    _squeezeAnimation.addListener(() {
      setState(() {});
    });

    _squeezeAnimation.addStatusListener((state) {
      if (state == AnimationStatus.completed && true) {
        if (widget.onPressed != null) {
          widget.onPressed();
        }
      }
    });

    _borderAnimation =
        BorderRadiusTween(begin: BorderRadius.circular(35), end: BorderRadius.circular(50)).animate(_borderController);

    _borderAnimation.addListener(() {
      setState(() {});
    });

    _state.stream.listen((event) {
      widget.controller._state.sink.add(event);
    });

    widget.controller._addListeners(_start, _stop, _success);
  }

  @override
  void dispose() {
    _buttonController.dispose();
    _checkButtonControler.dispose();
    _borderController.dispose();
    _state.close();
    super.dispose();
  }

  _btnPressed() async {
    _start();
  }

  _start() {
    _state.sink.add(ButtonState.loading);
    _borderController.forward();
    _buttonController.forward();
  }

  _stop() {
    _state.sink.add(ButtonState.idle);
    _buttonController.reverse();
    _borderController.reverse();
  }

  _success() {
    _state.sink.add(ButtonState.success);
    _checkButtonControler.forward();
  }
}

class ConfirmButtonController {
  VoidCallback _startListener;
  VoidCallback _stopListener;
  VoidCallback _successListener;

  _addListeners(VoidCallback startListener, VoidCallback stopListener, VoidCallback successListener) {
    _startListener = startListener;
    _stopListener = stopListener;
    _successListener = successListener;
  }

  final BehaviorSubject<ButtonState> _state = BehaviorSubject<ButtonState>.seeded(ButtonState.idle);

  Stream<ButtonState> get stateStream => _state.stream;

  ButtonState get currentState => _state.value;

  void start() {
    _startListener();
  }

  void stop() {
    _stopListener();
  }

  void success() {
    _successListener();
  }
}
