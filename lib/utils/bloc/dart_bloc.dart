import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';

class DartBloc extends BlocBase {
  //累计数据量选点
  PublishSubject<String> _sumDemandController = PublishSubject();

  Observable<String> get sumDemandStream => Observable(_sumDemandController.stream);

  void changeSumDemand(String curDate) {
    _sumDemandController.add(curDate);
  }

  //累计交易金额选点
  PublishSubject<String> _sumPriceController = PublishSubject();

  Observable<String> get sumPriceStream => Observable(_sumPriceController.stream);

  void changeSumPrice(String curDate) {
    _sumPriceController.add(curDate);
  }

  PublishSubject<bool> _deleteMessageController = PublishSubject();

  Observable<bool> get deleteMessageStream => Observable(_deleteMessageController.stream);

  void isDelete(bool isDelete) {
    _deleteMessageController.add(isDelete);
  }

  @override
  void dispose() {
    _sumDemandController.close();
    _sumPriceController.close();
    _deleteMessageController.close();
  }
}
