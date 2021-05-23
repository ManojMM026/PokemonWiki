import 'package:flutter/cupertino.dart';
import 'package:mypokedex/util/app_constants.dart';

abstract class BaseViewModel extends ChangeNotifier {
  bool isRefreshing = false;
  LoadingState state = LoadingState.IDLE;

  setRefreshing(bool refreshing) {
    isRefreshing = refreshing;
    notifyListeners();
  }

  setLoadingState(LoadingState state) {
    this.state = state;
    notifyListeners();
  }
}
