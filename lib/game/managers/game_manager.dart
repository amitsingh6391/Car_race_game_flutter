import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:mario_game/game/car_race.dart';

class GameManager extends Component with HasGameRef<CarRace> {
  GameManager();

  Character character = Character.tesla;
  ValueNotifier<int> score = ValueNotifier(0);

  GameState state = GameState.intro;

  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;
  bool get isIntro => state == GameState.intro;
  void reset() {
    score.value = 0;
    state = GameState.intro;
  }

  void increaseScore() {
    score.value++;
  }

  void selectCharacter(Character selectedCharcter) {
    character = selectedCharcter;
  }
}

enum GameState { intro, playing, gameOver }
