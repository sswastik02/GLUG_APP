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

  PDFViewController _controller;
  bool isReady = false;

  _PDFViewScreenState({this.name, this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: TextStyle(fontFamily: "Montserrat"),
        ),
      ),
      body: Stack(children: [
        PDFView(
          filePath: file.path,
          enableSwipe: true,
          swipeHorizontal: true,
          pageFling: true,
          autoSpacing: true,
          onRender: (_pages) {
            setState(() {
              isReady = true;
            });
          },
          onViewCreated: (PDFViewController vc) {
            _controller = vc;
          },
          onError: (error) {
            print(error.toString());
          },
          onPageError: (page, error) {
            print('$page: ${error.toString()}');
          },
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
