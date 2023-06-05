class b2_extendSlowly extends Barrage{
  b2_extendSlowly(float limitTime,float rapidTime,float offset){
    super(limitTime,rapidTime,offset);
  }
  
  @Override
  void act(){
    float rand = random(0.0f,360.0f);
     for(int i = 0;i < 12;i++){
      Bullet bullet;
      ArrayList<BulletAction> list = new ArrayList<BulletAction>();
      BulletAction act1 = new BulletAction(GO,2.0f);
      act1.speed0 = 500f;
      act1.sp_angle0 = 180 + i * 30 + rand;
      act1.acc0 = -500f;
      list.add(act1);
  
      BulletAction act2 = new BulletAction(GO,2.0f);
      act2.speed0 = 700f;
      act2.sp_angle0 = 250 + i * 30;
  
      act2.gravity0 = 980f;
      act2.gravity_angle0 = 90 + i * 30;
      list.add(act2);
  
      bullet = new Bullet(width/2.0f,height/2.0f,100.0f,100.0f,100.0f,30.0f,0.0f,list);
      bulletManager.addBullet(bullet);
    }
  }
}
