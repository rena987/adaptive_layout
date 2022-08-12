import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';

import 'breakpoint.dart';
import 'breakpoints.dart';

class FeaturedItems extends StatefulWidget {
  const FeaturedItems({Key? key}) : super(key: key);

  @override
  State<FeaturedItems> createState() => _FeaturedItemsState();
}

class _FeaturedItemsState extends State<FeaturedItems> {
  @override
  Widget build(BuildContext context) {
    late bool showGridView;
    final Breakpoint breakpoint = BreakpointLayout.breakpointFor(context);
    switch (breakpoint) {
      case DesktopSmallBreakpoint():
        showGridView = false;
        break;
      case DesktopLargeBreakpoint():
        showGridView = true;
        break;
    }

    return Container(
      color: Colors.white,
      child: ItemGrid(
        items: allItems,
        showGrid: showGridView,
      ),
    );

    /*
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            opacity: showGridView ? 0 : 1.0,
            child: const ItemList(items: allItems),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            opacity: showGridView ? 1.0 : 0,
            child: Visibility(
              child: const ItemGrid(items: allItems),
              maintainInteractivity: false,
            ),
          ),
        ],
      ),
    );*/
  }
}

/* mobile screen layout
class ItemList extends StatelessWidget {
  const ItemList({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Item> items;

  void initState() {}

  @override
  Widget build(BuildContext context) {
    return
        //color: const Color.fromRGBO(242, 231, 248, 1),
        //child: CustomScrollView(slivers: [
        //  SliverToBoxAdapter(
        Container(
      color: const Color.fromRGBO(242, 231, 248, 1),
      child: ListView.builder(
        controller: ScrollController(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return (ItemListTile(item: items[index]));
        },
      ),
    );

    //  ),
    //]),
  }
}
*/

