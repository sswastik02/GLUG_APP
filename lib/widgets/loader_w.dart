import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';

class Loader {
  BuildContext loaderContext;

  show(context) async {
    await showDialog(
      context: context,
      builder: (context) {
        loaderContext = context;
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 5.0,
          backgroundColor: Colors.transparent,
          child: Container(
              height: MediaQuery.of(context).size.width * 0.55,
              width: MediaQuery.of(context).size.width * 0.55,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Theme.of(context).primaryColor == Colors.black
                    ? Colors.blueGrey[900]
                    : Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 5),
                      blurRadius: 10),
                ],
              ),
              child: Container(
                height: MediaQuery.of(context).size.width * 0.5,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("images/back3.jpg"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: FlareLoading(
                  fit: BoxFit.fitHeight,
                  name: 'images/Bart.flr',
                  // startAnimation: 'walk',
                  loopAnimation: 'Excited Hi',
                  // endAnimation: 'walk',
                  onSuccess: (_) {},
                  onError: (_, __) {},
                ),
              )),
        );
      },
    );
  }
  
  showLoader(BuildContext context){
    Future.delayed(Duration(microseconds: 100), () =>(show(context)));
  }

  dismiss() {
    if(loaderContext!=null) {
      Navigator.pop(loaderContext);
    }
  }
}
