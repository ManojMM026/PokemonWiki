import 'dart:io';
import 'dart:typed_data';
import 'package:mypokedex/pokedex/presentation/screens/home/viewmodel/pokemon_fav_view_model.dart';
import 'package:mypokedex/resources/strings.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/util/color_util.dart';
import 'package:mypokedex/widget/appbar.dart';
import 'package:mypokedex/widget/image_loader.dart';
import 'package:mypokedex/widget/moves.dart';
import 'package:mypokedex/widget/overview.dart';
import 'package:mypokedex/widget/stats.dart';
import 'package:mypokedex/widget/text_util.dart';
import 'package:strings/strings.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

import 'evolutions_grid.dart';

class PokemonDetailsPage extends StatefulWidget {
  final Pokemon pokemon;

  PokemonDetailsPage({this.pokemon});

  @override
  _PokemonDetailsPageState createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  AnimationController animateController;

  List<String> tabTitle = ["About", "Stats", "Moves", "Evolutions"];
  Orientation orientation;

  GlobalKey previewContainer = new GlobalKey();

  bool isFav = false;

  PokemonFavViewModel _favViewModel;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: tabTitle.length, vsync: this);
    isFav = widget.pokemon.details.isFav == null
        ? false
        : widget.pokemon.details.isFav;
    _favViewModel =
        PokemonFavViewModel(repo: Provider.of(context, listen: false));
    _loadFavStatus();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    orientation = MediaQuery.of(context).orientation;
    double expandedHeight = orientation == Orientation.portrait
        ? deviceHeight / 1.5
        : deviceWidth / 2;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: getColor(widget.pokemon.speciesDetails.color),
        systemNavigationBarColor: getColor(widget.pokemon.speciesDetails.color),
      ),
      child: Scaffold(
        // key: _scaffoldKey,
        appBar: PokedexAppBar(
                title: '',
                actions: [
                  _favIcon(),
                  _shareIcon(),
                ],
                onLeadingPressed: () => Navigator.pop(context),
                leadingIconColor:
                    getTextColor(widget.pokemon.speciesDetails.color),
                backgroundColor: getColor(widget.pokemon.speciesDetails.color))
            .appBar(context: context),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: getColor(widget.pokemon.speciesDetails.color),
                child: NestedScrollView(
                  physics: BouncingScrollPhysics(),
                  body: TabBarView(
                    physics: BouncingScrollPhysics(),
                    controller: _controller,
                    children: [
                      _buildDescription(),
                      Stats(pokemon: widget.pokemon),
                      PokemonMoves(pokemon: widget.pokemon),
                      EvolutionsGrid(
                        pokemon: widget.pokemon,
                      ),
                    ],
                  ),
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverAppBar(
                          pinned: false,
                          floating: false,
                          elevation: 0,
                          leading: Container(),
                          stretch: true,
                          title: Container(),
                          forceElevated: innerBoxIsScrolled,
                          backgroundColor:
                              getColor(widget.pokemon.speciesDetails.color),
                          expandedHeight: expandedHeight,
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            stretchModes: [
                              StretchMode.zoomBackground,
                            ],
                            background: RepaintBoundary(
                              key: previewContainer,
                              child: _buildPokemonImage(),
                            ),
                          ),
                          bottom: TabBar(
                            labelColor: getTextColor(
                                widget.pokemon.speciesDetails.color),
                            indicatorPadding: EdgeInsets.all(0),
                            indicatorColor: Colors.transparent,
                            isScrollable: true,
                            tabs: getTabs(),
                            controller: _controller,
                          ),
                        ),
                      )
                    ];
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Share pokemon image
  void _onShareClicked() async {
    EasyLoading.show();
    RenderRepaintBoundary boundary =
        previewContainer.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
    File imgFile = new File('$directory/screenshot.png');
    print('Image path : ${imgFile.path}');
    await imgFile.writeAsBytes(pngBytes);
    await Share.shareFiles([imgFile.path],
        subject: Strings.appName + " : " + widget.pokemon.speciesDetails.name,
        text: "https://www.google.co.in/?client=safari");
    EasyLoading.dismiss();
  }

  Widget _shareIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: InkWell(
        onTap: () => _onShareClicked(),
        child: Icon(Icons.share),
      ),
    );
  }

  void _onFavClicked() {
    // EasyLoading.show();
    PokemonDetails details = widget.pokemon.details;
    details.isFav = !isFav;
    _favViewModel.updatePokemon(details).then((value) async {
      print('Update value :$value');
      await _loadFavStatus();
      _showSnackBar();
      // EasyLoading.dismiss();
    }, onError: (e) {
      print('Error in fav update $e');
      // EasyLoading.dismiss();
    });
  }

  void _showSnackBar() {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 4,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          backgroundColor: getTextColor(widget.pokemon.speciesDetails.color),
          content: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: bodyText2(
              context,
              isFav ? Strings.updateSuccess : Strings.removeFavSuccess,
              color: getColor(widget.pokemon.speciesDetails.color),
            ),
          ),
        ),
      );
    } catch (e) {
      print('Error in showing snackbar $e');
    }
  }

  Future<bool> _loadFavStatus() async {
    PokemonDetails details = await _favViewModel.getUpdatedPokemonDetails(
        id: widget.pokemon.details.id);
    print('Fav pokemon update : ${details.isFav} ${details.name}');
    if (mounted) {
      setState(() {
        isFav = details.isFav == null ? false : details.isFav;
      });
    }
    return Future.value(isFav);
  }

  Widget _favIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: InkWell(
        onTap: () => _onFavClicked(),
        child: Icon(isFav ? Icons.favorite : Icons.favorite_border_outlined),
      ),
    );
  }

  ///create tabs
  List<Tab> getTabs() {
    List<Tab> tabs = [];
    tabTitle.forEach((title) {
      tabs.add(
        Tab(text: title),
      );
    });

    return tabs;
  }

  ///build description
  Widget _buildDescription() {
    return OverView(
      pokemon: widget.pokemon,
    );
  }

  ///build pokemon rank
  Widget _buildBigRank() {
    return FlipInX(
      delay: Duration(milliseconds: AppConstants.animationDuration),
      child: Container(
        alignment: Alignment.topCenter,
        child: orientation == Orientation.portrait
            ? headline1(context,
                "#" + widget.pokemon.details.id.toString().toUpperCase(),
                alignCenter: true,
                color: getTextColor(widget.pokemon.speciesDetails.color)
                    .withOpacity(0.3))
            : headline2(context,
                "#" + widget.pokemon.details.id.toString().toUpperCase(),
                alignCenter: true,
                color: getTextColor(widget.pokemon.speciesDetails.color)
                    .withOpacity(0.3)),
      ),
    );
  }

  ///build pokemon image view
  Widget _buildPokemonImage() {
    return Container(
      color: getColor(widget.pokemon.speciesDetails.color),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildBigRank(),
          FractionallySizedBox(
            widthFactor: orientation == Orientation.portrait ? 0.7 : 0.3,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getTextColor(widget.pokemon.speciesDetails.color)
                      .withOpacity(0.08)),
              child: Hero(
                tag: this.widget.pokemon.details.id.toString() + " ",
                transitionOnUserGestures: true,
                child: Center(
                  child: _loadPokemonImage(
                      url: AppConstants.pokemonImageUrl +
                          this.widget.pokemon.details.id.toString() +
                          ".png"),
                ),
              ),
            ),
          ),
          Center(
            child: headline4(context, capitalize(widget.pokemon.details.name),
                color: getTextColor(widget.pokemon.speciesDetails.color)),
          ),
        ],
      ),
    );
  }

  bool _animate = false;

  void _onPokemonTapped() {
    setState(() {
      _animate = true;
      animateController.forward();
      animateController.reset();
    });
  }

  ///load image from url
  Widget _loadPokemonImage({String url}) {
    return Bounce(
      manualTrigger: true,
      animate: _animate,
      controller: (controller) => animateController = controller,
      child: InkWell(
        onTap: () => _onPokemonTapped(),
        child: AppImageLoader.withImage(
            imageUrl: url,
            imageType: ImageType.NETWORK,
            showCircleImage: false,
            roundCorners: false),
      ),
    );
  }
}
