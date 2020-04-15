import 'dart:io' show Platform, File, Directory;
import 'package:path/path.dart' as p;

main() {
  String curDirName = Platform.script.path;
  print(curDirName.indexOf('sso.dart'));
  String path = curDirName.substring(1, curDirName.indexOf('sso.dart'));
  print(p.join(path, 'bbb.txt'));

  File(path).readAsString();
//  File(path).writeAsString('contents');
}
