import 'package:socialverse/export.dart';

import '../../../../core/configs/page_routers/slide_route.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';
  const SearchScreen({Key? key}) : super(key: key);

  static Route route() {
    return SlideRoute(
      page: SearchScreen(),
    );
  }

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    final SearchProvider search =
        Provider.of<SearchProvider>(context, listen: false);
    search.tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('rebuildinggggggggggggggggggggggggggggg');
    return Consumer<SearchProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 10,
            leading: shrink,
            leadingWidth: 0,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    __.search.clear();
                    __.user_search.clear();
                    __.subverse_search.clear();
                    __.post_search.clear();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    // size: 22,
                    color: Theme.of(context).focusColor,
                  ),
                ),
                width10,
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: SearchBar(
                      isFocus: true,
                      focusNode: myFocusNode,
                      readOnly: false,
                      controller: __.search,
                      onChanged: (query) {
                        __.onChanged(context, query: query);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              // DecoratedBox(
              //   decoration: BoxDecoration(
              //     color: Colors.transparent,
              //     border: Border(
              //       bottom: BorderSide(
              //         color: Theme.of(context).cardColor,
              //         width: 2,
              //       ),
              //     ),
              //   ),
              //   child: TabBar(
              //     physics: const NeverScrollableScrollPhysics(),
              //     controller: __.tabController,
              //     dividerColor: Color(0xFF191919),
              //     //indicatorColor: Theme.of(context).focusColor,
              //     indicatorColor: Colors.transparent,
              //     unselectedLabelStyle: Theme.of(context).textTheme.labelMedium,
              //     labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              //         fontWeight: FontWeight.bold, color: Color(0xFFA858F4)),
              //     tabs: const [
              //       Tab(
              //         text: 'Users',
              //       ),
              //       // Tab(
              //       //   text: 'Subverses',
              //       // ),
              //       Tab(
              //         text: 'Video',
              //       ),
              //     ],
              //   ),
              // ),
              // DecoratedBox(
              //   decoration: BoxDecoration(
              //     color: Colors.transparent,
              //     border: Border(
              //       bottom: BorderSide(
              //         color: Color(0xFF191919),
              //         width: 2,
              //       ),
              //     ),
              //   ),
              //   child: TabBar(
              //     controller: __.tabController,
              //     indicator: BoxDecoration(
              //       border: Border(
              //         bottom: BorderSide(
              //           color: Color(0xFFA858F4), // Bright purple underline
              //           width: 3,
              //         ),
              //       ),
              //     ),
              //     labelPadding: EdgeInsets.symmetric(
              //         horizontal: 10.0), // Reduce padding to make tabs closer
              //     unselectedLabelColor:
              //         Colors.white, // White for unselected tabs
              //     unselectedLabelStyle:
              //         Theme.of(context).textTheme.labelMedium!.copyWith(
              //               fontWeight: FontWeight.normal,
              //             ),
              //     labelColor:
              //         Color(0xFFA858F4), // Bright purple for selected tab
              //     labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              //           fontWeight: FontWeight.bold,
              //         ),
              //     tabs: const [
              //       Tab(
              //         text: 'Users',
              //       ),
              //       Tab(
              //         text: 'Videos',
              //       ),
              //     ],
              //   ),
              // ),

              if(__.search.text=='' && __.search_history.length!=0) ...[
                height15,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Search Results',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context)
                            .focusColor, // Inactive tab color
                      ),
                    ),
                  ),
                ),
                height5,
                Expanded(child: SubverseSearchList())
              ]
              else ...[
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          __.changeTabControllerIndex(0);
                        },
                        child: Text(
                          'Users',
                          style: __.tabController.index == 0
                              ? Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context)
                                .hintColor, // Active tab color
                            fontWeight: FontWeight.bold,
                          )
                              : Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context)
                                .focusColor, // Inactive tab color
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          __.changeTabControllerIndex(1);
                        },
                        child: Text(
                          'Videos',
                          style: __.tabController.index == 1
                              ? Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context)
                                .hintColor, // Active tab color
                            fontWeight: FontWeight.bold,
                          )
                              : Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context)
                                .focusColor, // Inactive tab color
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      myFocusNode.unfocus();
                    },
                    child: TabBarView(
                      controller: __.tabController,
                      children: [
                        UserSearchList(),
                        PostSearchList(),
                      ],
                    ),
                  ),
                ),
              ],


            ],
          ),
        );
      },
    );
  }
}
