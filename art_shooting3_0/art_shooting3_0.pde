BulletManager bulletManager = new BulletManager();
DamageManager damageManager = new DamageManager();
BarrageManager barrageManager = new BarrageManager();

float mouseR = 15;

void setup() {
  size(950, 950);
  frameRate(60);
  
  barrageManager.addBarrage(new b1_extendedCircle(5.0f, 0.5f, 1.0f));
  barrageManager.addBarrage(new b2_extendSlowly(1.51f, 0.6f, 1.0f));
  barrageManager.addBarrage(new b3_arrangeSquare(3.001f, 0.5f, 2.0f));
  barrageManager.addBarrage(new b4_rotateFirework(12.0f, 30.0f, 1.0f));
}

void draw() {
  background(255);
  bulletManager.doBullet();
  barrageManager.doBarrage();
  // スコア表示用のやつ


  // プレイヤーに当たっている弾が在れば
  if (bulletManager.checkBulletCollision((float)mouseX, (float)mouseY, 30)) {
    damageManager.addDamage(1);
  }

  damageManager.displayDamage();
  mouseDraw();
}


void mouseDraw() {
  fill(0);
  ellipse(mouseX, mouseY, mouseR, mouseR);
}

void keyPressed(){
  if(key == 'a') bulletManager.stopAllBullets();
  if(key == 's') bulletManager.fallAllBullets();
}
