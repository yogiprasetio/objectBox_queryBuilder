// ignore_for_file: depend_on_referenced_packages

import 'package:crud_object_box/objectbox.g.dart';
import 'package:path/path.dart' as pt;
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  final Store store;

  ObjectBox._create(this.store);

  static Future<ObjectBox> create() async {
    var dir = await getApplicationDocumentsDirectory();

    Store store =
        await openStore(directory: pt.join(dir.path, 'objectbox_crud'));
    return ObjectBox._create(store);
  }
}
