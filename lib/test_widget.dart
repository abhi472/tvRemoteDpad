import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Duration duration;
  final Color? activeColor;

  const FlutterSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.duration = const Duration(milliseconds: 370),
    this.activeColor,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FlutterSwitchState();
}

class _FlutterSwitchState extends State<FlutterSwitch>
    with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  final focusNode = FocusNode();
  final FocusNode _playFocus = FocusNode();
  final FocusNode _seekFocus = FocusNode();
  final FocusNode _backFocus = FocusNode();
  final FocusNode _subFocus = FocusNode();
  final FocusNode _settingsFocus = FocusNode();
  final FocusNode _nextEpFocus = FocusNode();
  int chk = -1;
  bool switchState = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_nextEpFocus);
    });

    switchState = widget.value;
    // _setKnobPosition();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log('dependencyChanged ${widget.value}');
  }

  @override
  void didUpdateWidget(covariant FlutterSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      switchState = widget.value;
    }
  }

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Color getActiveColor(BuildContext context) {
    return widget.activeColor ?? Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Focus(
                    autofocus: false,
                    focusNode: focusNode,
                    onFocusChange: (value) => {
                      setState(() {
                        if (value) chk = 0;
                      })
                    },
                    onKeyEvent: (node, event) {
                      log('focusChanged Enter key pressed event: $event ${event is RawKeyDownEvent} ${event.logicalKey.keyId == LogicalKeyboardKey.select.keyId} eventkey: ${event.logicalKey} select:${LogicalKeyboardKey.select}');
                      if (event is KeyDownEvent &&
                          event.logicalKey.keyId ==
                              LogicalKeyboardKey.arrowDown.keyId) {
                        fieldFocusChange(context, focusNode, _nextEpFocus);
                      }
                      return KeyEventResult.ignored;
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          print("first");
                        },
                        tooltip: 'Increment',
                        child: chk == 0
                            ? const Icon(Icons.add)
                            : const Icon(Icons.home),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Focus(
                    autofocus: false,
                    focusNode: _playFocus,
                    onFocusChange: (value) => {
                      setState(() {
                        if (value) chk = 1;
                      })
                    },
                    onKeyEvent: (node, event) {
                      log('focusChanged _playFocus Enter key pressed event: $event ${event is RawKeyDownEvent} ${event.logicalKey.keyId == LogicalKeyboardKey.select.keyId} eventkey: ${event.logicalKey} select:${LogicalKeyboardKey.select}');
                      if (event is KeyDownEvent &&
                          event.logicalKey.keyId ==
                              LogicalKeyboardKey.arrowDown.keyId) {
                        fieldFocusChange(context, _playFocus, _nextEpFocus);
                      } else if (event is KeyDownEvent &&
                          event.logicalKey.keyId ==
                              LogicalKeyboardKey.arrowRight.keyId) {
                        fieldFocusChange(context, _playFocus, _subFocus);
                      }
                      return KeyEventResult.ignored;
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          print("second");
                        },
                        tooltip: 'Increment',
                        child: chk == 1
                            ? const Icon(Icons.add)
                            : const Icon(Icons.note),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Focus(
                    autofocus: false,
                    focusNode: _settingsFocus,
                    onFocusChange: (value) => {
                      setState(() {
                        if (value) chk = 5;
                      })
                    },
                    onKeyEvent: (node, event) {
                      if (event is KeyDownEvent &&
                          event.logicalKey.keyId ==
                              LogicalKeyboardKey.arrowDown.keyId) {
                        fieldFocusChange(context, _settingsFocus, _nextEpFocus);
                      }
                      return KeyEventResult.ignored;
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          print("third");
                        },
                        tooltip: 'Increment',
                        child: chk == 5
                            ? const Icon(Icons.add)
                            : const Icon(Icons.play_arrow),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Center(child: Focus(
              autofocus: false,
              focusNode: _nextEpFocus,
              onFocusChange: (value) => {
                setState(() {
                  if (value) chk = 2;
                })
              },
              onKeyEvent: (node, event) {
                if (event is KeyUpEvent &&
                    event.logicalKey.keyId ==
                        LogicalKeyboardKey.arrowUp.keyId) {
                  fieldFocusChange(context, _nextEpFocus, _playFocus);
                } else if (event is KeyDownEvent &&
                    event.logicalKey.keyId ==
                        LogicalKeyboardKey.arrowRight.keyId) {
                  fieldFocusChange(context, _nextEpFocus, _settingsFocus);
                }
                return KeyEventResult.ignored;
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: FloatingActionButton(
                  onPressed: () {
                    print("fourth");
                  },
                  tooltip: 'Increment',
                  child: chk == 2
                      ? const Icon(Icons.add)
                      : const Icon(Icons.settings),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Focus(
              autofocus: false,
              focusNode: _subFocus,
              onFocusChange: (value) => {
                setState(() {
                  if (value) chk = 3;
                })
              },
              onKeyEvent: (node, event) {

                return KeyEventResult.ignored;
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: FloatingActionButton(
                  onPressed: () {
                    print("fifth");
                  },
                  tooltip: 'Increment',
                  child: chk == 3
                      ? const Icon(Icons.add)
                      : const Icon(Icons.subtitles),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Focus(
                    autofocus: false,
                    focusNode: _seekFocus,
                    onFocusChange: (value) => {
                      setState(() {
                        if (value) chk = 4;
                      })
                    },
                    onKeyEvent: (node, event) {
                      if (event is KeyUpEvent &&
                          event.logicalKey.keyId ==
                              LogicalKeyboardKey.arrowUp.keyId) {
                        fieldFocusChange(context, _seekFocus, _subFocus);
                      }
                      return KeyEventResult.ignored;
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          print("fifth");
                        },
                        tooltip: 'Increment',
                        child: chk == 4
                            ? const Icon(Icons.add)
                            : const Icon(Icons.linear_scale),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Focus(
                    autofocus: false,
                    focusNode: _backFocus,
                    onFocusChange: (value) => {
                      setState(() {
                        if (value) chk = 6;
                      })
                    },
                    onKeyEvent: (node, event) {
                      if (event is KeyUpEvent &&
                          event.logicalKey.keyId ==
                              LogicalKeyboardKey.arrowUp.keyId) {
                        fieldFocusChange(context, _backFocus, _nextEpFocus);
                      }
                      return KeyEventResult.ignored;
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          print("second");
                        },
                        tooltip: 'Increment',
                        child: chk == 6
                            ? const Icon(Icons.add)
                            : const Icon(Icons.bed),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    _nextEpFocus.dispose();
    _playFocus.dispose();
    _subFocus.dispose();
    _settingsFocus.dispose();
    _seekFocus.dispose();

    super.dispose();
  }
}
