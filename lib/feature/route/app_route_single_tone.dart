class AppRouteSingleTone {
  static final AppRouteSingleTone appRouteSingleTone =
      AppRouteSingleTone._internal();

  bool isShowBottomBarMyAddressesPage = false;
  bool isShowBottomBarEditAddressPage = false;
  bool isMoveBottomPadding = false;
  double showValue = 1;

  factory AppRouteSingleTone() => appRouteSingleTone;

  void showBottomNavigationBar(double value) {
    showValue = value;
    if (isShowBottomBarMyAddressesPage) {
      showValue = 0;
    }
    if (isShowBottomBarEditAddressPage) {
      showValue = 0;
    }
  }

  AppRouteSingleTone._internal();
}

final appRouteSingleTone = AppRouteSingleTone();
