// Mocks generated by Mockito 5.4.4 from annotations
// in movie_app/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:convert' as _i12;
import 'dart:typed_data' as _i14;

import 'package:dartz/dartz.dart' as _i2;
import 'package:http/http.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i13;
import 'package:movie_app/data/datasources/movie_remote_data_source.dart'
    as _i11;
import 'package:movie_app/data/models/movie_response.dart' as _i3;
import 'package:movie_app/data/models/movie_video_response.dart' as _i4;
import 'package:movie_app/domain/entities/movie_r.dart' as _i9;
import 'package:movie_app/domain/entities/movie_video_r.dart' as _i10;
import 'package:movie_app/domain/repositories/movie_repository.dart' as _i6;
import 'package:movie_app/utils/failure.dart' as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieResponse_1 extends _i1.SmartFake implements _i3.MovieResponse {
  _FakeMovieResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieVideoResponse_2 extends _i1.SmartFake
    implements _i4.MovieVideoResponse {
  _FakeMovieVideoResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_3 extends _i1.SmartFake implements _i5.Response {
  _FakeResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_4 extends _i1.SmartFake
    implements _i5.StreamedResponse {
  _FakeStreamedResponse_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MovieRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRepository extends _i1.Mock implements _i6.MovieRepository {
  MockMovieRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i2.Either<_i8.Failure, _i9.MovieR>> getMovie() =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovie,
          [],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, _i9.MovieR>>.value(
            _FakeEither_0<_i8.Failure, _i9.MovieR>(
          this,
          Invocation.method(
            #getMovie,
            [],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, _i9.MovieR>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, _i10.MovieVideoR>> getMovieVideo(
          String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieVideo,
          [id],
        ),
        returnValue:
            _i7.Future<_i2.Either<_i8.Failure, _i10.MovieVideoR>>.value(
                _FakeEither_0<_i8.Failure, _i10.MovieVideoR>(
          this,
          Invocation.method(
            #getMovieVideo,
            [id],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, _i10.MovieVideoR>>);

  @override
  _i7.Future<_i2.Either<_i8.Failure, _i9.MovieR>> getMovieSearch(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieSearch,
          [query],
        ),
        returnValue: _i7.Future<_i2.Either<_i8.Failure, _i9.MovieR>>.value(
            _FakeEither_0<_i8.Failure, _i9.MovieR>(
          this,
          Invocation.method(
            #getMovieSearch,
            [query],
          ),
        )),
      ) as _i7.Future<_i2.Either<_i8.Failure, _i9.MovieR>>);
}

/// A class which mocks [MovieRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRemoteDataSource extends _i1.Mock
    implements _i11.MovieRemoteDataSource {
  MockMovieRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i3.MovieResponse> getMovie() => (super.noSuchMethod(
        Invocation.method(
          #getMovie,
          [],
        ),
        returnValue: _i7.Future<_i3.MovieResponse>.value(_FakeMovieResponse_1(
          this,
          Invocation.method(
            #getMovie,
            [],
          ),
        )),
      ) as _i7.Future<_i3.MovieResponse>);

  @override
  _i7.Future<_i4.MovieVideoResponse> getMovieVideo(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieVideo,
          [id],
        ),
        returnValue:
            _i7.Future<_i4.MovieVideoResponse>.value(_FakeMovieVideoResponse_2(
          this,
          Invocation.method(
            #getMovieVideo,
            [id],
          ),
        )),
      ) as _i7.Future<_i4.MovieVideoResponse>);

  @override
  _i7.Future<_i3.MovieResponse> getMovieSearch(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #getMovieSearch,
          [query],
        ),
        returnValue: _i7.Future<_i3.MovieResponse>.value(_FakeMovieResponse_1(
          this,
          Invocation.method(
            #getMovieSearch,
            [query],
          ),
        )),
      ) as _i7.Future<_i3.MovieResponse>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i5.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i7.Future<_i5.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i5.Response>);

  @override
  _i7.Future<_i5.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<_i5.Response>);

  @override
  _i7.Future<_i5.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i12.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i5.Response>);

  @override
  _i7.Future<_i5.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i12.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i5.Response>);

  @override
  _i7.Future<_i5.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i12.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i5.Response>);

  @override
  _i7.Future<_i5.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i12.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i7.Future<_i5.Response>.value(_FakeResponse_3(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i7.Future<_i5.Response>);

  @override
  _i7.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<String>.value(_i13.dummyValue<String>(
          this,
          Invocation.method(
            #read,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i7.Future<String>);

  @override
  _i7.Future<_i14.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i7.Future<_i14.Uint8List>.value(_i14.Uint8List(0)),
      ) as _i7.Future<_i14.Uint8List>);

  @override
  _i7.Future<_i5.StreamedResponse> send(_i5.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i7.Future<_i5.StreamedResponse>.value(_FakeStreamedResponse_4(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i7.Future<_i5.StreamedResponse>);

  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}