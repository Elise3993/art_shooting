class BulletAction{
  BulletAction(int movePattern,float moveTime){
   this.movePattern = movePattern;
   this.moveTime = moveTime;
  }
  
  int movePattern; 
  float moveTime;
  
  float speed0 = 0;
  float sp_angle0 = 0;
  
  float gravity0 = 0;
  float gravity_angle0 = 0;
  
  float acc0 = 0;
   
  float angular_speed0 = 0;
  float angular_acc0 = 0;
  
  float destPos_x;
  float destPos_y;
  
  float center_x = -1;
  float center_y = -1;
}
