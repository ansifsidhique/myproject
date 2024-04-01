class AddtoCart{
  String id;
  String name;
  String price;
  AddtoCart({required this.name,required this.id,required this.price});
}class Cart{
  List <AddtoCart> items=[];
}

