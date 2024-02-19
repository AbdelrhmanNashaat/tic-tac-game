import 'package:flutter/material.dart';
import 'package:tic_tac_game/logic/game_logic.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String activePlayer = 'X';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  Game game = Game();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            switchListTileAdaptive(),
            PlayerTurnText(activePlayer: activePlayer),
            const SizedBox(height: 50),
            gridView(context),
            Text(
              result,
              style: const TextStyle(color: Colors.white, fontSize: 52),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  activePlayer = 'X';
                  gameOver = false;
                  turn = 0;
                  result = '';
                  Player.playerX = [];
                  Player.playerO = [];
                });
              },
              icon: const Icon(
                Icons.replay,
                color: Colors.white,
              ),
              label: const Text(
                'Repeat The Game',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).splashColor),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Expanded gridView(BuildContext context) {
    return Expanded(
      child: GridView.count(
        padding: const EdgeInsets.all(16.0),
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0,
        children: List.generate(
          9,
          (index) => InkWell(
            borderRadius: BorderRadius.circular(16.0),
            onTap: gameOver
                ? null
                : () {
                    _onTap(index);
                  },
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).shadowColor,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Center(
                child: Text(
                  Player.playerX.contains(index)
                      ? 'X'
                      : Player.playerO.contains(index)
                          ? 'O'
                          : ' ',
                  style: TextStyle(
                    color: Player.playerX.contains(index)
                        ? Colors.blue
                        : Colors.pink,
                    fontSize: 52,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SwitchListTile switchListTileAdaptive() {
    return SwitchListTile.adaptive(
        value: isSwitched,
        title: const Text(
          'Turn on/off two Players',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
        onChanged: (bool newValue) {
          setState(() {
            isSwitched = newValue;
          });
        });
  }

  void _onTap(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      game.playGame(index, activePlayer);
      updateState();
      if (!isSwitched && !gameOver&&turn!=9) {
        await game.autoPlay(activePlayer);
        updateState();
      }
    }
  }

  void updateState() async {
    setState(() {
      activePlayer = (activePlayer == 'X') ? 'O' : 'X';
      turn++;
      String winnerPlayer = game.checkWinner();
      if (winnerPlayer != '') {
        gameOver = true;
        result = '$winnerPlayer Is The Winner';

      } else if(!gameOver&& turn == 9){
        result = 'It\'s Draw';
      }
    });
  }
}

class PlayerTurnText extends StatelessWidget {
  const PlayerTurnText({
    super.key,
    required this.activePlayer,
  });

  final String activePlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'it\'s '.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 52,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          '$activePlayer '.toUpperCase(),
          style: const TextStyle(
            color: Colors.orange,
            fontSize: 52,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          ' Turn'.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 52,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
