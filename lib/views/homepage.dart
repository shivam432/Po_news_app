import 'package:cached_network_image/cached_network_image.dart';
import 'package:doenlaod_app/helper/data.dart';
import 'package:doenlaod_app/helper/widgets.dart';
import 'package:doenlaod_app/models/categorie_model.dart';
import 'package:doenlaod_app/services/auth.dart';
import 'package:doenlaod_app/views/categorie_news.dart';
import 'package:flutter/material.dart';
import '../helper/news.dart';
// import 'dart:math';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  bool darktheme_enable = false;
  bool _loading;
  var newslist;
  var key = GlobalKey<RefreshIndicatorState>();

  List<CategorieModel> categories = List<CategorieModel>();

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();

    categories = getCategories();
    getNews();
  }

  Future<Null> refresh_app() async {
    key.currentState?.show();
    await Future.delayed(Duration(seconds: 2));
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darktheme_enable ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: MyAppBar(context),
        drawer: Drawer(
            child: Container(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Dark Themes'),
                trailing: Switch(
                  value: darktheme_enable,
                  onChanged: (changedTheme) {
                    setState(() {
                      darktheme_enable = changedTheme;
                    });
                  },
                ),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () async {
                  // Navigator.pop(context);
                  await _auth.signout();
                },
              )
            ],
          ),
        )),
        body: RefreshIndicator(
          key: key,
          child: SafeArea(
            child: _loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          /// Categories
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 70,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  return CategoryCard(
                                    imageAssetUrl:
                                        categories[index].imageAssetUrl,
                                    categoryName:
                                        categories[index].categorieName,
                                  );
                                }),
                          ),

                          /// News Article
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            child: ListView.builder(
                              itemCount: newslist.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return NewsTile(
                                  imgUrl: newslist[index].urlToImage ?? "",
                                  title: newslist[index].title ?? "",
                                  desc: newslist[index].description ?? "",
                                  content: newslist[index].content ?? "",
                                  posturl: newslist[index].articleUrl ?? "",
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          onRefresh: refresh_app,
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  CategoryCard({this.imageAssetUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      newsCategory: categoryName.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black26),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
