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
      body: BlocProvider(
        create: (context) => HomeCubit(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Builder(
              builder: (context) {
                final cubit =context.read<HomeCubit>();
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: InputDecoration(fillColor: Colors.grey[100],
                        hintText: "Type Here..",
                        prefixIcon: Icon(Icons.add),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                        )),
                        controller: addController,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            cubit.writeData(addController.text);
                            addController.clear();
                          }, color: Colors.green[200],
                          child: Text("Add"),),
                        MaterialButton(
                          onPressed: () {
                    cubit.readData();
                          }, color: Colors.blue[200],
                          child: Text("Read"),),
                        MaterialButton(
                          onPressed: () {
                            cubit.deleteData();
                          }, color: Colors.red[200],
                          child: Text("Delete"),),
                      ],
                    ),
                  ],
                );
              }
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                final cubit =context.read<HomeCubit>();
                return Container(
                  padding: EdgeInsets.all(20),
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child:
                  ListView.builder(
                    padding: EdgeInsets.all(50),
                    itemCount: cubit.result.length,
                    itemBuilder: (context, index) {
                    return Text(cubit.result[index],style: TextStyle(fontSize: 30),);
                  },),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
