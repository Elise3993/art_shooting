final int GO = 0;
final int MOVE_CS = 1;
final int MOVE_DC = 2;
final int STOP = 3;

class Bullet {
  // 現在の行動パターンの添え字
  int moveind = -1;

  // 画面外判定のゆとり
  float overWidth = 200;

  // 破壊するフラグ
  boolean destroyFlag = false;
  boolean isActive = true;

  // 初期位置
  float x0;
  float y0;

  // 現在位置
  float x;
  float y;

  // 色
  float R;
  float G;
  float B;

  // 弾の半径
  float bulletRadius;

  // 円の中心
  float x_center;
  float y_center;

  // スピード、加速度
  float speed;
  float acc;

  // スピードと加速度の角度
  float sp_angle;

  // 重力加速度とその方向
  float gravity;
  float gravity_angle;

  // 角速度、角加速度
  float angular_speed;
  float angular_acc;

  // 現在の行動パターンの残り時間
  float limitTime;

  // 行動パターンのリスト
  ArrayList<BulletAction> actionList;

  // コンストラクタ
  Bullet(float x, float y, float R, float G, float B, float radius, float offset, ArrayList<BulletAction> actionList) {
    // 発生位置、見た目、発生するまでの時間を決定する
    this.x0 = x;
    this.y0 = y;

    this.x = x;
    this.y = y;
    this.R = R;
    this.G = G;
    this.B = B;
    this.bulletRadius = radius;
    this.limitTime = offset;
    this.actionList = actionList;

    this.moveind = -1;
  }

  // 行動予定を初期化する
  void moveReset(float offset) {
    moveind = -1;
    speed = 0;
    acc = 0;

    sp_angle = 0;

    gravity = 0;
    gravity_angle = 0;

    angular_speed = 0;
    angular_acc = 0;
    this.limitTime = offset;
  }

  // 新しい行動予定を追加する
  void addAction(BulletAction act) {
    actionList.add(act);
  }

  // 動作のステータスをセットする
  void setupMove() {
    // 移動する前だったら
    if (moveind == -1) {
      return;
    }

    // 行動リストがすでにおわったら
    if (moveind >= actionList.size()) {
      destroyFlag = true;
      return;
    }

    // もし行動を行う場合
    // 各移動パターンに分けて移動をsetupする
    BulletAction act = actionList.get(moveind);

    // 移動時間を設定
    limitTime = act.moveTime;

    // 設定したステータスの通りに移動する場合
    if (act.movePattern == GO) {
      // 半径を初期出現位置に設定
      if (act.center_x < 0) {
        x_center = x;
        y_center = y;
      } else {
        x_center = act.center_x;
        y_center = act.center_y;
      }

      speed = act.speed0;
      acc = act.acc0;

      sp_angle = act.sp_angle0;

      gravity = act.gravity0;
      gravity_angle = act.gravity_angle0;

      angular_speed = act.angular_speed0;
      angular_acc = act.angular_acc0;
    }

    if (act.movePattern ==  MOVE_CS)
    {
      float dx = (act.destPos_x - x) ;
      float dy = (act.destPos_y - y) ;

      float dist = sqrt(dx * dx + dy * dy);

      speed = dist / limitTime;
      acc = 0;
      sp_angle = degrees(atan2(dy, dx));

      gravity = 0;
      gravity_angle = 0;

      angular_speed = 0;
      angular_acc = 0;
    }



    // 減速移動(目的地にて速度が0となる)(加速 acc は):
    if (act.movePattern == MOVE_DC)
    {
      float dx = (act.destPos_x - x) ;
      float dy = (act.destPos_y - y) ;

      float dist = sqrt(dx * dx + dy * dy);
      speed = 2 * dist / limitTime;
      acc = - 2 * dist / (limitTime * limitTime);
      sp_angle = degrees(atan2(dy, dx));

      gravity = 0;
      gravity_angle = 0;

      angular_speed = 0;
      angular_acc = 0;
    }

    // ストップさせる場合
    if (act.movePattern == STOP) {
      speed = 0;
      acc = 0;

      sp_angle = 0;

      gravity = 0;
      gravity_angle = 0;

      angular_speed = 0;
      angular_acc = 0;
    }
  }

  // 実際に動かす
  void move() {
    // 1フレームにかかる秒数を計算
    float deltaTime = 1 / (float)frameRate;

    // 角速度より角変位量を計算
    float dthe = angular_speed * deltaTime;
    float the = degrees(atan2(y - y_center, x - x_center));

    float radius = sqrt( (x - x_center)*(x - x_center) + (y - y_center)*(y - y_center) );

    // 回転移動を反映
    the += dthe;
    x = x_center + radius * cos(radians(the));
    y = y_center + radius * sin(radians(the));

    // 回転方向に合わせて速度方向も回転させる
    sp_angle += dthe;

    // 速度をx,y成分に分けて計算
    float vx = speed * cos(radians(sp_angle));
    float vy = speed * sin(radians(sp_angle));

    // 速度と角度から変位量を計算
    float dx = vx * deltaTime;
    float dy = vy * deltaTime;

    // 変位を反映させる
    x += dx;
    y += dy;

    // 加速度による速度の更新
    float dvx = acc * deltaTime * cos(radians(sp_angle));
    float dvy = acc * deltaTime * sin(radians(sp_angle));

    vx += acc * deltaTime * cos(radians(sp_angle));
    vy += acc * deltaTime * sin(radians(sp_angle));

    // 符号が変わった場合
    if (vx*(vx - dvx) < 0 && vy*(vy - dvy) < 0) {
      // 加速度を反転
      acc = -acc;
    }

    // 重力による速度の更新
    vx += gravity * deltaTime * cos(radians(gravity_angle));
    vy += gravity * deltaTime * sin(radians(gravity_angle));

    // 速度の向き、大きさの再計算
    speed = sqrt(vx * vx + vy * vy);
    sp_angle = degrees(atan2(vy, vx));

    // 角加速度による角速度の更新
    angular_speed += angular_acc * deltaTime;

    // 生存時間を減少させる
    limitTime -= deltaTime;

    // もし生存時間が過ぎていたなら
    if (isTimeLimit()) {
      moveind++;
      resetStatus();
      setupMove();
    }

    // もし範囲外なら
    if (isOutOfRangeBullet()) {
      destroyFlag = true;
    }

    return;
  }

  // 弾を表示する
  void display() {
    fill(R, G, B);
    stroke(0);
    strokeWeight(3);

    ellipse(x, y, bulletRadius, bulletRadius);
  }

  // 現在の動作ステータスを全てリセットする
  void resetStatus() {
    x_center = 0;
    y_center = 0;

    speed = 0;
    acc = 0;

    sp_angle = 0;

    angular_speed = 0;
    angular_acc = 0;

    gravity = 0;
    gravity_angle = 0;

    limitTime = 0;
  }

  // 弾としての生存時間が終わったかどうか判定する
  boolean isTimeLimit() {
    if (limitTime <= 0) return true;
    else return false;
  }

  // 弾が画面外であるかどうか判定
  boolean isOutOfRangeBullet() {
    if (x < -overWidth || y < -overWidth || width  +  overWidth < x || height + overWidth < y) return true;
    return false;
  }


  // debug用
  void printStatus() {
    println("x_center", x_center);
    println("y_center", y_center);

    println("speed", speed);
    println("sp_angle", sp_angle);
    println();
  }
}
