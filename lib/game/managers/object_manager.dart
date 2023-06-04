import 'dart:math';

import 'package:flame/components.dart';
import 'package:mario_game/game/managers/game_manager.dart';
import 'package:mario_game/game/car_race.dart';
import 'package:mario_game/game/sprites/competitor.dart';

final Random _rand = Random();

class ObjectManager extends Component with HasGameRef<CarRace> {
  ObjectManager();

  @override
  void onMount() {
    super.onMount();

    addEnemy(1);
    _maybeAddEnemy();
  }

  @override
  void update(double dt) {
    if (gameRef.gameManager.state == GameState.playing) {
      gameRef.gameManager.increaseScore();
    }

    addEnemy(1);

    super.update(dt);
  }

  final Map<String, bool> specialPlatforms = {
    'enemy': false,
  };

  void enableSpecialty(String specialty) {
    specialPlatforms[specialty] = true;
  }

  void addEnemy(int level) {
    switch (level) {
      case 1:
        enableSpecialty('enemy');
    }
  }

  final List<EnemyPlatform> _enemies = [];
  void _maybeAddEnemy() {
    if (specialPlatforms['enemy'] != true) {
      return;
    }

    var currentX = (gameRef.size.x.floor() / 2).toDouble() - 50;

    var currentY =
        gameRef.size.y - (_rand.nextInt(gameRef.size.y.floor()) / 3) - 50;
    var enemy = EnemyPlatform(
      position: Vector2(
        currentX,
        currentY,
      ),
    );
    add(enemy);
    _enemies.add(enemy);
    _cleanupEnemies();
  }

  void _cleanupEnemies() {
    Future.delayed(
      const Duration(seconds: 4),
      () {
        _enemies.clear();
        Future.delayed(
          const Duration(seconds: 1),
          () {
            _maybeAddEnemy();
          },
        );
      },
    );
  }
}
