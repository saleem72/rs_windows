//

import 'dart:ffi';

abstract class DashboardService {
  Future<Bool> getData();
}

class DashboardServiceMock implements DashboardService {
  @override
  Future<Bool> getData() async {
    final temp = await Future<void>.delayed(const Duration(seconds: 1));
    return Future.value(true);
  }
}
