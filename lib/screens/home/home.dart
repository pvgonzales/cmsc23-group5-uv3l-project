import 'package:flutter/material.dart';
import 'package:flutter_project/model/org_model.dart';
import 'package:flutter_project/screens/home/categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Expanded(
                    child: Form(
                      child: TextFormField(
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFF979797).withOpacity(0.1),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Search organizations",
                          prefixIcon: const Icon(Icons.search),
                        ),
                      ),
                    )
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 97, 10).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text.rich(
                    TextSpan(
                      style: TextStyle(color: Color.fromARGB(255, 0, 38, 23)),
                      children: [
                        TextSpan(text: "Empower Change:\n"),
                        TextSpan(
                          text: "Donate Today, Transform Tomorrow!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const OrgCategories(),
                Expanded(
                  child: ListView.builder(
                    itemCount: dummyOrgs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFF979797).withOpacity(0.1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(dummyOrgs[index].image, width: 100, height: 100)
                              ),
                              Text(dummyOrgs[index].name, style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                              IconButton(
                                onPressed: () async {
                                  var res = await Navigator.pushNamed(context, '/org-details', arguments: dummyOrgs[index]);
                                  ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(SnackBar(content: Text(res as String)));
                                }, 
                                icon: const Icon(Icons.arrow_right),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}