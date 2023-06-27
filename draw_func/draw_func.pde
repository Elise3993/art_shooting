import gifAnimation.*;

GifMaker gifExport;


BulletManager bulletManager = new BulletManager();
BarrageManager barrageManager = new BarrageManager();

void setup() {
  size(950, 950);
  frameRate(50);
  
  barrageManager.addBarrage(new Draw_risazyu(1000,100,0));


// GIFアニメ出力の設定
  gifExport = new GifMaker(this, "disappear.gif"); // GifMakerオブジェクトを作る、第2引数にファイル名
  gifExport.setRepeat(0); // エンドレス再生
  gifExport.setQuality(10); // クオリティ(デフォルト10)
  gifExport.setDelay(20); // アニメーションの間隔を20ms(50fps)に
}

void draw() {
  background(255);
  bulletManager.doBullet();
  barrageManager.doBarrage();
  
  if(frameCount <= 50*12){
    gifExport.addFrame(); // フレームを追加
  } else {
    gifExport.finish(); // 終了してファイル保存
  }
}
