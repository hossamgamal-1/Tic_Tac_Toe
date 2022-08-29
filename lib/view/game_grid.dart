import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/my_provider.dart';

class GameGrid extends StatelessWidget {
  const GameGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        children: gridMaker(context));
  }
}

List<Widget> gridMaker(context) {
  MyProvider watch = Provider.of<MyProvider>(context, listen: true);
  MyProvider read = Provider.of<MyProvider>(context, listen: false);
  List<Widget> grid = List.generate(
    9,
    (index) => Padding(
      padding: const EdgeInsets.all(1),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => read.gridClicked(index, context),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xff00054b),
          ),
          child: Center(
            child: Text(watch.gridValues[index],
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 50,
                    color: watch.gridValues[index] == 'X'
                        ? Colors.white
                        : Colors.red)),
          ),
        ),
      ),
    ),
  );
  return grid;
}
