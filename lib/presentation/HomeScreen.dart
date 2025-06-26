import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hivepractice/presentation/cubit/home_cubit.dart';

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
              Text("CURD Operations"),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
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
                  final result = context.watch<HomeCubit>().result;
                  return result.isEmpty
                      ? SizedBox()
                      : Row(
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
                              color: Colors.red[200],
                              child: const Text("Delete all"),
                            ),
                          ],
                        );
                },
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final cubit = context.read<HomeCubit>();
                  List keys = cubit.keys;
                  List values = cubit.values;
                  final result = context.watch<HomeCubit>().result;
                  return result.isEmpty
                      ? SizedBox():Container(
                    padding: const EdgeInsets.all(20),
                    width: 300,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListView.builder(
                      itemCount: keys.length,
                      itemBuilder: (context, index) {
                        final key = keys[index];
                        final value = values[index];
                        return Container(
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
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle_outlined,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      values[index].toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                MaterialButton(
                                  shape: CircleBorder(),
                                  onPressed: () {
                                    context.read<HomeCubit>().deleteData(key);
                                  },
                                  color: Colors.red,
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
