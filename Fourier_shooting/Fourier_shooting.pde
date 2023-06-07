BulletManager bulletManager = new BulletManager();
BarrageManager barrageManager = new BarrageManager();

void setup() {
  size(950, 950);
  frameRate(50);
  
  barrageManager.addBarrage(new Fourier(1.0f,3.0f,2.0f));
}

void draw() {
  background(255);
  bulletManager.doBullet();
  barrageManager.doBarrage();
}
