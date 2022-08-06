class MyColors {
  int color1 = 158;
  int color2 = 158;
  int color3 = 158;

  List<int> cc = [1, 38, 7, 9, 40, 6, 55];

  // mycolor1(){
  //   cc.shuffle();
  //   i +=cc[0];
  //   color1=i;
  // }

  //  mycolor2(){
  //   cc.shuffle();
  //   i +=cc[0];
  //   color2=i;
  // }

  //  mycolor3(){
  //   cc.shuffle();
  //   i +=cc[0];
  //   color3=i;
  // }

  shufflemycolors() {
    cc.shuffle();

    if (color1 > 255) {
      color1 = 0;
    } else {
      color1 += cc[0];
    }

    cc.shuffle();

    if (color2 > 255) {
      color2 = 0;
    } else {
      color2 += cc[0];
    }

    cc.shuffle();

    if (color3 > 255) {
      color3 = 0;
    } else {
      color3 += cc[0];
    }
  }
}
