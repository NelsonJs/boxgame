import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:boxgame/components/fly.dart';
import 'package:boxgame/langaw-game.dart';

class DroolerFly extends Fly {
  double get speed => game.titleSize * 1.5;
  DroolerFly(LangawGame game, double x, double y) : super(game){

    flyingSprite = List();
    flyingSprite.add(Sprite('flies/drooler-fly-1.png'));
    flyingSprite.add(Sprite('flies/drooler-fly-2.png'));
    deadSprite = Sprite('flies/drooler-fly-dead.png');
    flyRect = Rect.fromLTWH(x,y,game.titleSize,game.titleSize);
  }

}