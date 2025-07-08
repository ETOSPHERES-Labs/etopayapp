@JS()
library;

import 'dart:js_util';
import 'package:js/js.dart';

@JS('etopayInit')
external Object etopayInit();

@JS('ETOPaySdk')
class ETOPaySdk {
  external factory ETOPaySdk();

  external Object setConfig(String configJson);
  external Object createNewUser(String username);
  external Object initializeUser(String username);
  external Object refreshAccessToken(String token);
  external Object getNetworks();
  external Object setNetwork(String networkKey);
}

@JS()
@anonymous
class Promise {
  external Promise then(Function onFulfilled, [Function? onRejected]);
}
