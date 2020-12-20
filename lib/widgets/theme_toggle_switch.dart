import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ThemeToggler extends StatefulWidget {
  final bool toggleVal;
  final onTap;

  ThemeToggler({this.toggleVal, this.onTap});

  @override
  _ThemeTogglerState createState() => _ThemeTogglerState();
}

class _ThemeTogglerState extends State<ThemeToggler> {
  bool _val;

  @override
  void initState() {
    _val = widget.toggleVal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.only(left: 20.0),
      duration: Duration(milliseconds: 500),
      height: 30.0,
      width: 75.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: _val ? Theme.of(context).accentColor : Colors.white,
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            top: 0.0,
            left: _val ? 45.0 : 0.0,
            right: _val ? 0.0 : 45.0,
            child: InkWell(
                onTap: () {
                  setState(() {
                    _val = !_val;
                    widget.onTap();
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: _val
                        ? FaIcon(
                            FontAwesomeIcons.moon,
                            color: Colors.black,
                            size: 20.0,
                            key: UniqueKey(),
                          )
                        : FaIcon(
                            FontAwesomeIcons.sun,
                            color: Colors.white,
                            size: 20.0,
                            key: UniqueKey(),
                          ),
                  ),
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                      color: _val ? Colors.white : Colors.black,
                      borderRadius: BorderRadius.circular(30.0)),
                )),
          ),
        ],
      ),
    );
  }
}
