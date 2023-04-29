import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

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

const tableSavingTarget = SqfEntityTable(
    tableName: 'savingTargets',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: false,
    modelName: null,
    fields: [
      SqfEntityField('target_name', DbType.text, isNotNull: true),
      SqfEntityField('target_amount', DbType.real, isNotNull: true),
      SqfEntityField('no_of_months', DbType.integer, isNotNull: true),
      SqfEntityField('note', DbType.text, defaultValue: ''),
      SqfEntityField('start_date', DbType.date, isNotNull: true),
    ]);

const tableSavingTargetRecords = SqfEntityTable(
    tableName: 'savingTargetRecords',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: false,
    modelName: null,
    fields: [
      SqfEntityField('amount', DbType.real, isNotNull: true),
      SqfEntityField('date', DbType.date, isNotNull: true),
      SqfEntityFieldRelationship(
        parentTable: tableSavingTarget,
        relationType: RelationType.ONE_TO_MANY,
        deleteRule: DeleteRule.CASCADE,
        defaultValue: 0,
      ),
    ]);

const tablePreferences = SqfEntityTable(
    tableName: 'preferences',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: false,
    modelName: null,
    fields: [
      SqfEntityField('name', DbType.text, isNotNull: true),
      SqfEntityField('value', DbType.text, isNotNull: true),
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
    tableSavingTarget,
    tableSavingTargetRecords,
    tablePreferences
  ],
  sequences: [
    seqIdentity,
  ],
);
