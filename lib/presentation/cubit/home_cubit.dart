import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_state.dart';
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final _myBox = Hive.box('myBox');

  // Inside HomeCubit

  List<dynamic> get keys => _myBox.keys.toList();
  List<dynamic> get values => _myBox.values.toList();


  List result = [];
  int counter = 1;
  SharedPreferences? prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    counter = getPrefs() ?? 1;
    print("Counter loaded: $counter");
  }

  void writeData(String value) {
    if(value.isEmpty){
      return;
    }
    _myBox.put(counter, value);
    print(counter);
    counter++;
    print(counter);
    setPrefs(counter);
    readData();
    emit(ValueAdded());
  }

  void readData() {
    result = _myBox.values.toList();
    emit(ValueRead());
  }

  void deleteData(value) {
    if(value == 'all'){
      _myBox.clear();
      result.clear();
      setPrefs(1);
      emit(AllValueDeleted());
      readData();
    }else {
      _myBox.delete(value);
      counter--;
      setPrefs(counter);
      readData();
      emit(ValueDeleted());
    }

  }


  Future<void> setPrefs(int count) async {
    await prefs?.setInt("Item_Count", count);
    counter = getPrefs()!;
  }

  int? getPrefs() {
    return prefs?.getInt("Item_Count");
  }

  Future<void> remPrefs() async {
    await prefs?.remove("Item_Count");
  }
}
