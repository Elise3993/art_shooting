class DamageManager{
  int damage = 0;
   
  void resetDamage(){
   damage = 0; 
  }
  
  void addDamage(int x){
    damage += x;
  }
  
  void displayDamage(){
    textSize(30);
    fill(0);
    text("Damage : " + damage,50,50);
  }
}
