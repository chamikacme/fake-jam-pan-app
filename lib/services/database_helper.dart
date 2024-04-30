import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "fake_jam_pan.db";
  static const _databaseVersion = 1;

  static const table = 'food';
  static const columnId = '_id';
  static const columnName = 'name';
  static const columnPrice = 'price';

  static const ordersTable = 'orders';
  static const ordersColumnId = '_id';
  static const ordersColumnName = 'name';
  static const ordersColumnFoodId = 'food_id';
  static const ordersColumnCount = 'count';
  static const ordersColumnIsIssued = 'isIssued';

  // make this a singleton class

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = await getDatabasesPath();
    return await openDatabase(
      '$path/$_databaseName',
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnPrice REAL NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $ordersTable (
            $ordersColumnId INTEGER PRIMARY KEY,
            $ordersColumnName TEXT NOT NULL,
            $ordersColumnFoodId INTEGER,
            $ordersColumnCount INTEGER NOT NULL,
            $ordersColumnIsIssued BOOLEAN NOT NULL DEFAULT 0,
            FOREIGN KEY($ordersColumnFoodId) REFERENCES $table($columnId) ON DELETE CASCADE
          )
          ''');
  }

  Future<int> insertFood(Map<String, dynamic> food) async {
    Database db = await instance.database;
    return await db.insert(table, food);
  }

  Future<List<Map<String, dynamic>>> getAllFood() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> updateFood(Map<String, dynamic> food) async {
    Database db = await instance.database;
    int id = food[columnId];
    return await db
        .update(table, food, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteFood(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> insertOrder(Map<String, dynamic> order) async {
    Database db = await instance.database;
    return await db.insert(ordersTable, order);
  }

  Future<List<Map<String, dynamic>>> getAllOrders() async {
    Database db = await instance.database;
    return await db.query(ordersTable);
  }

  Future<List<Map<String, dynamic>>> getRecentOrders() async {
    Database db = await instance.database;
    return await db.query(ordersTable,
        orderBy: '$ordersColumnId DESC', limit: 5);
  }

  Future<int> issueOrder(int id, int value) async {
    Database db = await instance.database;
    return await db.update(ordersTable, {ordersColumnIsIssued: value},
        where: '$ordersColumnId = ?', whereArgs: [id]);
  }

  Future<int> deleteOrder(int id) async {
    Database db = await instance.database;
    return await db
        .delete(ordersTable, where: '$ordersColumnId = ?', whereArgs: [id]);
  }

  Future<int> resetCounts() async {
    Database db = await instance.database;
    return await db.delete(ordersTable);
  }

  Future<List<Map<String, dynamic>>> getFoodCounts() async {
    Database db = await instance.database;
    return await db.rawQuery('''
      SELECT $table.$columnName, $table.$columnPrice, SUM($ordersTable.$ordersColumnCount) as count
      FROM $table
      LEFT JOIN $ordersTable
      ON $table.$columnId = $ordersTable.$ordersColumnFoodId
      GROUP BY $table.$columnId
    ''');
  }
}
