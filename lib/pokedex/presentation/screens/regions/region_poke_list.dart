import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypokedex/pokedex/model/response/poke_list_response.dart';
import 'package:mypokedex/pokedex/model/response/poke_region_response.dart';
import 'package:mypokedex/pokedex/model/response/region_detail_response.dart';
import 'package:mypokedex/pokedex/presentation/screens/regions/pokedex/pokedex_pokemon_list.dart';
import 'package:mypokedex/pokedex/presentation/screens/regions/pokedex/starter_pokemon.dart';
import 'package:mypokedex/pokedex/presentation/screens/regions/pokedex/trainers_pokemon.dart';
import 'package:mypokedex/pokedex/presentation/screens/regions/viewmodel/pokemon_regions_view_model.dart';
import 'package:mypokedex/resources/strings.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/util/color_util.dart';
import 'package:mypokedex/util/util.dart';
import 'package:mypokedex/widget/appbar.dart';
import 'package:mypokedex/widget/base_widget.dart';
import 'package:mypokedex/util/string_util.dart';
import 'package:mypokedex/widget/place_holder_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegionPokeList extends StatefulWidget {
  final PokeRegions region;

  RegionPokeList({this.region});

  @override
  _RegionPokeListState createState() => _RegionPokeListState();
}

class _RegionPokeListState extends State<RegionPokeList>
    with SingleTickerProviderStateMixin {
  PokemonRegionViewModel _viewModel;
  TabController _tabController;
  List<Pokedexes> pokeDexList = [];
  Map<int, List<String>> starterList = {
    1: [
      AppConstants.baseUrl + AppConstants.pokemon + "/1/",
      AppConstants.baseUrl + AppConstants.pokemon + "/4/",
      AppConstants.baseUrl + AppConstants.pokemon + "/7/"
    ],
    2: [
      AppConstants.baseUrl + AppConstants.pokemon + "/152/",
      AppConstants.baseUrl + AppConstants.pokemon + "/155/",
      AppConstants.baseUrl + AppConstants.pokemon + "/158/"
    ],
    3: [
      AppConstants.baseUrl + AppConstants.pokemon + "/252/",
      AppConstants.baseUrl + AppConstants.pokemon + "/255/",
      AppConstants.baseUrl + AppConstants.pokemon + "/258/"
    ],
    4: [
      AppConstants.baseUrl + AppConstants.pokemon + "/387/",
      AppConstants.baseUrl + AppConstants.pokemon + "/390/",
      AppConstants.baseUrl + AppConstants.pokemon + "/393/"
    ],
    5: [
      AppConstants.baseUrl + AppConstants.pokemon + "/495/",
      AppConstants.baseUrl + AppConstants.pokemon + "/498/",
      AppConstants.baseUrl + AppConstants.pokemon + "/501/"
    ],
    6: [
      AppConstants.baseUrl + AppConstants.pokemon + "/650/",
      AppConstants.baseUrl + AppConstants.pokemon + "/653/",
      AppConstants.baseUrl + AppConstants.pokemon + "/656/"
    ],
    7: [
      AppConstants.baseUrl + AppConstants.pokemon + "/722/",
      AppConstants.baseUrl + AppConstants.pokemon + "/725/",
      AppConstants.baseUrl + AppConstants.pokemon + "/728/"
    ],
    8: [
      AppConstants.baseUrl + AppConstants.pokemon + "/810/",
      AppConstants.baseUrl + AppConstants.pokemon + "/813/",
      AppConstants.baseUrl + AppConstants.pokemon + "/816/"
    ],
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white70,
        systemNavigationBarColor: Colors.white70,
      ),
      child: Scaffold(
        appBar: PokedexAppBar(
          title: widget.region.name.capitalize() + "  ${Strings.pokedex}",
          onLeadingPressed: () => Navigator.pop(context),
          tabBar: pokeDexList != null && pokeDexList.isNotEmpty
              ? _buildTabs()
              : null,
        ).appBar(context: context),
        body: _buildPokedexList(),
      ),
    );
  }

  Widget _displayPokemons(String url) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: PokedexPokemonList(
        url: url,
      ),
    );
  }

  TabBar _buildTabs() {
    return TabBar(
      labelColor: black,
      isScrollable: true,
      unselectedLabelColor: gray,
      controller: _tabController,
      tabs: _getTabs(),
    );
  }

  List<Tab> _getTabs() {
    List<Tab> tabs = [];
    tabs.add(Tab(
      text: Strings.trainersPokemon,
    ));
    tabs.add(Tab(
      text: Strings.starterPokemon,
    ));
    pokeDexList.forEach((pokedex) {
      tabs.add(Tab(
        text: pokedex.name.capitalize(),
      ));
    });
    return tabs;
  }

  List<Widget> _getPages() {
    List<Widget> widgets = [];
    widgets.add(TrainersPokemon({"Ash Ketchum": _getTrainersPokemon()}));
    widgets.add(StarterPokemon(_getStarterPack()));
    pokeDexList.forEach((element) {
      widgets.add(_displayPokemons(element.url));
    });
    return widgets;
  }

  List<Result> _getStarterPack() {
    List<Result> list = [];
    int regionId = int.tryParse(extractRegionId(widget.region.url));
    List<String> pokeList = starterList[regionId];
    if (pokeList != null) {
      pokeList.forEach((pokeUrl) {
        list.add(Result(url: pokeUrl));
      });
    }
    return list;
  }

  List<Result> _getTrainersPokemon() {
    List<Result> list = [];
    int regionId = int.tryParse(extractRegionId(widget.region.url));

    List<String> pokeList = Strings.ashPokeList[regionId];
    if (pokeList != null) {
      pokeList.forEach((pokeUrl) {
        list.add(Result(url: pokeUrl));
      });
    }

    print('Region Id : $regionId list ${list.length}');
    return list;
  }

  Widget _buildPokedexList() {
    return BaseWidget<PokemonRegionViewModel>(
      model: PokemonRegionViewModel(repo: Provider.of(context)),
      onModelReady: (model) => _onRegionDetailModelReady(model),
      builder: (context, model, child) {
        return pokeDexList == null || pokeDexList.isEmpty
            ? PlaceHolderView(
                placeHolderText: Strings.placeHolder,
              )
            : TabBarView(
                children: _getPages(),
                controller: _tabController,
              );
      },
    );
  }

  void _onRegionDetailModelReady(PokemonRegionViewModel model) {
    _viewModel = model;
    EasyLoading.show();
    _viewModel.getPokeDexList(url: widget.region.url).then((val) {
      EasyLoading.dismiss();
      if (val != null) {
        setState(() {
          pokeDexList.clear();
          pokeDexList.addAll(val);
          _tabController =
              TabController(length: pokeDexList.length + 2, vsync: this);
        });
      }
    }, onError: (e) {
      EasyLoading.dismiss();
      print('Error in pokdex: ${e.toString()}');
    });
  }
}
