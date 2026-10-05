import 'package:equatable/equatable.dart';

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}

class IdParams extends Equatable {
  final String id;

  const IdParams({required this.id});

  @override
  List<Object?> get props => [id];
}

class PaginationParams extends Equatable {
  final int page;
  final int limit;

  const PaginationParams({this.page = 1, this.limit = 10});

  Map<String, dynamic> toMap() {
    return {'page': page, 'limit': limit};
  }

  @override
  List<Object?> get props => [page, limit];
}
