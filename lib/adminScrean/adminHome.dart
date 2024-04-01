import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:myproject/Screens/profile_page.dart';
import 'package:myproject/adminScrean/admin_booking.dart';
import 'package:myproject/adminScrean/admin_category.dart';
import 'package:myproject/adminScrean/admin_menuitem.dart';
import 'package:myproject/provider/provider.dart';
import 'package:myproject/widgets/bottombr_buttens.dart';
import 'package:provider/provider.dart';

class AdminTabPage extends StatefulWidget {
  const AdminTabPage({Key? key}) : super(key: key);

  @override
  _AdminTabPageState createState() => _AdminTabPageState();
}

class _AdminTabPageState extends State<AdminTabPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  List<Widget> pageList = const [
    AdminBooking(),
    AdminCat(),
    AdminAddItems(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, child) => Scaffold(
              appBar: AppBar(
                title: const Text('Admin Page'),
                // bottom: TabBar(
                //   controller: _tabController,
                //   labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                //   tabs: const [
                //     Tab(text: 'Cart'),
                //     Tab(text: 'categories'),
                //     Tab(text: 'menuitems'),
                //     Tab(text: "Profile")
                //   ],
                // ),
              ),
              body: pageList[mainScreenNotifier.pageIndex],




              // body: TabBarView(
              //   controller: _tabController,
              //   children: const [
              //     AdminBooking(),
              //     AdminCat(),
              //     AdminAddItems(),
              //     ProfilePage()
              //   ],
              // ),
              bottomNavigationBar: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Buttens(
                        onTap: () {
                          mainScreenNotifier.pageIndex = 0;
                        },
                        icon: mainScreenNotifier.pageIndex == 0
                            ? CommunityMaterialIcons.home
                            : CommunityMaterialIcons.home_outline,
                      ),
                      Buttens(
                        // icon: Icons.collections,
                        onTap: () {
                          mainScreenNotifier.pageIndex = 1;
                        },
                        icon: mainScreenNotifier.pageIndex == 0
                            ? Ionicons.bag_add_outline
                            : Ionicons.bag_add,
                      ),
                      Buttens(
                        onTap: () {
                          mainScreenNotifier.pageIndex = 2;
                        },
                        icon: mainScreenNotifier.pageIndex == 2
                            ? Ionicons.add_circle
                            : Ionicons.add,
                      ),
                      Buttens(
                        icon: mainScreenNotifier.pageIndex == 3
                            ? Ionicons.person
                            : Ionicons.person_circle_outline,
                        onTap: () {
                          mainScreenNotifier.pageIndex = 3;
                        },
                      ),
                    ],
                  ),
                ),
              )),
            ));
  }
}
// List<Widget> pageList = const [
//   HomePage(),
//   SearchPage(),
//   ProductPage(),
//   CartPage(),
//   ProfilePage()
// ];
// body: pageList[mainScreenNotifier.pageIndex],
