import 'package:contest_user_app/Model/participateusermodel.dart';
import 'package:contest_user_app/dbhelper/db.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

class FormParticipate extends StatefulWidget {
  @override
  _FormParticipateState createState() => _FormParticipateState();
}

class _FormParticipateState extends State<FormParticipate> {
  RegExp regexEmail = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  RegExp regMobile = new RegExp('^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]');

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  String validateName(String value) {
    if (value.length < 3) {
      return 'Name must be more than 2 charater';
    }
    return null;
  }

  final Database _firestore = Database();
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  // final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        title: Text(
          "Participate",
          style: GoogleFonts.aclonica(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _globalkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            nameFormField(),
            SizedBox(
              height: 20,
            ),
            emailTextField(),
            SizedBox(
              height: 20,
            ),
            phoneTextField(),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              onPressed: () {
                final UserContestModel usercontestmodel = UserContestModel(
                    username: _name.text,
                    email: _email.text,
                    phone: _phone.text,
                    votes: 0);

                if (regexEmail.hasMatch(_email.text) &&
                    regMobile.hasMatch(_phone.text)) {
                  _firestore.addContent(usercontestmodel);
                  _name.text = "";
                  _email.text = "";
                  _phone.text = "";
                  Navigator.pop(context);
                } else if (!regexEmail.hasMatch(_email.text) &&
                    !regMobile.hasMatch(_phone.text)) {
                  _showDialogBoth();
                } else if (!regMobile.hasMatch(_phone.text)) {
                  _showDialogMobile();
                } else if (!regexEmail.hasMatch(_email.text)) {
                  _showDialogemail();
                }
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              color: Colors.amber,elevation: 2.0,padding: EdgeInsets.all(20),
              child: Text("PARTICIPATE", style: GoogleFonts.aBeeZee(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }

  Widget nameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      controller: _name,
      validator: (value) => validateName(value),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "Name",
        helperText: "Name can't be empty",
        hintText: "Dev Stack",
      ),
    );
  }

  Widget emailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _email,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "Email",
        helperText: "Email can't be empty",
        hintText: "abc@xyz.com",
      ),
    );
  }

  Widget phoneTextField() {
    return TextFormField(
      controller: _phone,
      keyboardType: TextInputType.number,
      validator: (value) => validateMobile(value),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "Phone",
        helperText: "It can't be empty",
        hintText: "+01231151515",
      ),
    );
  }

  void _showDialogemail() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("INVALID EMAIL (${(_email.text)})"),
            actions: [
              new FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("OK"))
            ],
          );
        });
  }

  void _showDialogMobile() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("INVALID PHONE (${(_phone.text)})"),
            actions: [
              new FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("OK"))
            ],
          );
        });
  }

  void _showDialogBoth() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("INVALID PHONE AND EMAIL"),
            actions: [
              new FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("OK"))
            ],
          );
        });
  }
}
