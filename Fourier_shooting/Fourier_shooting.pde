BulletManager bulletManager = new BulletManager();
BarrageManager barrageManager = new BarrageManager();

void setup() {
  size(950, 950);
  frameRate(20000);
  
  barrageManager.addBarrage(new Fourier(1.0f,3.0f,36.0f));
}

void draw() {
  background(255);
  bulletManager.doBullet();
  barrageManager.doBarrage();
}
