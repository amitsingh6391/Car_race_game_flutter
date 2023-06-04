// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:mario_game/game/background.dart';
import 'package:mario_game/game/managers/game_manager.dart';
import 'package:mario_game/game/managers/object_manager.dart';
import 'package:mario_game/game/sprites/competitor.dart';
import 'package:mario_game/game/sprites/player.dart';

enum Character {
  bmw,
  farari,
  lambo,
  tarzen,
  tata,
  tesla,
}

class CarRace extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  CarRace({
    super.children,
  });

  final BackGround _backGround = BackGround();
  final GameManager gameManager = GameManager();
  ObjectManager objectManager = ObjectManager();
  int screenBufferSpace = 300;

  EnemyPlatform platFrom = EnemyPlatform();

  late Player player;

  late AudioPool pool;
  @override
  FutureOr<void> onLoad() async {
    await add(_backGround);
    await add(gameManager);
    overlays.add('gameOverlay');
    pool = await FlameAudio.createPool(
      'audi_sound.mp3',
      minPlayers: 3,
      maxPlayers: 4,
    );
  }

  void startBgmMusic() {
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('audi_sound.mp3', volume: 1);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameManager.isGameOver) {
      return;
    }
    if (gameManager.isIntro) {
      overlays.add('mainMenuOverlay');
      return;
    }
    if (gameManager.isPlaying) {
      final Rect worldBounds = Rect.fromLTRB(
        0,
        camera.position.y - screenBufferSpace,
        camera.gameSize.x,
        camera.position.y + _backGround.size.y,
      );
      camera.worldBounds = worldBounds;
    }
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 241, 247, 249);
  }

  void setCharacter() {
    player = Player(
      character: gameManager.character,
      moveLeftRightSpeed: 600,
    );
    add(player);
  }

  void initializeGameStart() {
    setCharacter();

    gameManager.reset();

    if (children.contains(objectManager)) objectManager.removeFromParent();

    player.reset();
    camera.worldBounds = Rect.fromLTRB(
      0,
      -_backGround
          .size.y, // top of screen is 0, so negative is already off screen
      camera.gameSize.x,
      _backGround.size.y +
          screenBufferSpace, // makes sure bottom bound of game is below bottom of screen
    );
    camera.followComponent(player);

    player.resetPosition();

    objectManager = ObjectManager();

    add(objectManager);
    startBgmMusic();
  }

  void onLose() {
    gameManager.state = GameState.gameOver;
    player.removeFromParent();
    FlameAudio.bgm.stop();
    overlays.add('gameOverOverlay');
  }

  void togglePauseState() {
    if (paused) {
      resumeEngine();
    } else {
      pauseEngine();
    }
  }

  void resetGame() {
    startGame();
    overlays.remove('gameOverOverlay');
  }

  void startGame() {
    initializeGameStart();
    gameManager.state = GameState.playing;
    overlays.remove('mainMenuOverlay');
  }
}
