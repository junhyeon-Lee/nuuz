/*
final getProductProvider = StateNotifierProvider<GetProductProvider, ProductModel?>((ref) {
  return GetProductProvider();
});

class GetProductProvider extends StateNotifier<ProductModel?> {
  GetProductProvider() : super(null);
  final productService = ProductService();

  Future<void> getProgram() async {
    try {
      print('----------->API Call===1');
      state  = await productService.getProgram();
      if(state!=null){
        safePrint(state);
      }
    } catch (e) {
      safePrint(e);
    }
  }
}
*/
