import 'package:flutter/material.dart';
import '../../database/dao/spa_dao.dart';
import '../home_page.dart';
import 'spa_page.dart';

class SpaAddPage extends StatefulWidget {
  const SpaAddPage({Key? key}) : super(key: key);

  @override
  State<SpaAddPage> createState() => _SpaAddPageState();
}

class _SpaAddPageState extends State<SpaAddPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController creditController = TextEditingController();

  Future<void> addSpa(String spa_name, String spa_credit, String spa_grade) async {
    await SpaDao().addSpa(spa_name, spa_credit, spa_grade);
    setState(() {});
  }

  Future<double> calculateAverage() async{
    var avg = await SpaDao().calculateAverage();
    return avg;
  }

  var gradeList = <String>[];
  var selectedGrade = "AA";

  @override
  void initState() {
    super.initState();
    gradeList.add("AA");
    gradeList.add("BA");
    gradeList.add("BB");
    gradeList.add("CB");
    gradeList.add("CC");
    gradeList.add("DC");
    gradeList.add("DD");
    gradeList.add("FD");
    gradeList.add("FF");
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
            icon: const Icon(Icons.arrow_back_outlined, size: 30),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SpaPage()));
            },
          ),
          title: const Text("Add Course",
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
                TextField(
                  controller: nameController,
                  autofocus: false,
                  style: const TextStyle(fontSize: 25),
                  decoration: const InputDecoration(
                      hintText: "Course Name.."
                  ),
                ),
                TextField(
                  controller: creditController,
                  autofocus: false,
                  style: const TextStyle(fontSize: 25),
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: const InputDecoration(
                      hintText: "Credit.."
                  ),
                ),
                Row(
                  children: [
                    const Text("Grade:   ", style: TextStyle(fontSize: 25),),
                    DropdownButton(
                      value: selectedGrade,
                      items: gradeList.map<DropdownMenuItem<String>>((String value){
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(color: Colors.black, fontSize: 25),),
                        );
                      }).toList(),
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (String? selectedData){
                        setState(() {
                          selectedGrade = selectedData!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),

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
                switch(selectedGrade){
                  case "AA":
                    addSpa(nameController.text, creditController.text, "4.00");
                    break;
                  case "BA":
                    addSpa(nameController.text, creditController.text, "3.50");
                    break;
                  case "BB":
                    addSpa(nameController.text, creditController.text, "3.00");
                    break;
                  case "CB":
                    addSpa(nameController.text, creditController.text, "2.50");
                    break;
                  case "CC":
                    addSpa(nameController.text, creditController.text, "2.00");
                    break;
                  case "DC":
                    addSpa(nameController.text, creditController.text, "1.50");
                    break;
                  case "DD":
                    addSpa(nameController.text, creditController.text, "1.00");
                    break;
                  case "FD":
                    addSpa(nameController.text, creditController.text, "0.50");
                    break;
                  case "FF":
                    addSpa(nameController.text, creditController.text, "0.00");
                    break;
                  default:
                    addSpa(nameController.text, creditController.text, "0.00");
                }
                calculateAverage();
                nameController.text = "";
                creditController.text = "";
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SpaPage()));
              }
            },
          ),
        ),
      ),
    );
  }
}
