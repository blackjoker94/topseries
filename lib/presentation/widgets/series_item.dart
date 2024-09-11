import 'package:flutter/material.dart';
import 'package:topseries/constants/mycolors.dart';
import 'package:topseries/constants/strings.dart';
import 'package:topseries/data/models/series.dart';

class SeriesItem extends StatelessWidget {
  final Series series;

  const SeriesItem({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, seriesDetailsScreen,
            arguments: series),
        child: GridTile(
          child: Hero(
            tag: series.rank,
            child: Container(
              color: MyColors.myGrey,
              child: series.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                width: double.infinity,
                height: double.infinity,
                placeholder: 'assets/images/loading.gif',
                image: series.image,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/placeholder.png',
                    fit: BoxFit.cover,
                  );
                },
              )
                  : Image.asset(
                'assets/images/placeholder.png',
                fit: BoxFit.cover,
              ),
            )

          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              '${series.title}',
              style: TextStyle(
                height: 1.3,
                fontSize: 16,
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
