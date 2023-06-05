class Point{
  float x;
  float y;
}


class b3_arrangeSquare extends Barrage{
  
  float center_x;
  float center_y;
  float angle_0;
  
  float r = 200;
  
  Point beg_point;
  Point end_point;
  Point cent_point;

  b3_arrangeSquare(float limitTime,float rapidTime,float offset){
   super(limitTime,rapidTime,offset);
  }
  
  @Override
  void act(){
   // 中心を決める
   center_x = random(width*1.0f/5,width*4.0f/5);
   center_y = random(height*0.5f/5,height*3.0f/5);
   
   //　角度を決める
   angle_0 = random(0.0f,360.0f);
   
   for(int i = 0;i < 4;i++){
     float theta = angle_0 + i * 90;
    
     beg_point = new Point();
     end_point = new Point();
    
     beg_point.x = center_x + r * cos(radians(theta));
     beg_point.y = center_y + r * sin(radians(theta));
     end_point.x = center_x + r * cos(radians(theta + 90));
     end_point.y = center_y + r * sin(radians(theta + 90));
    
     cent_point = new Point();
     cent_point.x = center_x;
     cent_point.y = center_y;
     
     barrageList.add(new lineDraw(0.30f,0.05f,0.0f,beg_point,end_point,cent_point)); 
    
   }
    
   
  }
}



class lineDraw extends Barrage{  
  Point beg_point;
  Point end_point;
  
  // 中心
  Point cent_point;
  
  float sumt;

  // 線を引き始めてからの時間
  float t = 0;
  
  // 始点から終点までのベクトル
  float vec_x; 
  float vec_y;
  
  lineDraw(float limitTime,float rapidTime,float offset,Point beg_point,Point end_point,Point cent_point){
    super(limitTime,rapidTime,offset);
    
    this.sumt = limitTime;
    this.beg_point = beg_point;
    this.end_point = end_point;
    this.vec_x = end_point.x - beg_point.x;
    this.vec_y = end_point.y - beg_point.y;
    this.cent_point = cent_point;
  }
  
  @Override
  void checkActive(){
       super.checkActive();
       t += deltaTime;
  }
  
  // ライン上に弾を打つ
  void act(){
    
    float x;
    float y;
    x = beg_point.x + vec_x * (t/sumt);
    y = beg_point.y + vec_y * (t/sumt);
    
    ArrayList<BulletAction> list = new ArrayList<BulletAction>();
    
    BulletAction act1 = new BulletAction(MOVE_DC,0.8f - t);
    act1.destPos_x = x;
    act1.destPos_y = y;
    
    BulletAction act2 = new BulletAction(GO,0.1f);
    
    BulletAction act3 = new BulletAction(GO,5.0f);
    
    act3.sp_angle0 = 90;
    act3.speed0 = 0;
    act3.gravity0 = 980;
    act3.gravity_angle0 = 90;
    
    
    list.add(act1);
    list.add(act2);
    list.add(act3);
    
    
    Bullet bullet = new Bullet(cent_point.x,cent_point.y,255.0f,0.0f,0.0f,30.0f,0.0f,list);
    bulletManager.addBullet(bullet);
  }
}
