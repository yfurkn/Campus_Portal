import 'package:campus_portal_project/provider/path_provider_gpa.dart';
import 'package:flutter/material.dart';

import '../../database/dao/gpa_dao.dart';
import '../../database/gpa.dart';
import '../home_page.dart';
import 'average_calculator_page.dart';
import 'gpa_add_page.dart';

class GpaPage extends StatefulWidget {
  const GpaPage({Key? key}) : super(key: key);

  @override
  State<GpaPage> createState() => _GpaPageState();
}

class _GpaPageState extends State<GpaPage> {

  double average = 0.0;

  @override
  void initState() {
    super.initState();

    calculateAndSetAverage();
  }

  Future<void> calculateAndSetAverage() async {
    average = await calculateAvg();
    PathProviderGpa().veriYaz("$average");
    setState(() {});
  }

  Future<List<Gpa>> allGpa() async {
    var list = await GpaDao().allGpa();
    return list;
  }

  Future<void> updateGpa(int gpa_id, String gpa_name, String gpa_credit, String gpa_average) async {
    await GpaDao().updateGpa(gpa_id, gpa_name, gpa_credit, gpa_average);
    setState(() {});
  }

  Future<void> deleteGpa(int gpa_id) async {
    await GpaDao().deleteGpa(gpa_id);
    setState(() {});
  }

  Future<double> calculateAvg() async{
    var avg = await GpaDao().calculateAvg();

    return avg;
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
          title: Text("GPA: $average",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          actions: [
            GestureDetector(
                onTap: (){
                  //calculateAndSetAverage();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                },
                child: const Icon(Icons.home, size: 45, color: Colors.black)
            ),
            const SizedBox(width: 15),
          ],
        ),

        body: FutureBuilder<List<Gpa>>(
          future: allGpa(),
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
                            Text(list.gpa_name, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                            const SizedBox(width: 10),
                            Column(
                              children: [
                                const Text("Credit", style: TextStyle(decoration: TextDecoration.underline, fontSize: 25)),
                                Text(list.gpa_credit, style: const TextStyle(fontSize: 25)),
                              ],
                            ),
                            Column(
                              children: [
                                const Text("Average", style: TextStyle(decoration: TextDecoration.underline, fontSize: 25)),
                                Text(list.gpa_average, style: const TextStyle(fontSize: 25)),
                              ],
                            ),
                            IconButton(
                              onPressed: (){
                                deleteGpa(list.gpa_id);
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
              return const Center(child: Text("LOADİNG"));
            }
          },
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
              calculateAndSetAverage();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const GpaAddPage()));
            },
          ),
        ),

      ),
    );
  }
}
