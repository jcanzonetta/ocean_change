import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/observation.dart';

class ObservationFilter extends StatelessWidget {
  final Function setStreamQuery;

  const ObservationFilter({super.key, required this.setStreamQuery});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('possible-observations')
            .orderBy('name')
            .snapshots(),
        builder: ((context, snapshot) {
          List<Observation> observationList = [];

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            for (final docSnapshot in snapshot.data!.docs) {
              Observation observation =
                  Observation.fromFirestore(docSnapshot.data());
              observationList.add(observation);
            }

            return ObservationPopupMenuButton(
                observationList: observationList,
                setStreamQuery: setStreamQuery);
          } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return const Text('Error: Missing form data.');
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }
}

class ObservationPopupMenuButton extends StatefulWidget {
  final Function setStreamQuery;

  const ObservationPopupMenuButton(
      {super.key, required this.observationList, required this.setStreamQuery});

  final List<Observation> observationList;

  @override
  State<ObservationPopupMenuButton> createState() =>
      _ObservationPopupMenuButtonState();
}

class _ObservationPopupMenuButtonState
    extends State<ObservationPopupMenuButton> {
  late Map selected;

  @override
  void initState() {
    super.initState();
    selected = {
      for (var observation in widget.observationList) observation.name: true
    };
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) {
          final queryList = [];
          setState(() {
            selected[value] = !selected[value];
            selected.forEach((key, value) {
              if (value) {
                queryList.add(key);
              }
            });
            widget.setStreamQuery({'observation': queryList});
          });
        },
        icon: const Icon(Icons.remove_red_eye_outlined, color: Colors.white),
        itemBuilder: (BuildContext context) {
          List<PopupMenuEntry> resultList = [];
          for (var element in widget.observationList) {
            resultList.add(CheckedPopupMenuItem(
                checked: selected[element.name] ?? true,
                value: element.name,
                child: Text(element.name)));
          }
          return resultList;
        });
  }
}
