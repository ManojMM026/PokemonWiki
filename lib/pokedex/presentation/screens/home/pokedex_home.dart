import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/all_pokemons.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/favourite/fav_pokemons.dart';
import 'package:mypokedex/pokedex/presentation/screens/regions/poke_regions.dart';
import 'package:mypokedex/pokedex/presentation/screens/types/poke_types.dart';
import 'package:mypokedex/resources/strings.dart';
import 'package:mypokedex/util/color_util.dart';
import 'package:mypokedex/util/notification_helper.dart';
import 'package:mypokedex/widget/appbar.dart';
import 'package:mypokedex/widget/banner_add_widget.dart';
import 'package:mypokedex/widget/base_app_widget.dart';
import 'package:mypokedex/widget/fade_index_stack.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:animations/animations.dart';

class PokeDexHome extends PokemonBaseStateFullWidget {
  @override
  _PokeDexHomeState createState() => _PokeDexHomeState();
}

class _PokeDexHomeState extends PokemonBaseState<PokeDexHome> {
  // BannerAd banner;
  int _selectedIndex = 0;
  List<Widget> _widgets = [];

  @override
  void initState() {
    super.initState();
    _setUpFirebaseListeners();
    _requestPermission();
    _getToken();
    _onTokenRefresh();
    _widgets = [
      AllPokemons(),
      PokemonRegions(),
      PokeTypes(),
    ];
  }

  void _getToken() {
    FirebaseMessaging.instance.getToken().then((token) {
      if (token != null) {
        print("Firebase token: $token");
      }
    });
  }

  void _onTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      if (token != null) {
        print("Firebase token refreshed : $token");
      }
    });
  }

  void _requestPermission() {
    FirebaseMessaging.instance
        .requestPermission(sound: true, badge: true, alert: true);
  }

  void _setUpFirebaseListeners() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        /* Navigator.pushNamed(context, '/message',
            arguments: MessageArguments(message, true));
      }*/
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      print("Message : " + message.toString());
      print("Message data : " + message.data.toString());
      if (message.data != null && message.data.isNotEmpty) {
        showPictureNotification(message);
      } else {
        if (notification != null && android != null) {
          showNotification(message);
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      /*Navigator.pushNamed(context, '/message',
          arguments: MessageArguments(message, true));*/
    });
  }

  Future<bool> onWillPopPressed() {
    if (_selectedIndex == 0) {
      return Future.value(true);
    } else {
      _onTabPressed(0);
    }
    return Future.value(false);
  }

  @override
  Widget buildBody() {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white70,
        systemNavigationBarColor: Colors.white70,
      ),
      child: WillPopScope(
        onWillPop: onWillPopPressed,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: Strings.tabAllPokemon,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_city),
                label: Strings.tabRegion,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.style),
                label: Strings.tabType,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: black,
            unselectedItemColor: gray,
            onTap: _onTabPressed,
          ),
          appBar: PokedexAppBar(
            title: Strings.appName,
            backgroundColor: Colors.white70,
            actions: [_favPokemons()],
            leading: Container(),
            leadingWidth: 0,
            automaticallyImplyLeading: false,
          ).appBar(context: context),
          body: Column(
            children: [
              Expanded(
                child: FadeIndexedStack(
                  children: _widgets,
                  index: _selectedIndex,
                ),
              ),
              isConnected ? _loadAdView() : Container(),
              // isConnected ? _loadAdView() : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget _favPokemons() {
    return OpenContainer<bool>(
        transitionDuration: Duration(milliseconds: 300),
        closedElevation: 0,
        transitionType: ContainerTransitionType.fadeThrough,
        openBuilder: (BuildContext _, VoidCallback openContainer) {
          return FavPokemons();
        },
        closedBuilder: (BuildContext _, VoidCallback openContainer) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(
              Icons.favorite,
              color: red,
            ),
          );
        });
  }

  void _onTabPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ///load banner ad
  Widget _loadAdView() {
    return BannerAdWidget();
  }
}
