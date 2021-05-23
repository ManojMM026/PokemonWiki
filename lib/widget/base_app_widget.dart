import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypokedex/resources/strings.dart';
import 'package:mypokedex/util/color_util.dart';
import 'package:mypokedex/util/connectivity_service.dart';
import 'package:mypokedex/widget/text_util.dart';

abstract class PokemonBaseStateFullWidget<T> extends StatefulWidget {}

abstract class PokemonBaseState<T extends PokemonBaseStateFullWidget>
    extends State<T> {
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnectionState();
    _listenToConnectionState();
  }

  void _checkConnectionState() async {
    ConnectivityService.getInstance().isConnected().then((isConnected) {
      print("Connection status : " + isConnected.toString());
      _connectionFlag(isConnected);
    });
  }

  void _listenToConnectionState() {
    ConnectivityService.getInstance()
        .connectionStatusController
        .listen((hasConnection) {
      print("Connection status : " + hasConnection.toString());
      _connectionFlag(hasConnection);
      /*if (!hasConnection) {
        _showNoInternet();
      }*/
    });
  }

  void _connectionFlag(bool connected) {
    if (mounted) {
      setState(() {
        isConnected = connected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isConnected) {
      return Column(
            children: [
              Expanded(child: buildBody()),
              _noInternetStrip(),
            ],
          );
    } else {
      return buildBody();
    }
  }

  Widget _noInternetStrip() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: red,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:15.0),
            child: subtitle2(context, Strings.noInternetConnection,color: Colors.white),
          ),
          TextButton(
            child: subtitle2(context, Strings.retry, color: white),
            onPressed: () => _checkConnectionState(),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return null;
  }
}
