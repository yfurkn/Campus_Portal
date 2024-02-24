import 'package:campus_portal_project/provider/path_provider_profile.dart';
import 'package:campus_portal_project/utility/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController studentIDController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController departmentController = TextEditingController();

  bool isEditing = true;

  Future<void> save(String name, String email, String id, String school, String department) async {
    await PathProviderProfile().saveName(name);
    await PathProviderProfile().saveMail(email);
    await PathProviderProfile().saveId(id);
    await PathProviderProfile().saveSchool(school);
    await PathProviderProfile().saveDepartment(department);
    setState(() {});
  }

  Future<void> read() async {
    nameController.text = await PathProviderProfile().readName();
    emailController.text = await PathProviderProfile().readMail();
    studentIDController.text = await PathProviderProfile().readId();
    schoolController.text = await PathProviderProfile().readSchool();
    departmentController.text = await PathProviderProfile().readDepartment();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    read();
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
          title: const Text("Profile",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              onPressed: (){
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              icon: const Icon(Icons.exit_to_app_outlined, size: 45, color: Colors.black38),
            ),
            const SizedBox(width: 15),
          ],
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(vertical: size.height*0.06),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(
                        color: Colors.black,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: Image.asset("images/logo.png", width: 200, height: 200,),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: size.height*0.01),
                  child: TextField(
                    readOnly: isEditing,
                    controller: nameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Colors.black
                        ),
                      ),
                      hintText: "Name Surname",
                      filled: true,
                      fillColor: Colors.transparent,
                      prefixIcon: Icon(Icons.account_circle, color: Colors.black,),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: size.height*0.01),
                  child: TextField(
                    readOnly: isEditing,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Colors.black
                        ),
                      ),
                      hintText: "E-Mail",
                      filled: true,
                      fillColor: Colors.transparent,
                      prefixIcon: Icon(Icons.mail, color: Colors.black,),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: size.height*0.01),
                  child: TextField(
                    readOnly: isEditing,
                    controller: studentIDController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Colors.black
                        ),
                      ),
                      hintText: "Student ID",
                      filled: true,
                      fillColor: Colors.transparent,
                      prefixIcon: Icon(Icons.key, color: Colors.black,),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: size.height*0.01),
                  child: TextField(
                    readOnly: isEditing,
                    controller: schoolController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Colors.black
                        ),
                      ),
                      hintText: "University",
                      filled: true,
                      fillColor: Colors.transparent,
                      prefixIcon: Icon(Icons.school, color: Colors.black,),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: size.height*0.03),
                  child: TextField(
                    readOnly: isEditing,
                    controller: departmentController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: Colors.black
                        ),
                      ),
                      hintText: "Department",
                      filled: true,
                      fillColor: Colors.transparent,
                      prefixIcon: Icon(Icons.work_outlined, color: Colors.black,),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: size.height*0.03),
                    child: GestureDetector(
                      onTap: (){
                        save(nameController.text, emailController.text, studentIDController.text, schoolController.text, departmentController.text);
                        setState(() {
                          isEditing = !isEditing;
                        });
                      },
                      child: Container(
                        width: size.width*0.4,
                        height: size.height*0.05,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isEditing ? Color(0xff8D0202) : Colors.green,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(isEditing ? "EDIT  " : "SAVE  ", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                            Icon(isEditing ? Icons.edit : Icons.save, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),


        bottomNavigationBar: GoogleBottomNavigationBar(selectedIndex: 1),
      ),
    );
  }
}
