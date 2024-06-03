import 'dart:convert';

class Donation {
  final int id;
  final List<String> items;
  final String logistics;
  final String? address;
  final String? phoneNum;
  final String? date;
  final String? time;
  final String? proof;
  String? status;
  String? donationdrive;
  String? donor;
  String? org;

  Donation({
    required this.id,
    required this.items,
    required this.logistics,
    this.address,
    this.phoneNum,
    required this.date,
    required this.time,
    this.proof,
    required this.status,
    this.donationdrive,
    this.donor,
    this.org
  });

  // Factory constructor to instantiate object from json format
  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      items: json['items'],
      logistics: json['logistics'],
      address: json['address'],
      phoneNum: json['phoneNum'],
      date: json['date'],
      time: json['time'],
      proof: json['proof'],
      status: json['status'],
      donationdrive: json['donationdrive'],
      donor: json['donor'],
      org: json['org']
    );
  }

  static List<Donation> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donation>((dynamic d) => Donation.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donation info) {
    return {
      'id': info.id,
      'items': info.items,
      'logistics': info.logistics,
      'address': info.address,
      'phoneNum': info.phoneNum,
      'date': info.date,
      'time': info.time,
      'proof': info.proof,
      'status': info.status,
      'donationdrive': info.donationdrive,
      'donor': info.donor,
      'org': info.org
    };
  }
}
