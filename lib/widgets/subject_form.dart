import 'package:flutter/material.dart';
import 'package:glug_app/resources/firestore_provider.dart';

class SubjectForm extends StatefulWidget {
  @override
  _SubjectFormState createState() => _SubjectFormState();
}

class _SubjectFormState extends State<SubjectForm> {
  final _formKey = GlobalKey<FormState>();
  FirestoreProvider _provider;
  TextEditingController _ctrl1, _ctrl2, _ctrl3;

  @override
  void initState() {
    super.initState();
    _provider = FirestoreProvider();
    _ctrl1 = TextEditingController();
    _ctrl2 = TextEditingController();
    _ctrl3 = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _provider = null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Subject",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subject Name:",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 150.0,
                child: TextFormField(
                  controller: _ctrl1,
                  decoration: InputDecoration(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Classes:",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 80.0,
                child: TextFormField(
                  controller: _ctrl2,
                  decoration: InputDecoration(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Classes Attended:",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 80.0,
                child: TextFormField(
                  controller: _ctrl3,
                  decoration: InputDecoration(),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton(
                color: Colors.deepOrangeAccent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FlatButton(
                color: Colors.deepOrangeAccent,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _provider.addNewSubject({
                      "name": _ctrl1.text.toString(),
                      "total": int.parse(_ctrl2.text.toString()),
                      "attended": int.parse(_ctrl3.text.toString()),
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
