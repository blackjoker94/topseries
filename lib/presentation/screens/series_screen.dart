import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:topseries/business_logic/series_cubit.dart';
import 'package:topseries/constants/mycolors.dart';
import 'package:topseries/data/models/series.dart';
import 'package:topseries/presentation/widgets/series_item.dart';

class SeriesScreen extends StatefulWidget {
  const SeriesScreen({super.key});

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
  late List<Series> allSeries;
  List<Series> searchedSeries = [];
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a series...',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 18,
        ),
      ),
      style: TextStyle(
        color: MyColors.myGrey,
        fontSize: 18,
      ),
      onChanged: (searchedQuery) {
        searchForItemsInSeries(searchedQuery);
      },
    );
  }

  void searchForItemsInSeries(String searchedQuery) {
    searchedSeries = allSeries.where((series) {
      return series.title.toLowerCase().contains(searchedQuery);
    }).toList();

    setState(() {});
  }

  List<Widget> _buildAppBarAction() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _stopSearching();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: MyColors.myGrey,
            )),
      ];
    } else {
      return [
        IconButton(
            onPressed: () {
              ModalRoute.of(context)!.addLocalHistoryEntry(
                  LocalHistoryEntry(onRemove: _stopSearching));
              setState(() {
                _isSearching = true;
              });
            },
            icon: Icon(
              Icons.search,
              color: MyColors.myGrey,
            )),
      ];
    }
  }

  void _stopSearching() {
    setState(() {
      _searchTextController.clear();
      _isSearching = false;
    });
  }

  @override
  void initState() {
    allSeries = BlocProvider.of<SeriesCubit>(context).getAllSeries();
    super.initState();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<SeriesCubit, SeriesState>(
      builder: (context, state) {
        if (state is SeriesLoaded) {
          allSeries = (state).series;
          return buildLoadedSeries();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedSeries() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildSeriesList(),
          ],
        ),
      ),
    );
  }

  Widget buildSeriesList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isEmpty ?  allSeries.length : searchedSeries.length,
      itemBuilder: (ctx, index) {
        return SeriesItem(
          series: _searchTextController.text.isEmpty ? allSeries[index] : searchedSeries[index] ,
        );
      },
    );
  }

  Widget buildAppBarTitle() {
    return Text(
      'Series',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              "Can't connect ... check internet",
              style: TextStyle(
                color: MyColors.myGrey,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 20),
            Image.asset('assets/images/no_internet.png'),
            SizedBox(height: 10),
            showLoadingIndicator(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: _isSearching ? _buildSearchField() : buildAppBarTitle(),
        actions: _buildAppBarAction(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
            ) {
          final bool connected = !connectivity.contains(ConnectivityResult.none);

          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
