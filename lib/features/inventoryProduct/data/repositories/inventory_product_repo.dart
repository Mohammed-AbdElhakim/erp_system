import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/inventory_product_body_model.dart';
import '../models/inventory_product_model.dart';

abstract class InventoryProductRepo {
  Future<Either<Failure, List<InventoryProductModel>>> getInventoryProduct({
    required InventoryProductBodyModel inventoryProductBody,
  });
}
