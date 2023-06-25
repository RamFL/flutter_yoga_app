import 'package:flutter/material.dart';
import 'package:flutter_yoga_app/Screens/areYouReady.dart';
import 'package:flutter_yoga_app/model/model.dart';

class StartUp extends StatelessWidget {
  final String title;
  final String imgUrl;
  final String totalTime;
  final String totalWorkouts;
  final List<Yoga> yogasList;

  const StartUp({super.key, required this.title, required this.imgUrl, required this.totalTime, required this.totalWorkouts, required this.yogasList});






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(title),
              collapseMode: CollapseMode.parallax,
              background: Image.network(
                imgUrl,
                fit: BoxFit.cover,
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.thumb_up_alt),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                     "${totalTime} || ${totalWorkouts}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 2,
                    ),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Image.network(
                              "https://www.spiritualland.com/wp-content/uploads/2019/07/SlowYellowGyrfalcon.gif"),
                        ),
                        title: Text(
                          yogasList[index].YogaTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          yogasList[index].SecondsOrTimes,
                          style: const TextStyle(fontWeight: FontWeight.w400),
                        ),
                      );
                    },
                    itemCount: yogasList.length,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AreYouReady()));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: const Text(
            "START",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
