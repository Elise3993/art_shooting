class BarrageManager {
  int listInd = 0;
  ArrayList<Barrage> barrages;

  BarrageManager() {
    listInd = 0;
    this.barrages = new ArrayList<Barrage>();
  }

  // 新しい弾幕を追加する
  void addBarrage(Barrage barrage) {
    barrages.add(barrage);
  }

  // 全ての弾幕を消す
  void init() {
    listInd = 0;
    barrages.clear();
  }

  // 現在の弾幕を動作させる
  void doBarrage() {
    if (listInd < barrages.size()) {
      barrages.get(listInd).checkActive();
    }

    if (isFinishedBarrage()) {
      shiftNextBarrage();
    }
  }

  // 弾幕の終わりを検知する
  boolean isFinishedBarrage() {
    if (listInd >= barrages.size()) return false;

    if (barrages.get(listInd).endFlag) {
      return true;
    }

    return false;
  }

  // 次の弾幕に以降する
  void shiftNextBarrage() {
    listInd++;
  }
}
