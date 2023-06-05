class b4_rotateFirework extends Barrage{
  b4_rotateFirework(float limitTime,float rapidTime,float offset){
     super(limitTime,rapidTime,offset);
  }
     
  void act(){
         
     float rs[] = {100,200,300,400};
     float wayNum = 6;
     
     float center_x = width/2;
     float center_y = height/2;
     
     ArrayList<Bullet> bullets = new ArrayList<Bullet>();
     
     for(int i = 0;i < rs.length;i++){
       for(int j = 0;j < wayNum;j++){
         ArrayList<BulletAction> list = new ArrayList<BulletAction>();
         BulletAction act1 = new BulletAction(MOVE_DC,0.5f);
         act1.destPos_x = center_x + rs[i] * cos(radians( (360.0 / wayNum) * j));
         act1.destPos_y = center_y + rs[i] * sin(radians( (360.0 / wayNum) * j));
         list.add(act1);
         
         for(int k = 0;k < 12;k++){
           BulletAction stop = new BulletAction(GO,0.5f);
           BulletAction rotate = new BulletAction(GO,0.5f);
           
          rotate.center_x = center_x;
          rotate.center_y = center_y;
          
          float t = 0.5f;
          rotate.angular_speed0 = 2 * 45 / t;
          rotate.angular_acc0 = - 2 * 45 / (t * t);
          
          list.add(stop);
          list.add(rotate);
         }
         
         BulletAction spread = new BulletAction(GO,10.0f);
         spread.speed0 = 0;
         spread.sp_angle0 = random(0,360f);
         
         spread.acc0 = 300f;
         
         list.add(spread);
         
         Bullet bullet = new Bullet(center_x,center_y,157.0f,204.0f,224.0f,30.0f,0.0f,list);
         bulletManager.addBullet(bullet);
         
         
         bullets.add(bullet);
       }     
  }
     
     barrageList.add(new ShotAtLine(999.0f,1.0f,1.0f,bullets));
     
  }
}

class ShotAtLine extends Barrage{
   ArrayList<Bullet> bullets;
   ShotAtLine(float limitTime,float rapidTime,float offset,ArrayList<Bullet> bullets){
     super(limitTime,rapidTime,offset);
     this.bullets = bullets;
   }
   
   @Override
   void act(){
      for(int i = 0;i < bullets.size();i++){       
       float x0 = bullets.get(i).x;
       float y0 = bullets.get(i).y;
       
       BulletAction fall = new BulletAction(GO,30.0f);
       
       fall.speed0 = random(400f,600f);
       fall.sp_angle0 = random(210f,330f);
       
       fall.gravity0 = 980f;
       fall.gravity_angle0 = 90;
       
       ArrayList<BulletAction> list = new ArrayList<BulletAction>();
       list.add(fall);
       
       bulletManager.addBullet(new Bullet(x0,y0,255.0f,100,0,30.0f,0.5f,list));
      }
   }
}
