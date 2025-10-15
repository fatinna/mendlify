import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'startup_provider.g.dart';

@Riverpod(keepAlive: true)
Future<void> startUp(Ref ref, {required String flavour}) async{
  await Future.delayed(Duration(seconds: 3));
  debugPrint('flavour: $flavour');
}
