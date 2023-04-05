// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BaseViewModel on _BaseViewModelBase, Store {
  late final _$isDarkModeAtom =
      Atom(name: '_BaseViewModelBase.isDarkMode', context: context);

  @override
  bool? get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool? value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  late final _$_BaseViewModelBaseActionController =
      ActionController(name: '_BaseViewModelBase', context: context);

  @override
  void init() {
    final _$actionInfo = _$_BaseViewModelBaseActionController.startAction(
        name: '_BaseViewModelBase.init');
    try {
      return super.init();
    } finally {
      _$_BaseViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeTheme() {
    final _$actionInfo = _$_BaseViewModelBaseActionController.startAction(
        name: '_BaseViewModelBase.changeTheme');
    try {
      return super.changeTheme();
    } finally {
      _$_BaseViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkMode: ${isDarkMode}
    ''';
  }
}
