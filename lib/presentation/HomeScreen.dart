import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivepractice/presentation/cubit/home_cubit.dart';
import 'package:recase/recase.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  final TextEditingController addController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("To Do List",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    context.read<HomeCubit>().writeData(value);
                    addController.clear();
                  },
                  controller: addController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey[100],
                    hintText: "Type Here..",
                    prefixIcon: const Icon(Icons.keyboard_arrow_right),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        onPressed: () {
                          context.read<HomeCubit>().writeData(addController.text);
                          addController.clear();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.green[300],
                        child: const Text("Add"),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final cubit = context.read<HomeCubit>();
                  if(state is AllValueDeleted||cubit.values.isEmpty){return SizedBox();}
                  else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // MaterialButton(
                              //   onPressed: context.read<HomeCubit>().readData,
                              //   color: Colors.blue[200],
                              //   child: const Text("Read"),
                              // ),
                              MaterialButton(
                                onPressed: () {
                                  context.read<HomeCubit>().deleteData("all");
                                },
                                color: Colors.red,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                child: const Text("Delete all",style: TextStyle(color: Colors.white ),),
                              ),
                            ],
                          ),
                    );
                  }
                },
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final cubit = context.read<HomeCubit>();
                  List keys = cubit.keys;
                  List values = cubit.values;
                  return state is AllValueDeleted ||cubit.values.isEmpty
                      ? SizedBox():Container(
                    padding: const EdgeInsets.all(10),
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListView.builder(
                      itemCount: keys.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final key = keys[index];
                        final value = values[index];
                        bool isStrikeOff = value["isStrikeOff"] ;
                        return InkWell(
                          onTap: (){
                            cubit.toggleStrike(key);
                          },
                          child: Container(
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(isStrikeOff?Icons.check_circle:
                                          Icons.circle_outlined,
                                          color: isStrikeOff?Colors.green:Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            values[index]["text"].toString().sentenceCase,
                                            style:  TextStyle(fontWeight: FontWeight.w500,decoration: isStrikeOff? TextDecoration.lineThrough:TextDecoration.none),
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  MaterialButton(
                                    shape: CircleBorder(),
                                    onPressed: () {
                                      context.read<HomeCubit>().deleteData(key);
                                    },
                                    color: Colors.red[400],
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
