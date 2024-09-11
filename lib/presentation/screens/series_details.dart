import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:topseries/constants/mycolors.dart';
import '../../data/models/series.dart';

class SeriesDetails extends StatelessWidget {
  final Series series;

  const SeriesDetails({super.key, required this.series});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          color: Colors.black12,
          child: Text(
            series.title,
            style:
            TextStyle(color: MyColors.myWhite, fontWeight: FontWeight.bold),
          ),
        ),
        background: Hero(
          tag: series.rank,
          child: Image.network(series.image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget seriesInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  Widget displayDescription() {
    return Center(
      child: DefaultTextStyle(
      style: const TextStyle(
      fontSize: 30.0,
      fontFamily: 'Agne',
    ),
    child: AnimatedTextKit(
      displayFullTextOnTap: true,
      totalRepeatCount: 2,
    animatedTexts: [
    TypewriterAnimatedText(series.description),
    ],
    ),
    ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          seriesInfo('Rank : ', series.rank.toString()),
                          SizedBox(
                            width: 5,
                          ),
                          Image.asset(
                            'assets/images/crown.png', // Your PNG path
                            width: 20, // Adjust size as needed
                            height: 20,
                          ),
                        ],
                      ),
                      buildDivider(328),
                      Row(
                        children: [
                          seriesInfo('Rating : ', series.rating.toString()),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(Icons.star, color: Colors.yellow),
                        ],
                      ),
                      buildDivider(315),
                      Row(
                        children: [
                          seriesInfo('Year : ', series.year),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.calendar_month,
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                      buildDivider(333),
                      seriesInfo('Genre : ', series.genre.join(",")),
                      buildDivider(320),
                      SizedBox(
                        height: 20,
                      ),

                      displayDescription(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}