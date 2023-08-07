import 'package:dart_mysql/dart_mysql.dart';

// class SQLServerConnection{
//
//   Future<void> connectToSqlServer() async {
//     print("TESTES 1");
//     // final settings = ConnectionSettings(
//     //   host: 'SRVSOL',
//     //   port: 1433, // Porta padrão do SQL Server
//     //   user: 'dcosta',
//     //   password: 'sola8411',
//     //   db: 'SATLANTICO',
//     //   timeout: const Duration(minutes: 2),
//     // );
//     print("TESTES 2");
//     var conn = await SqlConn.connect(ip: "192.168.1.1", port: "1433", databaseName: "SATLANTICO", username: "dcosta", password: "sola8411");
//     //print("TESTES 3");
//     // Faça operações no banco de dados aqui
//
//     final results = await conn.query('SELECT * FROM pe;');
//     print(results.length);
//
//     await conn.close();
//   }
// }

// Future<void> server() async {
//   print("Connecting to mysql server...");
//
//   // create connection
//   final conn = await MySQLConnection.createConnection(
//     host: "192.168.1.1",
//     port: 1433,
//     userName: "dcosta",
//     password: "sola8411",
//     databaseName: "SATLANTICO", // optional
//   ).timeout(const Duration(hours: 2));
//
//   await conn.connect();
//
//   print("Connected");
//
//
//
//   // make query
//   var result = await conn.execute("SELECT * FROM pe");
//
//   // print some result data
//   print(result.numOfColumns);
//   print(result.numOfRows);
//   print(result.lastInsertID);
//   print(result.affectedRows);
//
//
//
//   // close all connections
//   await conn.close();
// }

Future<void> connectToSqlServer() async {
  final ConnectionSettings settings = ConnectionSettings(
    host: '192.168.1.1',
    port: 1433, // Substitua pela porta correta, geralmente é 1433 para SQL Server
    user: 'dcosta',
    password: 'sola8411',
    db: 'SATLANTICO',timeout: const Duration(minutes: 5)
  );
  print("Connecting to sql server...");

  final MySqlConnection conn = await MySqlConnection.connect(settings);

  print("Connected");
  // Agora você pode executar consultas SQL e interagir com o banco de dados

  await conn.close();
}