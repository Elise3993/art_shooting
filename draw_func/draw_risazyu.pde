class Draw_risazyu extends Barrage{
   Draw_risazyu(float l,float r,float o){
     super(l,r,o);
     
     for(int i = 0;i < 8;i++){
       barrageList.add(new Draw_risazyuPart(200,0.02f,0,2*PI*i/8,PI/ random(120,240)));
     }
   }
}

class Draw_risazyuPart extends Barrage{
  float t;
  float d;
  
   Draw_risazyuPart(float l,float r,float o,float initAngle,float delta){
     super(l,r,o);
     
     t = initAngle;    
     d = delta;
   }
   
   void act(){
     ArrayList<BulletAction> list = new ArrayList<BulletAction>();
     BulletAction act1 = new BulletAction(GO,0.5);
    
     BulletAction act2 = new BulletAction(GO,30);
     act2.angular_speed0 = 90;
     
     act2.center_x = width/2;
     act2.center_y = height/2;
     act2.sp_angle0 = degrees(atan2(y(t) - act2.center_y,x(t) - act2.center_x));
     
     act2.acc0 = 500;
     
     
     list.add(act1);
     if(random(0,1) < 1.3){
       list.add(act2);
     }
     
     Bullet bullet = new Bullet(x(t),y(t),255,0,0,10,0,list);
     bulletManager.addBullet(bullet);
     
     t += d;
   }
}

float x(float t){
  return width/2 + 300*cos(5*t);
}

float y(float t){
 return height/2 + 300*sin(4*t+PI/4); 
}
