import 'dart:ui';
import 'package:boxgame/langaw-game.dart';
import 'package:flame/sprite.dart';

class Fly {
  final LangawGame game;
  Rect flyRect;
  //Paint flyPaint;

  bool isDead = false;
  bool isOffScreen = false;

  List flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  double get speed => game.titleSize*3;
  Offset targetLocation;
  
  Fly(this.game){
    //flyRect = Rect.fromLTWH(x, y, game.titleSize, game.titleSize);
    //flyPaint = Paint();
    //flyPaint.color = Color(0xff6ab04c);
    setTargetLocation();
  }
  
  void render(Canvas canvas) {
    //canvas.drawRect(flyRect, flyPaint);
    if (isDead) {
      deadSprite.renderRect(canvas, flyRect.inflate(2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(canvas, flyRect.inflate(2));
    }
  }

  void update(double t) {
    if (isDead) {
      flyRect = flyRect.translate(0, game.titleSize*12*t);
    } else {
      flyingSpriteIndex += 30*t;
      if (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }
      double stepDistance = speed * t;
      Offset toTarget = targetLocation - Offset(flyRect.left,flyRect.top);
      if (stepDistance < toTarget.distance) {
        Offset stepToTarget = Offset.fromDirection(toTarget.direction,stepDistance);
        flyRect = flyRect.shift(stepToTarget);
      } else {
        flyRect = flyRect.shift(toTarget);
        setTargetLocation();
      }
    }
    if (flyRect.top > game.screenSize.height) {
      isOffScreen = true;
    }
  }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() * (game.screenSize.width - (game.titleSize*2.025));
    double y = game.rnd.nextDouble() * (game.screenSize.height - (game.titleSize*2.025));
    targetLocation = Offset(x, y);
  }

  void onTapDown() {
    //flyPaint.color = Color(0xffff4757);
    isDead = true;
    game.spawnFly();
  }
  
}