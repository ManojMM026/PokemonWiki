import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityService {
  final connectionStatusController = PublishSubject<bool>();
  StreamSubscription subscription;

  static final ConnectivityService _instance =
      ConnectivityService._privateConstructor();

  ConnectivityService._privateConstructor() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      print("Connection : result : " + result.toString());
      if (result != ConnectivityResult.none) {
        print("Connection : result inside : " + result.toString());

        bool isDeviceConnected = await isConnected();
        if (isDeviceConnected) {
          connectionStatusController.add(true);
        } else {
          connectionStatusController.add(false);
        }
      } else {
        print("Connection : Not connected to any device");
        connectionStatusController.add(false);
      }
    });
  }

  static ConnectivityService getInstance() {
    return _instance;
  }

  static ConnectivityService get instance => _instance;

  Future<bool> isConnected() async {
    return await DataConnectionChecker().hasConnection;
  }

  dispose() {
    if (subscription != null) {
      subscription.cancel();
    }
  }
}
