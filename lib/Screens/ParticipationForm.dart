import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormParticipate extends StatefulWidget {
  @override
  _FormParticipateState createState() => _FormParticipateState();
}

class _FormParticipateState extends State<FormParticipate> {
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
              height: 20,
            ),
            IconButton(icon: Icon(Icons.save), onPressed: ()=>{} , iconSize: 50,)
          ],
        ),
      ),
    );
  }
    Widget nameFormField() {
      return TextFormField(
        keyboardType: TextInputType.name,
        controller: _name,
        validator: (value) {
          if (value.isEmpty) return "Name can't be empty";

          return null;
        },
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
        validator: (value) {
          if (value.isEmpty) return "Email can't be empty";

          return null;
        },
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
        validator: (value) {
          if (value.isEmpty) return "Phone can't be empty";

          return null;
        },
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
  }
