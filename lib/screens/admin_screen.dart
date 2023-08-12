import 'package:flutter/material.dart';
import 'package:ocean_change/widgets/admin/user_lookup.dart';
import 'package:ocean_change/widgets/admin/user_not_found_error.dart';
import 'package:ocean_change/widgets/login/sign_out_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_change/models/user_data.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = 'AdminScreen';

  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final formKey = GlobalKey<FormState>();
  UserData user = UserData();
  final usersData = FirebaseFirestore.instance.collection("users");

  @override
  void initState() {
    super.initState();
    user.email = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Administration', style: TextStyle(fontSize: 22)),
          actions: const [SignOutButton()],
        ),
        body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(24.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          'Enter the email of the user you want to view.'),
                      TextFormField(
                        decoration: const InputDecoration(labelText: "Email"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter an email";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          user.email = value!;
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _findUser(usersData);
                          },
                          child: const Text("Look up user")),
                      UserLookup(user: user)
                    ]),
              ),
            )));
  }

  Future _findUser(CollectionReference<Map<String, dynamic>> usersData) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      usersData
          .where("email", isEqualTo: user.email)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.size == 0) {
          showUserNotFoundError(
              context, "${user.email} is not a registered user.");
          setState(() {
            // we clear user.email to remove any previously looked up users from the display
            user.email = "";
          });
          // if the email entered is a user, querySnapshot should return just one doc
        } else {
          final userData = querySnapshot.docs[0].data();
          final userID = querySnapshot.docs[0].id;
          setState(() {
            user = UserData.fromFirestore(userData, userID);
          });
        }
      });
    }
  }
}
