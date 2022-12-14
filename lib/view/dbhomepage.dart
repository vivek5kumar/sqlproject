import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dbmanager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DbStudentManager dbmanager = DbStudentManager();

  final _nameController = TextEditingController();
  final _courseController = TextEditingController();
  // final _idController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Student? student;
  List<Student> studList = [];
  int? updateIndex;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Sqilite Demo"),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 2,
                toolbarHeight: size.height * 0.37,
                backgroundColor: Colors.white,
                pinned: true,
                title: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) => val!.isNotEmpty
                              ? null
                              : "Name should not be empty",
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              labelText: "Name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _courseController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) => val!.isNotEmpty
                              ? null
                              : "Course should not be empty",
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              labelText: "Course",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: size.width * 0.9,
                          child: ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                _submitStudent(context);
                              },
                              child: const Text("Submit")),
                        ),
                      ],
                    )),
              ),
              FutureBuilder(
                  future: dbmanager.getStudentList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      studList = snapshot.data!;
                      studList.sort((a, b) => a.name!
                          .toLowerCase()
                          .compareTo(b.name!.toLowerCase()));
                      return studList.isNotEmpty
                          ? SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount:
                                    studList == null ? 0 : studList.length,
                                (BuildContext context, i) {
                                  Student st = studList[i];

                                  return SizedBox(
                                    height: size.height * 0.09,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Card(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                              width: size.width * 0.5,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "Name :${st.name.toString()}"),
                                                  Text(
                                                      "Course :${st.course.toString()}"),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                              child: InkWell(
                                                  onTap: () {
                                                    textUpdate(st, i);
                                                  },
                                                  child: const Icon(
                                                    Icons.edit,
                                                    color: Colors.grey,
                                                  )),
                                            ),
                                            SizedBox(
                                              width: 20,
                                              child: InkWell(
                                                  onTap: () {
                                                    conformationAlert(st, i);
                                                    // Get.back();
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : const SliverToBoxAdapter(child: Text("No data "));
                    }
                    return const SliverToBoxAdapter(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                  })
            ],
          )),
    );
  }

  void _submitStudent(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        if (student == null) {
          Student st = Student(
              id: "0",
              name: _nameController.text,
              course: _courseController.text);
          dbmanager.insertStudent(st).then((id) => {
                _nameController.clear(),
                _courseController.clear(),
              });
        } else {
          return updateFun();
        }
      });
    }
  }

  updateFun() {
    student!.name = _nameController.text;
    student!.course = _courseController.text;

    dbmanager.updateStudent(student!).then((id) {
      setState(() {
        studList[updateIndex!].name = _nameController.text;
        studList[updateIndex!].course = _courseController.text;
      });
      _nameController.clear();
      _courseController.clear();
    });
  }

  textUpdate(Student st, i) {
    _nameController.text = st.name.toString();
    _courseController.text = st.course.toString();
    student = st;
    updateIndex = i;
  }

  conformationAlert(Student st, i) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Are you sure you wante to delete !"),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    // Get.snackbar("Success", "One itme delete ${st.id}");
                    dbmanager.deleteStudent(st.id.toString());
                    setState(() {
                      studList.removeAt(i);
                    });
                    Get.back();
                  },
                  child: const Text("Yes")),
            ],
          );
        });
  }
}
