import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:boxgame/components/fly.dart';
import 'package:boxgame/langaw-game.dart';

class AgileFly extends Fly {
  AgileFly(LangawGame game, double x, double y) : super(game){
    flyingSprite = List();
    flyingSprite.add(Sprite('flies/agile-fly-1.png'));
    flyingSprite.add(Sprite('flies/agile-fly-2.png'));
    deadSprite = Sprite('flies/agile-fly-dead.png');
    flyRect = Rect.fromLTWH(x,y,game.titleSize,game.titleSize);
  }

}