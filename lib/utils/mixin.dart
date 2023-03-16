import 'package:flutter/material.dart';
import 'package:kabaten/utils/selected_account_listner.dart';

import '../localization/app_localization.dart';
import '../locator.dart';
import '../repository/http_repository.dart';

mixin Service {
  final HttpRepository? repository = locator<HttpRepository>();
}

abstract class Bloc<T extends Object> implements SelectedAccountChangeListner {
  Bloc();
  final T? service = locator<T>();
}

abstract class Model<T> {
  Map<String, dynamic> toJson();
  Map<String, dynamic> toDatabaseRow();
  Model();
}

mixin Screen<T extends Object> {
  final T? bloc = locator<T>();
  String? translate(BuildContext context, String key) {
    return AppLocalizations.of(context)!.translate(key);
  }
}

mixin Coequally<T> {
  @override
  bool operator ==(Object other) => identical(this, other) || other is T && other.runtimeType == runtimeType;

  @override
  int get hashCode => this.hashCode;
}
