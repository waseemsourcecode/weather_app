 
import 'package:flutter_riverpod/flutter_riverpod.dart';
 

//final isWatch = StateProvider((ref) => false);
final userNameProvider = StateProvider((ref) => '');
final conditionalProvider = Provider.autoDispose((ref) {
  //final watch = ref.watch(isWatch);
  // if (watch) {
     return ref.watch(userNameProvider);
  // }
  //return ref.read(userNameProvider);
});
