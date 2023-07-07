import 'package:mysql1/mysql1.dart';
import 'package:sql_conn/sql_conn.dart';

class SQLServerConnection{

  Future<void> connectToSqlServer() async {
    print("TESTES 1");
    // final settings = ConnectionSettings(
    //   host: 'SRVSOL',
    //   port: 1433, // Porta padrão do SQL Server
    //   user: 'dcosta',
    //   password: 'sola8411',
    //   db: 'SATLANTICO',
    //   timeout: const Duration(minutes: 2),
    // );
    print("TESTES 2");
    var conn = await SqlConn.connect(ip: "192.168.1.1", port: "1433", databaseName: "SATLANTICO", username: "dcosta", password: "sola8411");
    //print("TESTES 3");
    // Faça operações no banco de dados aqui

    final results = await conn.query('SELECT * FROM pe;');
    print(results.length);

    await conn.close();
  }
}