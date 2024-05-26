import 'package:flutter/material.dart';
import 'package:flutter_project/model/org_model.dart';
import 'package:flutter_project/provider/orgdrive_provider.dart';
import 'package:flutter_project/screens/organization%20view/modal.dart';
import 'package:flutter_project/screens/organization%20view/orgprofile.dart';
import 'package:provider/provider.dart';

class HomeScreenOrg extends StatefulWidget {
  const HomeScreenOrg({super.key});

  @override
  State<HomeScreenOrg> createState() => _HomeScreenOrgState();
}

class _HomeScreenOrgState extends State<HomeScreenOrg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: drawer,
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color:
                          const Color.fromARGB(255, 0, 97, 10).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text.rich(
                      TextSpan(
                        style: TextStyle(color: Color.fromARGB(255, 0, 38, 23)),
                        children: [
                          TextSpan(text: "Empower Change:\n"),
                          TextSpan(
                            text: "Be the Catalyst in Someone's Life!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Consumer<OrganizationProvider>(
                      builder: (context, provider, child) {
                        List<Organizations> orgdrivesItems = provider.orgdrives;
                        return ListView.builder(
                          itemCount: orgdrivesItems.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(orgdrivesItems[index].name),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) => DriveModal(
                                            type: 'Edit',
                                            index: index,
                                            //id: userid,
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.create_outlined),
                                    ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) => DriveModal(
                                          type: 'Delete',
                                          index: index
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.delete_outlined),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/list-donations');
                                    },
                                    icon: const Icon(Icons.remove_red_eye),
                                  ),
                                ],
                              ),
                            );
                          });
                      }
                    )
                  )
                ],
              ),
            )),
      ),
    );
  }

  Drawer get drawer => Drawer(
    child: ListView(padding: EdgeInsets.zero, children: [
        const DrawerHeader(child: Text("Organization")),
        ListTile(
          title: const Text('Profile'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const OrgProfile()));
          },
        ),
        ListTile(
          title: const Text('Home Page'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, "/org-home-page");
          },
        ),
        ListTile(
          title: const Text('Logout'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
    ]));

}