class ItemListTile extends StatelessWidget {
  const ItemListTile({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(6, 7, 6, 13),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: FittedBox(
                        fit: BoxFit.fill,
                        child:
                            Image.asset('assets/${item.imageAssetName}.png')),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(6, 8, 6, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromRGBO(62, 61, 63, 1))),
                        SizedBox(height: 6),
                        Text(item.title,
                            style: const TextStyle(
                                fontSize: 19,
                                color: Color.fromRGBO(62, 61, 63, 1))),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 18, 5, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color:
                                        const Color.fromRGBO(242, 231, 248, 1),
                                    borderRadius: BorderRadius.circular(9)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text('${item.genre} - ${item.time}',
                                      style: const TextStyle(
                                          fontSize: 10,
                                          color:
                                              Color.fromRGBO(62, 61, 63, 0.6))),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(242, 231, 248, 1),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.more_horiz_outlined,
                                        color: Color.fromRGBO(62, 61, 63, 0.7),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromRGBO(242, 231, 248, 1),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.library_books_outlined,
                                        color: Color.fromRGBO(62, 61, 63, 0.7),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// large screen layout
class ItemGrid extends StatelessWidget {
  const ItemGrid({
    Key? key,
    required this.items,
    required this.showGrid,
  }) : super(key: key);

  final List<Item> items;
  final bool showGrid;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(242, 231, 248, 1),
      child: CustomScrollView(
        primary: false,
        controller: ScrollController(),
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: MasonryGrid(
                column: (showGrid ? 2 : 1),
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
                children: returnWidgetList(items, showGrid),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*class YourLayoutDelegate extends MultiChildLayoutDelegate {
  YourLayoutDelegate({
    required this.itemsCount,
  });

  final int itemsCount;

  @override
  void performLayout(Size size) {
    
    CUSTOM MULTI CHILD LAYOUT 
    double leftWidth = size.width * (3 / 8);
    double rightWidth = size.width * (5 / 8);
    Offset childPosition = Offset.zero;
    for (int i = 0; i < itemsCount; i++) {
      if (i % 2 == 0) {
        final ssize = layoutChild(i,
            BoxConstraints(maxWidth: size.width, maxHeight: size.height / 2));
        positionChild(i, childPosition);
        childPosition += Offset(leftWidth, 0);
      } else {
        final ssize = layoutChild(i,
            BoxConstraints(maxWidth: size.width, maxHeight: size.height / 2));
        positionChild(i, childPosition);
        childPosition += Offset(-leftWidth, size.height / 2);
      }
    }
  }

  @override
  bool shouldRelayout(YourLayoutDelegate oldDelegate) {
    return oldDelegate.itemsCount != itemsCount;
  }
}*/

List<Widget> returnWidgetList(List<Item> items, bool showGrid) {
  List<Widget> allWidgets = [];
  for (int i = 0; i < items.length; i++) {
    if (items[i].live) {
      if (showGrid) {
        allWidgets.insert(
            1, LayoutId(id: i, child: LiveViewCard(item: items[i])));
      } else {
        allWidgets.insert(
            0, LayoutId(id: i, child: LiveViewCard(item: items[i])));
      }
    } else if (i % 2 == 0 || !showGrid) {
      allWidgets
          .add(LayoutId(id: i, child: ListViewCard(item: items[i], index: i)));
    } else {
      allWidgets
          .add(LayoutId(id: i, child: GridViewCard(item: items[i], index: i)));
    }
  }
  return allWidgets;
}

const Size cardSize = Size(250, 250);

class LiveViewCard extends StatelessWidget {
  const LiveViewCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardSize.width,
      child: Card(
        color: Color.fromRGBO(245, 205, 197, 1),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(6, 8, 6, 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                padding: EdgeInsets.fromLTRB(10, 4, 0, 0),
                child: Text("Live: ${item.title}",
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromRGBO(62, 61, 63, 0.9))),
              )),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                child: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16,
                  color: Color.fromRGBO(62, 61, 63, 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListViewCard extends StatelessWidget {
  const ListViewCard({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  final Item item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardSize.width,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 7, 6, 13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset('assets/${item.imageAssetName}.png')),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 8, 6, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(62, 61, 63, 1))),
                    const SizedBox(height: 6),
                    Text(item.title,
                        style: const TextStyle(
                            fontSize: 19,
                            color: Color.fromRGBO(62, 61, 63, 1))),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 18, 5, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: const Color.fromRGBO(242, 231, 248, 1),
                                borderRadius: BorderRadius.circular(9)),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text('${item.genre} - ${item.time}',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: const Color.fromRGBO(
                                          62, 61, 63, 0.6))),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(242, 231, 248, 1),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.more_horiz_outlined,
                                    color: Color.fromRGBO(62, 61, 63, 0.7),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(242, 231, 248, 1),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.library_books_outlined,
                                    color: Color.fromRGBO(62, 61, 63, 0.7),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GridViewCard extends StatelessWidget {
  const GridViewCard({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  final Item item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: cardSize.width,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 14, 15, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                                child: Text(item.name,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(62, 61, 63, 1))),
                              ),
                              Text(item.title,
                                  style: const TextStyle(
                                      fontSize: 19,
                                      color: Color.fromRGBO(62, 61, 63, 1))),
                            ],
                          ),
                        )),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(9),
                          child: SizedBox(
                              width: 120,
                              height: 120,
                              child: Image.asset(
                                  'assets/${item.imageAssetName}.png')),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: const Color.fromRGBO(242, 231, 248, 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text('${item.genre} - ${item.time}',
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: Color.fromRGBO(62, 61, 63, 0.6))),
                          ),
                        ),
                        Container(
                            child: Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(242, 231, 248, 1),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.more_horiz_outlined,
                                  color: Color.fromRGBO(62, 61, 63, 0.7),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(242, 231, 248, 1),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.library_books_outlined,
                                  color: Color.fromRGBO(62, 61, 63, 0.7),
                                ),
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ],
              )),
        ));
    /*
    return FittedBox(
      //width: cardSize.width,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(6, 14, 6, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name,
                        style: TextStyle(
                            fontSize: 14,
                            color: const Color.fromRGBO(62, 61, 63, 1))),
                    Text(item.title,
                        style: TextStyle(
                            fontSize: 19,
                            color: const Color.fromRGBO(62, 61, 63, 1))),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: const Color.fromRGBO(242, 231, 248, 1),
                          borderRadius: BorderRadius.circular(9)),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('${item.genre} - ${item.time}',
                            style: TextStyle(
                                fontSize: 10,
                                color: const Color.fromRGBO(62, 61, 63, 0.6))),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //padding: ,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: SizedBox(
                          width: 100,
                          height: 100,
                          child:
                              Image.asset('assets/${item.imageAssetName}.png')),
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromRGBO(242, 231, 248, 1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.more_horiz_outlined,
                              color: const Color.fromRGBO(62, 61, 63, 0.7),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromRGBO(242, 231, 248, 1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.library_books_outlined,
                              color: const Color.fromRGBO(62, 61, 63, 0.7),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        /*child: Padding(
          padding: EdgeInsets.fromLTRB(6, 7, 6, 7),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: SizedBox(
                    height: 2 * MediaQuery.of(context).size.height / 7,
                    width: 250,
                    child: Image.asset('assets/${item.imageAssetName}.png')),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name,
                        style: TextStyle(
                            fontSize: 14,
                            color: const Color.fromRGBO(62, 61, 63, 1))),
                    SizedBox(height: 6),
                    Text(item.title,
                        style: TextStyle(
                            fontSize: 19,
                            color: const Color.fromRGBO(62, 61, 63, 1))),
                    Padding(
                      padding: EdgeInsets.fromLTRB(6, 18, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: const Color.fromRGBO(242, 231, 248, 1),
                                borderRadius: BorderRadius.circular(9)),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text('${item.genre} - ${item.time}',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: const Color.fromRGBO(
                                          62, 61, 63, 0.6))),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color.fromRGBO(242, 231, 248, 1),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.more_horiz_outlined,
                                    color:
                                        const Color.fromRGBO(62, 61, 63, 0.7),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color.fromRGBO(242, 231, 248, 1),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.library_books_outlined,
                                    color:
                                        const Color.fromRGBO(62, 61, 63, 0.7),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        */
      ),
    );
    */
  }
}

