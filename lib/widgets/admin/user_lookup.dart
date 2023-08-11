import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocean_change/models/user_data.dart';

class UserLookup extends StatefulWidget {
  final UserData user;
  const UserLookup({super.key, required this.user});

  @override
  State<UserLookup> createState() => _UserLookupState();
}

class _UserLookupState extends State<UserLookup> {
  @override
  Widget build(BuildContext context) {
    if (widget.user.email == "" || widget.user.email == null) {
      return Container();
    } else {
      return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(children: [
            Text(widget.user.email!),
            Row(children: [
              Switch(
                  value: widget.user.adminStatus!,
                  onChanged: (bool value) {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.user.id)
                        .set({"admin": value}, SetOptions(merge: true));
                    setState(() {
                      widget.user.adminStatus = value;
                    });
                  })
            ])
          ]));
    }
  }
}
