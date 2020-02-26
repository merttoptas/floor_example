import 'package:floor_example/model/Student.dart';
import 'package:floor/floor.dart';

@dao
abstract class StudentDao {
  @Query('SELECT * FROM student WHERE id = :id')
  Future<Student> findTaskById(int id);

  @Query('SELECT * FROM student')
  Future<List<Student>> findAllTasks();

  @Query('SELECT * FROM student')
  Stream<List<Student>> findAllTasksAsStream();

  @insert
  Future<void> insertStudent(Student student);

  @insert
  Future<void> insertTasks(List<Student> students);

  @update
  Future<void> updateTask(Student student);

  @update
  Future<void> updateTasks(List<Student> student);

  @delete
  Future<void> deleteTask(Student student);

  @delete
  Future<void> deleteTasks(List<Student> students);
}
