import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:postgres/postgres.dart';

void main() async {
  // Load environment variables
  dotenv.load();

  // Connect to the database
  final connection = PostgreSQLConnection(
    dotenv.env['PGHOST']!,
    int.parse(dotenv.env['PGPORT']!),
    dotenv.env['PGDATABASE']!,
    username: dotenv.env['PGUSER']!,
    password: dotenv.env['PGPASSWORD']!,
  );
  await connection.open();

  // Create a router
  final router = Router();

  // CORS middleware
  Response _cors(Response response) => response.change(headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Origin, Content-Type, Authorization',
      });

  // Login Route
  router.post('/login', (Request request) async {
    try {
      final payload = jsonDecode(await request.readAsString());
      final username = payload['username'];

      if (username == null || username.isEmpty) {
        return Response(400, body: jsonEncode({'error': 'Username required'}));
      }

      await connection.query(
        'INSERT INTO users (username) VALUES (@username)',
        substitutionValues: {'username': username},
      );

      return Response.ok(jsonEncode({'message': 'User $username logged in'}));
    } catch (e) {
      return Response(500, body: jsonEncode({'error': e.toString()}));
    }
  });

  // Create a handler with CORS support
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware((innerHandler) => (request) async {
            final response = await innerHandler(request);
            return _cors(response);
          })
      .addHandler(router);

  // Start the server on 0.0.0.0 for compatibility with hosting services
  final server = await io.serve(handler, InternetAddress.anyIPv4,
      int.parse(Platform.environment['PORT'] ?? '8080'));
  print('Server listening on port ${server.port}');
}
