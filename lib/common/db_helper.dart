import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class DatabaseHelper {
  static const _databaseName = "products.db";
  static const _databaseVersion = 1;

  static const table = 'products';
  static const columnId = '_id';
  static const columnName = 'name';
  static const columnPrice = 'price';

  // Private constructor
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // Getter for accessing the database instance
  Future<Database> get database async {
    // If the database instance is already created, return it
    if (_database != null) return _database!;
    
    // Otherwise, initialize the database
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    try {
      // Get the path for storing the database file
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, _databaseName);
      
      // Open the database
      return await openDatabase(path,
          version: _databaseVersion, onCreate: _onCreate);
    } catch (e) {
      // Handle initialization errors
      print('Error initializing database: $e');
      throw DatabaseException('Error initializing database: $e');
    }
  }

  // Create the database schema if it doesn't exist
  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE $table (
          $columnId INTEGER PRIMARY KEY,
          $columnName TEXT NOT NULL,
          $columnPrice TEXT NOT NULL
        )
      ''');
    } catch (e) {
      // Handle schema creation errors
      print('Error creating database schema: $e');
      throw DatabaseException('Error creating database schema: $e');
    }
  }

  // Insert a product into the database
  Future<int> insertProduct(Pproduct product) async {
    try {
      Database db = await database;
      int id = await db.insert(table, product.toMap());
      print('Inserted product with ID: $id');
      return id;
    } catch (e) {
      // Handle insertion errors
      print('Error inserting product: $e');
      throw DatabaseException('Error inserting product: $e');
    }
  }

  // Query all products from the database
  Future<List<Pproduct>> queryAllProducts() async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> maps = await db.query(table);
      return List.generate(maps.length, (i) {
        return Pproduct(
          id: maps[i][columnId],
          name: maps[i][columnName],
          price: maps[i][columnPrice],
        );
      });
    } catch (e) {
      // Handle query errors
      print('Error querying products: $e');
      throw DatabaseException('Error querying products: $e');
    }
  }
}

// Product class
class Pproduct {
  final int? id;
  final String name;
  final String price;

  Pproduct({this.id, required this.name, required this.price});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }
}

// Custom exception class for database errors
class DatabaseException implements Exception {
  final String message;
  
  DatabaseException(this.message);

  @override
  String toString() {
    return 'DatabaseException: $message';
  }
}
