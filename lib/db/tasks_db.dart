import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/models/task.dart';

class TasksDB{
  static final TasksDB instance=TasksDB._init();
  static Database? _database;

  TasksDB._init();

  Future get database async{
    if(_database!=null)   return _database;
    
    _database=await _initDB('tasks.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath=await getDatabasesPath();
    final path=join(dbPath,filePath);

    return await openDatabase(path,version: 1,onCreate: _createDB);
  }

  Future _createDB(Database db,int version) async{
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType='BOOLEAN';
    final textType='TEXT';

    await db.execute(
      '''
        CREATE TABLE $tableTasks(
          ${TaskFields.id} $idType,
          ${TaskFields.taskTitle} $textType,
          ${TaskFields.taskDescription} $textType,
          ${TaskFields.time} $textType,
          ${TaskFields.isDone} $boolType,
          ${TaskFields.isBookmarked} $boolType
        )
      '''
    );
  }

  Future<Task> create(Task task)async{
    final db= await instance.database;
    final id=await db.insert(tableTasks,task.toJson());
    return task.copy(id: id);
    
  }
  Future<Task> readTask(int id) async{
    final db=await instance.database;
    final maps=await db.query(
      tableTasks,
      columns: TaskFields.values,
      where: '${TaskFields.id}=?',
      whereArgs: [id],
    );
    if(maps.isNotEmpty){
      return Task.fromJson(maps.first);
    }else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Task>?> readTasks() async{
    try{
      final db=await instance.database;
      final orderBy='${TaskFields.time} ASC';
      final result = await  db.query(
        tableTasks, 
        where: '${TaskFields.isDone} = 0',
        orderBy: orderBy
      );
      
      // return result.map((json) => Task.fromJson(json)).toList();

      // print('result= $result');
      // final parsed = jsonDecode(result.toString());
      
      return  result.map<Task>((json)=>
        Task.fromJson(json)
      ).toList();
    }catch(e){
      print('Exception while reading task: $e');
      
    }
  }

  Future<List<Task>?> getBookmarkedTasks() async {
    try {
      final db = await instance.database;
      final orderBy = '${TaskFields.time} ASC';
      final result = await db.query(
        tableTasks, 
        where: '${TaskFields.isBookmarked} = 1 AND ${TaskFields.isDone} = 0',        
        orderBy: orderBy,        
      );

      return result.map<Task>((json) => Task.fromJson(json)).toList();
    } catch (e) {
      print('Exception while reading task: $e');
    }
  }
  Future<List<Task>?> getTasksAllDone() async {
    try {
      final db = await instance.database;
      final orderBy = '${TaskFields.time} ASC';
      final result = await db.query(
        tableTasks,
        where: '${TaskFields.isDone} = 1',
        orderBy: orderBy,
      );

      return result.map<Task>((json) => Task.fromJson(json)).toList();
    } catch (e) {
      print('Exception while reading task: $e');
    }
  }

  Future<int> update(Task task) async{
    final db=await instance.database;
    print(task.taskTitle);
    print(task.toJson());
    return await  db.update(
      tableTasks,
      task.toJson(),
      where: '${TaskFields.id} = ?',
      whereArgs: [task.id],
    );
  }

  Future<int?> delete(int? id) async {
    try{
      final db = await instance.database;

      return await  db.delete(
        tableTasks,
        where: '${TaskFields.id} = ?',
        whereArgs: [id],
      );
    }catch(e){
      print('Exception while reading task: $e');    
    }
  }

  Future close() async{
    final db=await instance.database;
    db.close();
  }
}