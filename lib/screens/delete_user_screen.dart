import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

import '../models/user_data.dart';
import '../widgets/login/sign_out_button.dart';
import '../widgets/map/delete_user_screen_button.dart';

class DeleteUserScreen extends StatefulWidget {
  static const routeName = 'DeleteUserScreen';
  const DeleteUserScreen({super.key});

  @override
  State<DeleteUserScreen> createState() => _DeleteUserScreenState();
}

class _DeleteUserScreenState extends State<DeleteUserScreen> {
  Logger logger = Logger();
  final _formKey = GlobalKey<FormState>();
  UserData deleteUser = UserData();
  @override
  void initState() {
    super.initState();

    deleteUser.email = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administration', style: TextStyle(fontSize: 22)),
        actions: const [DeleteUserButton(), SignOutButton()],
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Email to Delete"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an email";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (newValue) {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Deleting User")));
                        deleteUser.email = newValue!;
                      }
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _deleteUser(deleteUser);
                        }
                      },
                      child: const Text("Run delete"))
                ],
              ),
            ),
          )),
    );
  }

  Future _deleteUser(UserData deleteUserinput) async {
    var db = FirebaseFirestore.instance;
    
        db
        .collection("users")
        .where("email", isEqualTo: deleteUserinput.email)
        .get()
        .then((QuerySnapshot value){
            for (var element in value.docs) {
              print('${element.id} ==> to snapshot data ${element.data()}');
              db.collection("users").doc(element.id).delete().then((value) => logger.i("Deleted Document"), onError: (e) => logger.i("Error updating document $e"));
            }
        },
         onError: (e) => print("Error getting document: $e"));
        }
}
