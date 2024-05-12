import 'package:flutter/material.dart';

class Donation {
  final int id;
  final List<String> items;
  final String logistics;
  final String? address;
  final String? phoneNum;
  final String? date;
  final String? time;

  Donation({
    required this.id,
    required this.items,
    required this.logistics,
    this.address,
    this.phoneNum,
    required this.date,
    required this.time,
  });
}
