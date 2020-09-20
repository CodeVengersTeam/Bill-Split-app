import 'package:flutter/material.dart';
import 'package:flutter_workshop/screen/split_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class BillSplit extends StatefulWidget {
  BillSplit({Key key}) : super(key: key);

  @override
  _BillSplitState createState() => _BillSplitState();
}

class _BillSplitState extends State<BillSplit> {
  double amount, split;
  int person;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill split application"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                split == null
                    ? "Fill the details and click on calculate to see split"
                    : "Your split is $split",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 15),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return "Please enter amount";
                  if (double.parse(value) < 0) return "Please enter a positive value";
                  return null;
                },
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  amount = double.parse(value);
                },
                decoration: InputDecoration(
                  labelText: "Amount",
                  hintText: "1000.0",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) return "Please enter number of persons";
                  if (int.parse(value) < 1) return "Split should be between more than 2 persons";
                  if (double.parse(value) != int.parse(value)) return "Cutting people is illegal";
                  return null;
                },
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  person = int.parse(value);
                },
                decoration: InputDecoration(
                  labelText: "Number of persons",
                  hintText: "2",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();

                    split = amount / person;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SplitScreen(
                          split: split,
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  "Calculate",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Made by ❤ with by "),
                  GestureDetector(
                    onTap: () {
                      _launchURL();
                    },
                    child: Text(
                      "CodeVengers",
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
