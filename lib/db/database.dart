import 'dart:async';

import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:floor_example/model/Student.dart';
import 'package:floor_example/db/dao/StudentDao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Student])
abstract class StudentDatabase  extends FloorDatabase {
  StudentDao get studentDao;
}
