import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

Future<void> initializeBack4App() async {
  const keyApplicationId = 'efP7EJIEt7ISH5Lpc9yOgJ2CUcwF67gdVKKG6HSI'; // 'your-app-id'
  const keyClientKey = 'W23oxUh6POjPtnwI6X3zNTSUD0yrANxbymEBkRX8'; // 'your-client-key'
  const keyParseServerUrl = 'https://parseapi.back4app.com/';

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    debug: true,
  );

  print('Parse is now connected!');
  //var firstObject = ParseObject('FirstClass')
  //  ..set(
  //      'message', 'Hey, Parse is now connected!🙂');
  //await firstObject.save();
  //print('Parse is now connected');
  /*await Parse().initialize(keyApplicationId, keyParseServerUrl,
            clientKey: keyClientKey, debug: true);
   }*/
}


