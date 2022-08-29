import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/my_provider.dart';
import 'game_grid.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyProvider watch = context.watch<MyProvider>();
    MyProvider read = context.read<MyProvider>();
    MediaQueryData mQ = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: mQ.orientation == Orientation.portrait
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //const SizedBox(height: 5),
                  SizedBox(
                    height: mQ.size.height * 0.08,
                    child: SwitchListTile.adaptive(
                      value: watch.twoPlayerSwitch,
                      onChanged: (x) {
                        read.twoPlayerSwitchLogic(x);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: watch.twoPlayerSwitch
                              ? const Text('Two Player Mode is On.')
                              : const Text('Two Player Mode is Off.'),
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ));
                      },
                      title: Text(
                        'Turn on/off two player mode',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mQ.size.height * 0.08,
                    child: Text(
                      'IT\'S ${watch.currentPlayer} TURN',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  SizedBox(
                    height: mQ.size.width * 0.9,
                    width: mQ.size.width * 0.9,
                    child: const GameGrid(),
                  ),
                  SizedBox(
                    height: mQ.size.height * 0.08,
                    width: mQ.size.height * 0.3,
                    child: ElevatedButton.icon(
                      onPressed: read.repeat,
                      icon: const Icon(
                        Icons.repeat,
                        color: Colors.white,
                      ),
                      label: const Text('Repeat the game',
                          style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)))),
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
              )
            : Center(
                child: Row(
                  children: [
                    SizedBox(
                      width: mQ.size.width * 0.5,
                      height: mQ.size.height * 0.9 - mQ.padding.top,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(height: 5),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                color: const Color(0xff00054b),
                                borderRadius: BorderRadius.circular(200)),
                            child: SwitchListTile.adaptive(
                              value: watch.twoPlayerSwitch,
                              onChanged: (x) {
                                read.twoPlayerSwitchLogic(x);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: watch.twoPlayerSwitch
                                      ? const Text('Two Player Mode is On.')
                                      : const Text('Two Player Mode is Off.'),
                                  duration: const Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                ));
                              },
                              title: Container(
                                // margin:
                                //   const EdgeInsets.symmetric(vertical: 10),
                                child: FittedBox(
                                  child: Text(
                                    'Turn on/off two player mode',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: mQ.size.height * 0.1,
                            child: Text(
                              'IT\'S ${watch.currentPlayer} TURN',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          SizedBox(
                            width: mQ.size.width * 0.2,
                            height: mQ.size.height * 0.07,
                            child: ElevatedButton.icon(
                              onPressed: read.repeat,
                              icon: const Icon(
                                Icons.repeat,
                                color: Colors.white,
                              ),
                              label: FittedBox(
                                child: const Text('Repeat the game',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20)),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: mQ.size.height * 0.05),
                        SizedBox(
                          width: mQ.size.height * 0.9 - mQ.padding.top,
                          height: mQ.size.height * 0.9 - mQ.padding.top,
                          child: const GameGrid(),
                        ),
                        SizedBox(height: mQ.size.height * 0.05),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

dialogMaker(context, String winner) {
  showDialog<Widget>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('GAME OVER!'),
      content: winner != ''
          ? Text('Player $winner has won.')
          : const Text('It\'s a draw.'),
      actions: [
        TextButton(
            onPressed: () {
              Provider.of<MyProvider>(context, listen: false).repeat();
              Navigator.pop(context);
            },
            child: const Text('OK'))
      ],
    ),
    barrierDismissible: false,
  );
}
