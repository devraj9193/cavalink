import 'package:cavalink/utils/constants.dart';
import 'package:flutter/material.dart';

class StatusInfo {
  final String label;
  final Color color;

  StatusInfo({required this.label, required this.color});
}

class StatusHelper {
  static StatusInfo getStatus(String? status) {
    switch (status?.toLowerCase()) {
      case "registered":
        return StatusInfo(label: "New", color: gWhiteColor);

      case "withdrawn":
        return StatusInfo(label: "Withdrawn", color: Colors.orange);

      case "eliminated":
        return StatusInfo(label: "Eliminated", color: gSecondaryColor);

      case "active":
        return StatusInfo(label: "Qualified", color: Colors.green);

      case "disqualified":
        return StatusInfo(label: "Disqualified", color: gSecondaryColor);

      default:
        return StatusInfo(label: "Unknown", color: gGreyColor);
    }
  }
}
