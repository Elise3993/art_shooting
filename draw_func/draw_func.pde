BulletManager bulletManager = new BulletManager();
BarrageManager barrageManager = new BarrageManager();

void setup() {
  size(950, 950);
  frameRate(50);
  
  barrageManager.addBarrage(new Draw_risazyu(1000,100,1));


}

void draw() {
  background(255);
  bulletManager.doBullet();
  barrageManager.doBarrage();
}