class Item {
  const Item({
    required this.name,
    required this.title,
    required this.imageAssetName,
    required this.genre,
    required this.time,
    required this.live,
  });
  final String name;
  final String title;
  final String imageAssetName;
  final String genre;
  final String time;
  final bool live;
}

const List<Item> allItems = [
  Item(
      name: 'BBC News',
      title: 'Beyoncé Announces Her First Album in Six Years',
      imageAssetName: 'beyonce',
      genre: 'Pop',
      time: '5 hours ago',
      live: false),
  Item(
    name: 'a',
    title: 'Ukraine set to be approved as EU candidate',
    imageAssetName: 'a',
    genre: 'a',
    time: 'a',
    live: true,
  ),
  Item(
      name: 'BBC News',
      title: 'Remembering the Forgotten Indian Nannies of London',
      imageAssetName: 'nannies',
      genre: 'India',
      time: '14 hours ago',
      live: false),
  Item(
      name: 'BBC News',
      title: 'Netflix Plans Real-Life Squid Game Reality TV Show',
      imageAssetName: 'squid',
      genre: 'Business',
      time: '1 day ago',
      live: false),
  Item(
      name: 'BBC News',
      title: 'Microsoft Retires Internet Explorer After 27 Years',
      imageAssetName: 'internet',
      genre: 'Tech',
      time: '1 day ago',
      live: false),
  Item(
      name: 'BBC News',
      title: 'Google Engineer says Lamda AI System may have its Own Feelings',
      imageAssetName: 'ai',
      live: false,
      genre: 'Tech',
      time: '3 days ago'),
];
