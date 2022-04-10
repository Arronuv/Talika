import 'package:flutter/material.dart';
import 'package:talika/Model/model.dart';
import 'package:talika/Model/taskclass.dart';
import 'package:talika/Themes/theme.dart';
import 'package:talika/Widget/Listcard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<int, bool> checkstate = {};
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  late TextEditingController _taskbody;

  @override
  void initState() {
    _taskbody = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _taskbody.dispose();
    super.dispose();
  }

  void refresh() {
    setState(() {});
  }

  void changestate(int id, bool b) {
    setState(() {
      checkstate[id] = b;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: coltheme.background,
      body: Container(
        margin: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        decoration: BoxDecoration(
          color: coltheme.primarycolor,
          borderRadius: const BorderRadius.all(Radius.circular(40.0)),
        ),
        height: height,
        width: width,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: _body(height, width),
        ),
      ),
    );
  }

  _body(var height, var width) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _appbar(height, width),
            //AppBar

            Container(
              //EWelcome Message
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "What's up, ${model.username}!",
                style: coltheme.fontweightw400,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),

            _taskList(),
         const SizedBox(
            height: 10.0,
          ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              model.selectedtask.isNotEmpty?_deletefloatingButton():Container(),
              _addfloatingButton(),
                ],
              ),
            )

            // model.selectedtask.isNotEmpty?_deletefloatingButton():Container(),
            //
            // Align(
            //   child: _addfloatingButton(),
            //   alignment: Alignment.bottomRight,
            // ),

            //add task button
          ],
        ),
      ),
    );
  }

  _appbar(var h, var w) {
    return Container(
      height: h * 0.1,
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu_outlined,
                size: 30.0,
                color: coltheme.background,
              )),
          const Spacer(),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 30.0,
                color: coltheme.background,
              )),
          const SizedBox(
            width: 10.0,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none,
                size: 30.0,
                color: coltheme.background,
              )),
        ],
      ),
    );
  }

  _taskList() {
    List<Widget> tl = [];
    for (TaskData data in model.tasklist.reversed) {
      tl.add(TaskTab(
        td: data,
        checkstate: changestate,
        state: checkstate.putIfAbsent(data.id, () => false),
      ));
      tl.add(const SizedBox(
        height: 10.0,
      ));
    }

    if (model.tasklist.isEmpty) {
      tl.add(Center(
        child: Text(
          "No Tasks !!!",
          style: coltheme.fontweightw100,
        ),
      ));
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "ALL TASKS",
          style:
              coltheme.fontweightw300,
        ),
        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: tl,
          ),
        ),
      ]),
    );
  }

  Widget _addfloatingButton() {
    return FloatingActionButton(
        elevation: 10.0,
        backgroundColor: coltheme.floatbutton,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          _addtask();
        });
  }

  Widget _deletefloatingButton() {
    return FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        onPressed: () {
          _deletetask();
        });
  }

  _addtask() {
    bool _isLoading = false;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return Form(
                  key: _form,
                  child: _isLoading
                      ? Container(
                          color: coltheme.background,
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: coltheme.foreground,
                            ),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: coltheme.background,
                              borderRadius: BorderRadius.circular(20.0)),
                          height: MediaQuery.of(context).size.height * 0.43,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ListView(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Task: ",
                                  style: coltheme.fontweightw200,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                validator: (val) =>
                                    val!.length > 0 ? null : "Enter Task",
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(fontSize: 15.0),
                                  filled: true,
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  fillColor: coltheme.primarycolor,
                                ),
                                controller: _taskbody,
                                maxLines: 5,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              MaterialButton(
                                elevation: 10.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: coltheme.floatbutton,
                                  child: const Text(
                                    "Add",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (_form.currentState!.validate()) {
                                      setState(() {
                                        _isLoading = true;
                                      });

                                      TaskData da = TaskData(
                                          date: DateTime.now().toString(),
                                          task: _taskbody.text.trim());

                                      var res = await model.adddata(da);

                                      if (res != null) {
                                        setState(() => _isLoading = false);
                                        Navigator.pop(context);
                                        messageShow(context, false, res);
                                      } else {
                                        _taskbody.clear();
                                        await model.gettasks();
                                        Navigator.pop(context);
                                        messageShow(
                                            context, true, "Task Added");
                                        refresh();
                                      }
                                    }
                                  })
                            ],
                          ),
                        ),
                );
              },
            ),
          );
        });
  }

  Future _deletetask() async {
    var res = await model.deletedata();
    if (res != null) {
      messageShow(context, false, res);
    } else {
      await model.gettasks();
      messageShow(context, true, "Deleted!");
      refresh();
    }
  }
}
