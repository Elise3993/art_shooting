class BulletManager{
  // 画面上に存在する弾を全て管理する
  ArrayList<Bullet> bullets;
  
  BulletManager(){
    bullets = new ArrayList<Bullet>();
  }
  
  // 全ての弾を消す
  void destoryAllBullet(){
    bullets.clear();
  }
  
  // 全ての弾を動作させる
  void doBullet(){
    for(int i = 0;i <bullets.size();i++){
     Bullet bullet = bullets.get(i);
     bullet.move();
     if(bullet.isActive && bullet.moveind != -1) bullet.display();
    }
    
    for(int i = bullets.size() - 1;i >= 0;i--){
      Bullet bullet = bullets.get(i);
      if(bullet.destroyFlag){
       bullets.remove(i); 
      }
    }
  }
  
  // 弾を追加する
  void addBullet(Bullet bullet){
    bullets.add(bullet);
  }
  
  // 弾がある点を中心にしている半径rの点と衝突しているか調べる
  boolean checkBulletCollision(float x,float y,float r){
    boolean res = false;
    for(int i = 0;i < bullets.size();i++){
      float bul_x = bullets.get(i).x;
      float bul_y = bullets.get(i).y;
      float d = sqrt( (bul_x - x)*(bul_x - x)+(bul_y - y)*(bul_y - y) );
      if(d < r){
        res = true;
      }
    }
    
    return res;
  }
  
  
}
