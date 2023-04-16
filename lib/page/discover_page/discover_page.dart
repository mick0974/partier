import 'package:flutter/material.dart';
import '../event_widget/container/my_fancy_container.dart';
import 'package:carousel_slider/carousel_slider.dart';


/// Home page of the application.
/// This widget will contain an upper bar and an istance of page widget. In
/// particular, through a button will get access to the user's options.
class DiscoverPage extends StatefulWidget {
  final String title = 'Partier';

  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPage();
}


class _DiscoverPage extends State<DiscoverPage> {

  List<int> top = <int>[];
  List<int> bottom = <int>[0,1];

  Widget banner = CarouselSlider(
    options: CarouselOptions(
        aspectRatio: 16/9,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 2),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
    ),
    items: ['assets/images/muse.png', 'assets/images/pinguini.jpg',
      'assets/images/TOMORROWLAND.jpg'].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
              // width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  color: Colors.white24
              ),
              child: Image.asset('$i')
          );
        },
      );
    }).toList(),
  );


  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Events'),
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: const Icon(Icons.add),
      //     onPressed: () {
      //       setState(() {
      //         bottom.add(bottom.length);
      //       });
      //     },
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(
      //         Icons.remove,
      //         color: Colors.white,
      //       ),
      //       onPressed: () {
      //         setState(() {
      //           bottom.remove(bottom.length - 1);
      //         });
      //         // do something
      //       },
      //     )
      //   ],
      // ),
      appBar: AppBar(
        backgroundColor: Colors.white24,
        toolbarHeight: 180,
        flexibleSpace: SafeArea(
          child: banner
        ),
      ),
      body: CustomScrollView(
        center: centerKey,
        slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: SafeArea(
              child: FilledButton.icon(
                onPressed: () {},
                icon: Icon(Icons.update),
                label: Text('Tap to reload'),
              )
            ),
          ),

          SliverList(
            key: centerKey,
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.25,
                  child: MyFancyContainer(
                        title: 'Festival di SanRemo!',
                        color1: Colors.lightGreenAccent,
                        color2: Colors.lightBlue,
                        subtitle: "Partecipa all'evento della musica Italiana",
                        )
                );
              },
              childCount: bottom.length,
            ),
          ),
          // SliverPadding(padding: EdgeInsets.all(5))
        ],
      ),
    );
  }
}