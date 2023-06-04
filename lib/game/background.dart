import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:mario_game/game/car_race.dart';

class BackGround extends ParallaxComponent<CarRace> {
  double backgroundSpeed = 2; // Initial speed value
  @override
  FutureOr<void> onLoad() async {
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('game/road1.png'),
        ParallaxImageData('game/road1.png'),
      ],
      fill: LayerFill.width,
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(0, -70 * backgroundSpeed.toDouble()),
      velocityMultiplierDelta: Vector2(0, 1.2 * backgroundSpeed),
    );
  }
}
