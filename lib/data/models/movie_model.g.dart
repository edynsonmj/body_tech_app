// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieModelAdapter extends TypeAdapter<MovieModel> {
  @override
  final int typeId = 0;

  @override
  MovieModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieModel(
      posterPath: fields[0] as String,
      adult: fields[1] as bool,
      overview: fields[2] as String,
      releaseDate: fields[3] as String,
      genreIds: (fields[4] as List).cast<int>(),
      id: fields[5] as int,
      originalTitle: fields[6] as String,
      originalLanguage: fields[7] as String,
      title: fields[8] as String,
      backdropPath: fields[9] as String,
      popularity: fields[10] as double,
      voteCount: fields[11] as int,
      video: fields[12] as bool,
      voteAverage: fields[13] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MovieModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.posterPath)
      ..writeByte(1)
      ..write(obj.adult)
      ..writeByte(2)
      ..write(obj.overview)
      ..writeByte(3)
      ..write(obj.releaseDate)
      ..writeByte(4)
      ..write(obj.genreIds)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.originalTitle)
      ..writeByte(7)
      ..write(obj.originalLanguage)
      ..writeByte(8)
      ..write(obj.title)
      ..writeByte(9)
      ..write(obj.backdropPath)
      ..writeByte(10)
      ..write(obj.popularity)
      ..writeByte(11)
      ..write(obj.voteCount)
      ..writeByte(12)
      ..write(obj.video)
      ..writeByte(13)
      ..write(obj.voteAverage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
