

import 'package:boxgame/langaw-game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';

class Backyard {
  final LangawGame game;
  Sprite bgSprite;
  Rect bgRect;

  Backyard(this.game) {
    bgSprite = Sprite("bg/backyard.png");
    bgRect = Rect.fromLTWH(0, game.screenSize.height-(game.titleSize*23), game.titleSize*9, game.titleSize*23);
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void update(Canvas c) {

  }

}