import 'models/content_bundle.dart';

abstract interface class ContentRepository {
  Future<ContentBundle> load();
}
