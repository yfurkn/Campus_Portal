import 'package:flutter/material.dart';

import '../../database/dao/gpa_dao.dart';
import '../home_page.dart';
import 'gpa_page.dart';

class GpaAddPage extends StatefulWidget {
  const GpaAddPage({Key? key}) : super(key: key);

  @override
  State<GpaAddPage> createState() => _GpaAddPageState();
}

class _GpaAddPageState extends State<GpaAddPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController creditController = TextEditingController();
  TextEditingController averageController = TextEditingController();

  Future<void> addGpa(String gpa_name, String gpa_credit, String gpa_average) async {
    await GpaDao().addGpa(gpa_name, gpa_credit, gpa_average);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey.shade300,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left, size: 45),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const GpaPage()));
            },
          ),
          title: const Text("Add Semester",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          actions: [
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                },
                child: const Icon(Icons.home, size: 45, color: Colors.black)
            ),
            const SizedBox(width: 15),
          ],
        ),

        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ///////////////////////  NAME TEXT FIELD  //////////////////////
                TextField(
                  controller: nameController,
                  autofocus: false,
                  maxLength: 7,
                  style: const TextStyle(fontSize: 25),
                  decoration: const InputDecoration(
                    hintText: "Semester Name..",
                    counterText: "",
                  ),
                ),

                ///////////////////////  CREDIT TEXT FIELD  //////////////////////
                TextField(
                  controller: creditController,
                  autofocus: false,
                  style: const TextStyle(fontSize: 25),
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                      hintText: "Credit.."
                  ),
                ),

                ///////////////////////  AVERAGE TEXT FIELD  //////////////////////
                TextField(
                  controller: averageController,
                  autofocus: false,
                  style: const TextStyle(fontSize: 25),
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                      hintText: "Average.."
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),

        //////////////////////////////////  FLOATING ACTION BUTTON  ///////////////////
        floatingActionButton: SizedBox(
          width: 80,
          height: 50,
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.add_circle),
                Text("Add")
              ],
            ),
            onPressed: (){
              if(nameController.text.isNotEmpty || creditController.text.isNotEmpty) {
                addGpa(nameController.text, creditController.text, averageController.text);
                nameController.text = "";
                creditController.text = "";
                averageController.text = "";
                Navigator.push(context, MaterialPageRoute(builder: (context) => const GpaPage()));
              }
            },
          ),
        ),
      ),
    );
  }
}
