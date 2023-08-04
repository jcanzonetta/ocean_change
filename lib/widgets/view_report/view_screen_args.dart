import 'package:ocean_change/models/user_report.dart';

class ViewScreenArgs {
  final UserReport userReport;
  final bool adminStatus;

  ViewScreenArgs(this.userReport, this.adminStatus);
}
