import 'package:bhagvat_geeta_app/screen/home/model/geta_model.dart';
import 'package:bhagvat_geeta_app/screen/home/provider/home_provider.dart';
import 'package:bhagvat_geeta_app/utils/colors.dart';
import 'package:bhagvat_geeta_app/utils/share_helper.dart';
import 'package:bhagvat_geeta_app/utils/widget/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  HomeProvider? providerr;
  HomeProvider? providerw;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    context.read<HomeProvider>().getaGetJson();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    providerw = context.watch<HomeProvider>();
    providerr = context.read<HomeProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Bhagavad Gita",
            style: TextStyle(fontSize: 25, color: black),
          ),
          backgroundColor: white,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                size: 25,
                color: orange,
              ),
            ),
            IconButton(
              onPressed: () {
                alertDialog(context);
              },
              icon: Icon(
                Icons.menu,
                size: 25,
                color: orange,
              ),
            ),
            Consumer<HomeProvider>(
              builder: (context, value1, child) => Switch(
                value: value1.islight,
                onChanged: (value) {
                  ShareHelper shr = ShareHelper();
                  shr.setTheme(value);
                  value1.changeTheme();
                },
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.25,
                width: MediaQuery.sizeOf(context).width,
                child:
                    Image.asset("assets/image/image1.jpeg", fit: BoxFit.cover),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Last read",
                    style: TextStyle(
                        fontSize: 24,
                        wordSpacing: 4,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "VERSE 1.5",
                    style: TextStyle(fontSize: 20, color: grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Corrected :",
                        style: TextStyle(
                            color: grey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "This Book explains Bhagavad Gita (Sacred Text) given by Supreme God as Summary in English. The Human (Arjuna) had lot of Questions to Supreme ",
                    style: TextStyle(fontSize: 17, color: Colors.grey.shade500),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "CONTINUE READING ...",
                      style: TextStyle(color: orange, fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Chapters",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu_book,
                            color: orange,
                            size: 27,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      itemExtent: 130,
                      itemCount: providerw!.getaList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              GetaModel g1 = providerr!.getaList[index];
                              Navigator.pushNamed(context, 'info',arguments:  g1);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.fromBorderSide(
                                      BorderSide(color: grey))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${providerw!.getaList[index].id}",
                                          style: TextStyle(
                                              color: orange, fontSize: 22),
                                        ),
                                        Text(
                                          "${providerw!.getaList[index].name_transliterated}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context, 'info');
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 40,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context, 'info');
                                          },
                                          icon: const Icon(Icons.menu),
                                        ),
                                        Text(
                                            "${providerw!.getaList[index].verses_count} verses")
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items:  [
            BottomNavigationBarItem(icon: Icon(Icons.home,color: black,), label: "Home",),
            BottomNavigationBarItem(icon: Icon(Icons.save,color: black,), label: "Save"),
          ],
          unselectedItemColor: black,
        ),
      ),
    );
  }
}
