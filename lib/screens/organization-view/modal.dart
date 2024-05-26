import 'package:flutter/material.dart';
import 'package:flutter_project/model/org_model.dart';
import 'package:flutter_project/provider/orgdrive_provider.dart';
import 'package:provider/provider.dart';

class DriveModal extends StatefulWidget {
  final int index;
  final String type;
  final String? id;

  const DriveModal({super.key, required this.type, this.id, required this.index});

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
      List<Organizations> orgdrivesItems = context.read<OrganizationProvider>().orgdrives;
      _formFieldName.text = orgdrivesItems[widget.index].name;
      _formFieldDesc.text = orgdrivesItems[widget.index].description;
      status = orgdrivesItems[widget.index].status!;
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
      case 'Edit':
        return const Text("Edit Donation Drive");
      case 'Delete':
        return const Text("Delete Donation Drive");
      default:
        return const Text("");
    }
  }

  // Method to build the content or body depending on the functionality
  Widget _buildContent(BuildContext context) {
    List<Organizations> orgdrivesItems = context.read<OrganizationProvider>().orgdrives;
    switch (widget.type) {
      case 'Delete':
        {
          return const Text(
            "Are you sure you want to delete donation drive?",
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
                      child: Text("Enter name"),
                    ),
                    TextField(
                      controller: _formFieldName,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: orgdrivesItems[widget.index].name,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Column(
                  children: [
                    const Center(
                      child: Text("Enter description"),
                    ),
                    TextField(
                      controller: _formFieldDesc,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: orgdrivesItems[widget.index].description,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Column(
                  children: [
                    const Center(
                      child: Text("Status"),
                    ),
                    Switch(
                      value: status,
                      activeColor: Colors.red,
                      onChanged: (bool value) {
                        setState(() {
                          status = value;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          );
        }
    }
  }

  TextButton _dialogAction(BuildContext context) {
    List<Organizations> orgdrivesItems = context.read<OrganizationProvider>().orgdrives;

    return TextButton(
      onPressed: () {
        switch (widget.type) {
          case 'Edit':
            {
              Organizations info = Organizations(
                id: 1,
                name: _formFieldName.text,
                description: _formFieldDesc.text,
                status: status,
              );
              context.read<OrganizationProvider>().editDrive(widget.index, info);

              // Remove dialog after editing
              Navigator.of(context).pop();
              break;
            }
          case 'Delete':
            {
              context.read<OrganizationProvider>().deleteDrive(orgdrivesItems[widget.index].id);
              // Remove dialog after editing
              Navigator.of(context).pop();
              break;
            }
        }
      },
      style: TextButton.styleFrom(
        textStyle: Theme.of(context).textTheme.labelLarge,
      ),
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
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}