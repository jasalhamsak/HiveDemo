import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());


//reference our box
  final _myBox = Hive.box('myBox');
  List result = [] ;
  final TextEditingController addController = TextEditingController();


  //write data method
  void writeData(value){

    final data = _myBox.get(1) ?? [];
    result = List<String>.from(data);
    result.add(value);

    _myBox.put(1, result);
    print("added");
    emit(ValueAdded());
  }

  //read data method
  void readData(){
    result = _myBox.get(1);
    print("read");
    emit(ValueRead());
  }

  //Delete data method
  void deleteData(){
    _myBox.delete(1);
    result =[];
    print("deleted");
    emit(ValueDeleted());
  }

}
