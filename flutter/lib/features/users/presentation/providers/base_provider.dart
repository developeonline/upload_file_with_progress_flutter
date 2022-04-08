import 'package:flutter/material.dart';
import '../../../../core/enum/viewstate.dart';
class BaseProvider extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  ViewState get state => _state;


  void setCurrentState({ViewState viewState, bool shouldUpdate: true}) {
    _state = viewState;
    if(shouldUpdate) notifyListeners();
  }

}
