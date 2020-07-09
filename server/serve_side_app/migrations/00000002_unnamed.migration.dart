import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration2 extends Migration { 
  @override
  Future upgrade() async {
   		database.deleteColumn("_CategoryModel", "description");
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {}
}
    