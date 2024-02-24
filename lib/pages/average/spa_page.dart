import 'package:campus_portal_project/database/dao/gpa_dao.dart';
import 'package:campus_portal_project/pages/average/spa_add_page.dart';
import 'package:campus_portal_project/provider/path_provider_spa.dart';
import 'package:flutter/material.dart';

import '../../database/dao/spa_dao.dart';
import '../../database/spa.dart';
import 'average_calculator_page.dart';

class SpaPage extends StatefulWidget {
  const SpaPage({Key? key}) : super(key: key);

  @override
  State<SpaPage> createState() => _SpaPageState();
}

class _SpaPageState extends State<SpaPage> {

  double average = 0.0;
  int sum_credit = 0;

  @override
  void initState() {
    super.initState();
    calculateAndSetAverage();
  }

  Future<void> calculateAndSetAverage() async {
    average = await calculateAverage();
    PathProviderSpa().veriYaz("$average");
    setState(() {});
  }

  Future<void> setSum() async {
    sum_credit = await sumCredit();
    setState(() {});
  }


  Future<List<Spa>> allSpa() async {
    var list = await SpaDao().allSpa();
    return list;
  }

  Future<void> addSpa(String spa_name, String spa_credit, String spa_grade) async {
    await SpaDao().addSpa(spa_name, spa_credit, spa_grade);
    setState(() {});
  }

  Future<void> updateSpa(int spa_id, String spa_name, String spa_credit, String spa_grade) async {
    await SpaDao().updateSpa(spa_id, spa_name, spa_credit, spa_grade);
    setState(() {});
  }

  Future<void> deleteSpa(int spa_id) async {
    await SpaDao().deleteSpa(spa_id);
    setState(() {});
  }

  Future<double> calculateAverage() async{
    var avg = await SpaDao().calculateAverage();

    return avg;
  }

  Future<int> sumCredit() async {
    var sumCredit = await SpaDao().sumCredit();

    return sumCredit;
  }

  Future<void> addGpa(String gpa_name, String gpa_credit, String gpa_average) async {
    await GpaDao().addGpa(gpa_name, gpa_credit, gpa_average);
    setState(() {});
  }

  String switchGrade(String spa_grade) {
    switch(spa_grade){
      case "4.00":
        return "AA";
      case "3.50":
        return "BA";
      case "3.00":
        return "BB";
      case "2.50":
        return "CB";
      case "2.00":
        return "CC";
      case "1.50":
        return "DC";
      case "1.00":
        return "DD";
      case "0.50":
        return "FD";
      case "0.00":
        return "FF";
      default:
        return "";
    }
  }

  void showAddTaskDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController creditController = TextEditingController();
    TextEditingController avgController = TextEditingController();
    final size = MediaQuery.of(context).size;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add to GPA", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
            content: Container(
              width: size.width*0.9,
              height: size.height*0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    controller: nameController,
                    autofocus: false,
                    decoration: const InputDecoration(
                        hintText: "Semester Name.."
                    ),
                  ),
                  Row(
                    children: [
                      Text("Credit: $sum_credit", style: const TextStyle(fontSize: 20,color: Colors.black54),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Average: $average", style: const TextStyle(fontSize: 20,color: Colors.black54),),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    nameController.text = "";
                    creditController.text = "";
                    avgController.text = "";
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")
              ),
              TextButton(
                  onPressed: () {
                    if(nameController.text.isNotEmpty || creditController.text.isNotEmpty || avgController.text.isNotEmpty){
                      addGpa(nameController.text, "$sum_credit", "$average");
                      nameController.text = "";
                      creditController.text = "";
                      avgController.text = "";
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add")
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey.shade300,
          leading: IconButton(
            icon: const Icon(Icons.chevron_left, size: 45),
            onPressed: (){
              calculateAndSetAverage();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AverageCalculatorPage()));
            },
          ),
          title: Text("SPA: $average",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          actions: [
            GestureDetector(
                onTap: (){
                  calculateAndSetAverage();
                  setSum();
                  showAddTaskDialog(context);
                },
                child: const Icon(Icons.save, size: 45, color: Colors.green)
            ),
            const SizedBox(width: 15),
          ],
        ),

        body: FutureBuilder<List<Spa>>(
          future: allSpa(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              var gpaList = snapshot.data;
              return ListView.builder(
                itemCount: gpaList!.length,
                itemBuilder: (context, index){
                  var list = gpaList[index];
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      child: Container(
                        height: size.height*0.12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black87,
                                offset: Offset(5, 5),
                                blurRadius: 10
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(list.spa_name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                            const SizedBox(width: 10),
                            Column(
                              children: [
                                const Text("Credit", style: TextStyle(decoration: TextDecoration.underline, fontSize: 25)),
                                Text(list.spa_credit, style: const TextStyle(fontSize: 25)),
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Average", style: TextStyle(decoration: TextDecoration.underline, fontSize: 25)),
                                Text(switchGrade(list.spa_grade), style: const TextStyle(fontSize: 25)),
                              ],
                            ),
                            IconButton(
                              onPressed: (){
                                deleteSpa(list.spa_id);
                                calculateAndSetAverage();
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            else{
              return const Center(child: Text("LOADİNG.."));
            }
          },
        ),



        //////////////////////////////////  FLOATING ACTION BUTTON  ///////////////////
        floatingActionButton: SizedBox(
          width: 80,
          height: 50,
          child: FloatingActionButton(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.add_circle),
                Text("Add")
              ],
            ),
            onPressed: (){
              calculateAndSetAverage();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SpaAddPage()));
            },
          ),
        ),
      ),
    );
  }
}
