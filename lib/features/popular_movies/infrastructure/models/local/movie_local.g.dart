// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieLocalAdapter extends TypeAdapter<MovieLocal> {
  @override
  final int typeId = 0;

  @override
  MovieLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieLocal(
      id: fields[0] as int,
      title: fields[1] as String,
      overview: fields[2] as String,
      imageUrl: fields[3] as String,
      backdropPath: fields[4] as String,
      rating: fields[5] as double,
      popularity: fields[6] as double,
      releaseDate: fields[7] as String,
      page: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MovieLocal obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.overview)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.backdropPath)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.popularity)
      ..writeByte(7)
      ..write(obj.releaseDate)
      ..writeByte(8)
      ..write(obj.page);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
