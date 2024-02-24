import 'package:campus_portal_project/provider/path_provider_gpa.dart';
import 'package:flutter/material.dart';
import '../../provider/path_provider_spa.dart';
import 'gpa_page.dart';
import '../home_page.dart';
import 'spa_page.dart';

class AverageCalculatorPage extends StatefulWidget {
  const AverageCalculatorPage({Key? key}) : super(key: key);

  @override
  State<AverageCalculatorPage> createState() => _AverageCalculatorPageState();
}

class _AverageCalculatorPageState extends State<AverageCalculatorPage> {

  var okunanVeri = "Loading..";
  var okunanVeri2 = "Loading..";

  Future<void> setData() async {
    okunanVeri = await PathProviderGpa().veriOku();
    setState(() {});
  }

  Future<void> setData2() async {
    okunanVeri2 = await PathProviderSpa().veriOku();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    setData();
    setData2();
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
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
            },
            icon: const Icon(Icons.chevron_left, size: 45, color: Colors.black),
          ),
          title: const Text("Average Calculator",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),

        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                //////////////////////////////////  GPA  ///////////////////////
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const GpaPage()));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: size.height*0.25,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      ),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black87,
                            offset: Offset(5, 5),
                            blurRadius: 10
                        ),
                      ],
                    ),
                    child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("GPA:", style: TextStyle(fontSize: 30, color: Colors.black),),
                            Text("$okunanVeri", style: TextStyle(fontSize: 30, color: Colors.black)),
                            const SizedBox(width: 30),
                            const Icon(Icons.arrow_forward_ios_rounded, size: 40)
                          ],
                        )
                    ),
                  ),
                ),

                //////////////////////////////////  SPA  ///////////////////////
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SpaPage()));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: size.height*0.25,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.shade100,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      ),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black87,
                            offset: Offset(5, 5),
                            blurRadius: 10
                        ),
                      ],
                    ),
                    child: Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("SPA:", style: TextStyle(fontSize: 30, color: Colors.black),),
                        Text("$okunanVeri2", style: TextStyle(fontSize: 30, color: Colors.black)),
                        const SizedBox(width: 30),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 40)
                      ],
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
