import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/material.dart';

class PDFViewScreen extends StatefulWidget {
  final String name;
  final File file;

  PDFViewScreen({this.name, this.file});

  @override
  _PDFViewScreenState createState() =>
      _PDFViewScreenState(name: name, file: file);
}

class _PDFViewScreenState extends State<PDFViewScreen> {
  final String name;
  final File file;

  Orientation _lastScreenOrientation;
  int _currentPage = 0;
  int _totalPages = 0;
  PDFViewController _controller;
  bool isReady = false;

  _PDFViewScreenState({this.name, this.file});

  @override
  void initState() {
    super.initState();

    // Once the view has been painted, execute the orientation check.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _lastScreenOrientation = MediaQuery.of(context).orientation;
    });
  }

  // Required for redrawing the screen on changing orientation.
  _repushPDFViewer() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => PDFViewScreen(
              name: name,
              file: file,
            )));
  }

  @override
  Widget build(BuildContext context) {
    if (_lastScreenOrientation != null &&
        _lastScreenOrientation != MediaQuery.of(context).orientation) {
      // Waiting for a short interval for the view to be painted after orientation change.
      Future.delayed(Duration(microseconds: 100), _repushPDFViewer);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isReady
                ? Text(
                    "Page:    $_currentPage of $_totalPages",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Montserrat",
                      fontSize: 16.0,
                    ),
                  )
                : Offstage(),
            Container(
              margin: EdgeInsets.only(top: 12.0),
              height: MediaQuery.of(context).size.height * 0.8,
              child: PDFView(
                filePath: file.path,
                enableSwipe: true,
                // swipeHorizontal: true,
                pageFling: true,
                autoSpacing: true,
                onRender: (_pages) {
                  setState(() {
                    _totalPages = _pages;
                    isReady = true;
                  });
                },
                onViewCreated: (PDFViewController vc) {
                  _controller = vc;
                },
                onPageChanged: (page, total) {
                  setState(() {
                    _currentPage = page + 1;
                  });
                },
                onError: (error) {
                  print(error.toString());
                },
                onPageError: (page, error) {
                  print('$page: ${error.toString()}');
                },
              ),
            ),
          ],
        ),
        !isReady
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Offstage()
      ]),
    );
  }
}
