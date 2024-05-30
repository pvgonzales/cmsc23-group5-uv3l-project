import 'package:flutter/material.dart';
import 'package:flutter_project/model/donationdrive_model.dart';
import 'package:flutter_project/model/org_model.dart';
import 'package:flutter_project/provider/donationdrive_provider.dart';
import 'package:flutter_project/provider/orgdrive_provider.dart';
import 'package:provider/provider.dart';

class DriveModal extends StatefulWidget {
  final int index;
  final String type;
  final String? id;

  const DriveModal(
      {super.key, required this.type, this.id, required this.index});

  @override
  State<DriveModal> createState() => _DriveModalState();
}

class _DriveModalState extends State<DriveModal> {
  late TextEditingController _formFieldName;
  late TextEditingController _formFieldDesc;
  bool status = false;

  @override
  void initState() {
    super.initState();
    _formFieldName = TextEditingController();
    _formFieldDesc = TextEditingController();

    if (widget.index != -1) {
      List<DonationDrive> orgdrivesItems =
          context.read<DonationDriveProvider>().orgdrives;
      _formFieldName.text = orgdrivesItems[widget.index].name;
      _formFieldDesc.text = orgdrivesItems[widget.index].description;
    }
  }

  @override
  void dispose() {
    _formFieldName.dispose();
    _formFieldDesc.dispose();
    super.dispose();
  }

  // Method to show the title of the modal depending on the functionality
  Text _buildTitle() {
    switch (widget.type) {
      case 'Add':
        return const Text(
          "Add Donation Drive",
          style: TextStyle(
            fontFamily: "MyFont1",
            color: Color(0xFF212738),
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        );
      case 'Edit':
        return const Text(
          "Edit Donation Drive",
          style: TextStyle(
            fontFamily: "MyFont1",
            color: Color(0xFF212738),
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        );
      case 'Delete':
        return const Text(
          "Delete Donation Drive",
          style: TextStyle(
            fontFamily: "MyFont1",
            color: Color(0xFF212738),
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        );
      default:
        return const Text("");
    }
  }

  // Method to build the content or body depending on the functionality
  Widget _buildContent(BuildContext context) {
    List<Organizations> orgdrivesItems =
        context.read<OrganizationProvider>().orgdrives;
    switch (widget.type) {
      case 'Delete':
        {
          return const Text(
            "Are you sure you want to delete donation drive?",
            style: TextStyle(
              fontFamily: "MyFont1",
              color: Color(0xFF212738),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          );
        }
      default:
        {
          return SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    const Center(
                      child: Text(
                        "Enter name",
                        style: TextStyle(
                          fontFamily: "MyFont1",
                          color: Color(0xFF212738),
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    TextField(
                      controller: _formFieldName,
                      style: TextStyle(
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Text color of the input
                        fontSize: 14,
                        fontFamily: "MyFont1",
                        // Font size of the input
                      ),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: widget.index != -1
                            ? orgdrivesItems[widget.index].name
                            : '',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: "MyFont1",
                            fontStyle: FontStyle.italic),
                        fillColor: Color(0xFF212738),
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    const Center(
                      child: Text(
                        "Enter description",
                        style: TextStyle(
                          fontFamily: "MyFont1",
                          color: Color(0xFF212738),
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    TextField(
                      style: TextStyle(
                        color: const Color.fromARGB(
                            255, 255, 255, 255), // Text color of the input
                        fontSize: 14,
                        fontFamily: "MyFont1",
                        // Font size of the input
                      ),
                      controller: _formFieldDesc,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: widget.index != -1
                            ? orgdrivesItems[widget.index].description
                            : '',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: "MyFont1",
                            fontStyle: FontStyle.italic),
                        fillColor: Color(0xFF212738),
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
    }
  }

  TextButton _dialogAction(BuildContext context) {
    List<DonationDrive> orgdrivesItems =
        context.read<DonationDriveProvider>().orgdrives;

    return TextButton(
      onPressed: () {
        switch (widget.type) {
          case 'Add':
            {
              DonationDrive newDonationDrive = DonationDrive(
                  id: 4,
                  name: _formFieldName.text,
                  description: _formFieldDesc.text);

              context.read<DonationDriveProvider>().addDrive(newDonationDrive);

              // Remove dialog after adding
              Navigator.of(context).pop();
              break;
            }
          case 'Edit':
            {
              DonationDrive info = DonationDrive(
                id: 1,
                name: _formFieldName.text,
                description: _formFieldDesc.text,
              );
              context
                  .read<DonationDriveProvider>()
                  .editDrive(widget.index, info);

              // Remove dialog after editing
              Navigator.of(context).pop();
              break;
            }
          case 'Delete':
            {
              context
                  .read<DonationDriveProvider>()
                  .deleteDrive(orgdrivesItems[widget.index].id);
              // Remove dialog after editing
              Navigator.of(context).pop();
              break;
            }
        }
      },
      style: TextButton.styleFrom(
          textStyle: TextStyle(
        fontFamily: "MyFont1",
        fontWeight: FontWeight.w900,
        fontSize: 16,
      )),
      child: Text(widget.type),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildTitle(),
      content: _buildContent(context),
      actions: <Widget>[
        _dialogAction(context),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text(
            "Cancel",
            style: TextStyle(
              fontFamily: "MyFont1",
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
