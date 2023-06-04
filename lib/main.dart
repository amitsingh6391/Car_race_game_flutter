import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mario_game/game/car_race.dart';
import 'package:mario_game/game/utils/color_theme.dart';
import 'package:mario_game/game/widgets/game_over_overlay.dart';
import 'package:mario_game/game/widgets/game_overlay.dart';
import 'package:mario_game/game/widgets/main_menu_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Race',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        textTheme: GoogleFonts.audiowideTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
      ),
      home: const CarRaceHomePage(),
    );
  }
}

final Game game = CarRace();

class CarRaceHomePage extends StatelessWidget {
  const CarRaceHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            constraints: const BoxConstraints(
              maxWidth: 800,
              minWidth: 550,
            ),
            child: GameWidget(
              game: game,
              overlayBuilderMap: <String, Widget Function(BuildContext, Game)>{
                'gameOverlay': (context, game) => GameOverlay(game),
                'mainMenuOverlay': (context, game) => MainMenuOverlay(game),
                'gameOverOverlay': (context, game) => GameOverOverlay(game),
              },
            ),
          );
        }),
      ),
    );
  }
}
