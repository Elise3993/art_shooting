class Barrage{
  // 微小時間の定義
  float deltaTime = 1/(float)frameRate;
  
  boolean endFlag = false;
  
  // 残り時間
  float leftSurvivalTime;  
  // 連射間隔
  float rapidTime;
  
  // 次のアクションを起こす間での待機時間
  float leftNextActionTime;
  
  // 活性化状態になるまでの待機時間
  float offset;
  
  ArrayList<Barrage> barrageList;
  
  Barrage(float leftSurvivalTime,float rapidTime,float offset){
   this.leftSurvivalTime = leftSurvivalTime;
   this.rapidTime = rapidTime;
   
   this.leftNextActionTime = 0;
   
   this.offset = offset;
   barrageList = new ArrayList<Barrage>();
  }
  
 void checkActive(){ 
   // 待機時間が0の場合
   if(offset <= 0){
     for(int i = barrageList.size() - 1;i >= 0;i--){
      barrageList.get(i).checkActive(); 
     }
     
     for(int i = barrageList.size() - 1;i >= 0;i--){
       Barrage barrage = barrageList.get(i);
       if(barrage.endFlag){
        barrageList.remove(i); 
       }
     }
     
           
     if(leftNextActionTime <= 0){
        leftNextActionTime = rapidTime;
        act();
       }
     
     leftSurvivalTime -= deltaTime;
     leftNextActionTime -= deltaTime;
     
   }
   
   if(isFinished()){
     endFlag = true;
   }

  
       
   offset -= deltaTime;
 }



  // 動きかたの指定
   void act() {};

  // 弾幕の終わりを検知する
  boolean isFinished(){
    
    if(leftSurvivalTime <= 0){
      return true;
    }
    
    return false;
  }
  
}
