class Fourier extends Barrage {
  float sep = 285;

  Fourier(float leftSurvivalTime, float rapidTime, float offset) {
    super(leftSurvivalTime, rapidTime, offset);
  }

  void act() {
    for (int i = 0; i < sep; i++) {
      float t = (float)width * i / sep;

      Bullet center;
      ArrayList<BulletAction> list = new ArrayList<BulletAction>();
      BulletAction act0 = new BulletAction(GO, 2.5f);

      BulletAction act1 = new BulletAction(MOVE_DC, 0.3);
      act1.destPos_x = t;
      act1.destPos_y = f1(t) + f2(t) + height / 2;

      BulletAction act2 = new BulletAction(GO, 2.5f);

      BulletAction act3 = new BulletAction(MOVE_DC,0.3);
      act3.destPos_x = t;
      act3.destPos_y = f1(t) + height / 2;
      
      BulletAction act4 = new BulletAction(GO, 10);
      
      list.add(act0);
      list.add(act1);
      list.add(act2);
      list.add(act3);
      list.add(act4);
      
      center = new Bullet(t,f1(t) + f2(t) + f3(t) + height / 2,255,0,0,10,i * (float)1 / frameRate,list);
      
      bulletManager.addBullet(center);
      
      Bullet lower;
      ArrayList<BulletAction> list2 = new ArrayList<BulletAction>();
      
      act0 = new BulletAction(MOVE_DC,0.3);
      act0.destPos_x = t;
      act0.destPos_y = f3(t) + (float)height * 5 / 6;
      
      act1 = new BulletAction(GO,10);
      
      list2.add(act0);
      list2.add(act1);
      
      lower = new Bullet(t,f1(t) + f2(t) + f3(t) + height / 2,0,255,0,10,i * (float)1 / frameRate + 2.5f,list2);

      bulletManager.addBullet(lower);
      
      Bullet upper;
      ArrayList<BulletAction> list3 = new ArrayList<BulletAction>();
      
      act0 = new BulletAction(MOVE_DC,0.3);
      act0.destPos_x = t;
      act0.destPos_y = f2(t) + (float)height / 6;
      
      act1 = new BulletAction(GO,10);
      
      list3.add(act0);
      list3.add(act1);

      upper = new Bullet(t,f1(t) + f2(t) + (float)height / 2,0,0,255,10,i * (float)1 / frameRate + 5.3f,list3);
      
      bulletManager.addBullet(upper);
    }
  }
}


float f1(float t) {
  t /= 100;
  return 140 * sin(3 * PI * t / 2 + 3 * PI / 4);
}

float f2(float t) {
  t /= 100;
  return 120 * sin(PI * t + PI / 2);
}

float f3(float t) {
  t /= 100;
  return 70 * sin(2 * PI * t);
}
