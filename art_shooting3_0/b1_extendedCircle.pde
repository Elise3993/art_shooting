class b1_extendedCircle extends Barrage{ 
  b1_extendedCircle(float limitTime,float lapidTime,float offset){
   super(limitTime,lapidTime,offset);
   // barrageList.add(new RapidStraight(0.5f));
  } 
  
  float flip = 1;
  void act(){

    float ang0 = random(0f,360f);
    
    float grav_ang = random(0f,360f);
    
     float x = random(3f * width/7.0f,4f* width/7.0f);
      float y = random(3f * height/7.0f,4f * height/7.0f);
    
    for(int i = 0;i < 12;i++){
      Bullet bullet;
      ArrayList<BulletAction> list = new ArrayList<BulletAction>();
      BulletAction act1 = new BulletAction(GO,1.1f);
      act1.sp_angle0 = ang0 + 30 * i;
      act1.acc0 = 500f;
      act1.angular_speed0 = flip * 180;
      list.add(act1);
      
      BulletAction act2 = new BulletAction(GO,10.0f);
      act2.speed0 = 200f;
      act2.sp_angle0 = random(grav_ang -180 - 90f,grav_ang - 180 + 90f);
      act2.gravity0 = 980f;
      act2.gravity_angle0 = grav_ang; 
      list.add(act2);

     

      if(flip == 1) bullet = new Bullet(x,y,0.0f,0.0f,255.0f,30.0f,0.0f,list);
      else  bullet = new Bullet(x,y,0.0f,255.0f,0.0f,30.0f,0.0f,list);
      bulletManager.addBullet(bullet);
    }
    
    flip *= -1;
  } 
}

/*
class RapidStraight extends BarrageElement{
  RapidStraight(float rapidTime){
    super(rapidTime);
  }
  
  void shot(){
    float ang0 = random(0.0f,360.0f);
    
    for(int i = 0;i < 5;i++){
      ArrayList<BulletAction> list = new ArrayList<BulletAction>();
      BulletAction act1 = new BulletAction(GO,10.0f);
      act1.speed0 = 700f;
      act1.sp_angle0 = ang0 + (i - 2) * 45;
      act1.acc0 = -980f;
      list.add(act1);

      bullet = new Bullet(width/3.0f,height/2.0f,255.0f,0.0f,0.0f,30.0f,0.0f,list);
      bulletManager.addBullet(bullet);
    }
    
     ang0 = random(0.0f,360.0f);
     
    for(int i = 0;i < 5;i++){
      ArrayList<BulletAction> list = new ArrayList<BulletAction>();
      BulletAction act1 = new BulletAction(GO,10.0f);
      act1.speed0 = 700f;
      act1.sp_angle0 = ang0 + (i - 2) * 45;
      act1.acc0 = -980f;
      list.add(act1);
      
      bullet = new Bullet(width * 2.0f /3.0f,height/2.0f,255.0f,0.0f,0.0f,30.0f,0.0f,list);
      bulletManager.addBullet(bullet);
    }
  } 
}
*/
