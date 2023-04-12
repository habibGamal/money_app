import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
import '../tools/helper.dart';

part 'model.g.dart';

// part 'model.g.view.dart';
const tableRecord = SqfEntityTable(
    tableName: 'records',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: false,
    modelName: null,
    fields: [
      // true => expense , false => income
      SqfEntityField('type', DbType.bool, defaultValue: true),
      SqfEntityField('amount', DbType.real, isNotNull: true),
      SqfEntityField('category_id', DbType.numeric, isNotNull: true),
      SqfEntityField('note', DbType.text, defaultValue: ''),
      SqfEntityField('date', DbType.date, isNotNull: true),
    ]);
const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
);
@SqfEntityBuilder(dbModel)
const dbModel = SqfEntityModel(
  modelName: 'DBModel', // optional
  databaseName: 'sampleORM.db',
  databaseTables: [
    tableRecord,
  ],
  sequences: [seqIdentity],
);
