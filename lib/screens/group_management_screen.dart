import 'package:flutter/material.dart';
import 'package:piscine_laghetto/providers/group_provider.dart';
import 'package:piscine_laghetto/widgets/group_listview.dart';
import 'package:piscine_laghetto/widgets/new_group_dialog.dart';
import 'package:provider/provider.dart';

class GroupManagementScreen extends StatefulWidget {
  const GroupManagementScreen({Key? key}) : super(key: key);

  @override
  _GroupManagementScreenState createState() => _GroupManagementScreenState();

  static const routeName = '/group-management';
}

class _GroupManagementScreenState extends State<GroupManagementScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<GroupProvider>(context, listen: false).getGroups();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xFF3bbddc),
                Color(0xFF0375fe),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            )),
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true,
                title: Text(
                  'Gestione Gruppi',
                  style: Theme.of(context).textTheme.headline1,
                )),
            backgroundColor: Colors.transparent,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              height: 70,
              width: 70,
              padding: EdgeInsets.all(1),
              child: FloatingActionButton(
                backgroundColor: const Color(0xFF0375fe),
                onPressed: () {
                  showDialog(
                      context: context, builder: (context) => NewGroupDialog());
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 20, left: 5),
                  color: Colors.transparent,
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 45,
                    width: mediaQuery.width * 0.9,
                    child: TextField(
                        controller: _searchController,
                        onSubmitted: (value) =>
                            Provider.of<GroupProvider>(context, listen: false)
                                .getGroups(search: value),
                        cursorColor: Theme.of(context).primaryColor,
                        textAlignVertical: TextAlignVertical.bottom,
                        style: Theme.of(context).textTheme.headline3,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.5)),
                          suffixIcon: IconButton(
                              splashRadius: 5,
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                Provider.of<GroupProvider>(context,
                                        listen: false)
                                    .getGroups(search: _searchController.text);
                              },
                              icon: Icon(Icons.search, color: Colors.black)),
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Color(0xFF979797)),
                          hintText: "Cerca gruppi...",
                          fillColor: Colors.white,
                        )),
                  ),
                ),
                Container(
                    child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      height: 65,
                      child: Row(
                        children: [
                          Flexible(
                              fit: FlexFit.tight,
                              flex: 1,
                              child: Container(child: Container())),
                          Flexible(
                              fit: FlexFit.tight,
                              flex: 1,
                              child: Container(child: Text('ID'))),
                          Flexible(
                              fit: FlexFit.tight,
                              flex: 1,
                              child: Container(child: Text('Nome'))),
                          SizedBox(
                            width: 110,
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 0,
                    )
                  ],
                )),
                Expanded(
                    child: Stack(
                  children: [
                    Container(
                      color: Colors.white,
                    ),
                    GroupListView(),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
