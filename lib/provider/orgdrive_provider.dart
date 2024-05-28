import 'package:flutter/material.dart';
import 'package:flutter_project/model/org_model.dart';

class OrganizationProvider extends ChangeNotifier {
  final bool _isLoading = false;
  final List<Organizations> _orgdrives = [
    Organizations(
        id: 1,
        image: "assets/images/org1.jpg",
        name: "CompassionWorks",
        description:
            "Angat Buhay Foundation, incorporated as Angat Pinas, Inc., is a non-profit, non-governmental organization based in the Philippines. It was founded and officially launched on July 1, 2022, a day after its founder Leni Robredo's term as Vice President of the Philippines expired.",
        status: true),
    Organizations(
        id: 2,
        image: "assets/images/org1.jpg",
        name: "EmpowerHope Foundation",
        description:
            "Angat Buhay Foundation, incorporated as Angat Pinas, Inc., is a non-profit, non-governmental organization based in the Philippines. It was founded and officially launched on July 1, 2022, a day after its founder Leni Robredo's term as Vice President of the Philippines expired.",
        status: true),
    Organizations(
        id: 3,
        image: "assets/images/org1.jpg",
        name: "BrighterTomorrows Initiative",
        description:
            "Angat Buhay Foundation, incorporated as Angat Pinas, Inc., is a non-profit, non-governmental organization based in the Philippines. It was founded and officially launched on July 1, 2022, a day after its founder Leni Robredo's term as Vice President of the Philippines expired.",
        status: true),
    Organizations(
        id: 4,
        image: "assets/images/org1.jpg",
        name: "Harmony Haven Charity",
        description:
            "Angat Buhay Foundation, incorporated as Angat Pinas, Inc., is a non-profit, non-governmental organization based in the Philippines. It was founded and officially launched on July 1, 2022, a day after its founder Leni Robredo's term as Vice President of the Philippines expired.",
        status: true),
    Organizations(
        id: 5,
        image: "assets/images/org1.jpg",
        name: "Miracle Makers Alliance",
        description:
            "Angat Buhay Foundation, incorporated as Angat Pinas, Inc., is a non-profit, non-governmental organization based in the Philippines. It was founded and officially launched on July 1, 2022, a day after its founder Leni Robredo's term as Vice President of the Philippines expired.",
        status: true),
    Organizations(
        id: 6,
        image: "assets/images/org1.jpg",
        name: "Impact Igniters Society",
        description:
            "Angat Buhay Foundation, incorporated as Angat Pinas, Inc., is a non-profit, non-governmental organization based in the Philippines. It was founded and officially launched on July 1, 2022, a day after its founder Leni Robredo's term as Vice President of the Philippines expired.",
        status: true)
  ];

  bool get isLoading => _isLoading;
  List<Organizations> get orgdrives => _orgdrives;

}
