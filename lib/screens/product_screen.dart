import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/datas/product_data.dart';

class ProductScreen extends StatefulWidget {

  final ProductData product;
  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductData product;
  _ProductScreenState(this.product);
  String sizesel;

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title, maxLines: 1),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url){
                return NetworkImage(url);
                }).toList(),
              dotSize: 6.0,
              dotSpacing: 20.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  'R\$ ${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: primaryColor
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 16.0,),
                Text('Tamanho(s)',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: _SizeHeightRow(product.sizes.length),
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _QtdRowsSize(product.sizes.length),
                      crossAxisSpacing: _QtdRowsSize(product.sizes.length) > 0 ? 8.0 : 0.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: product.sizes.map((size){
                        return GestureDetector(
                          onTap: (){
                            setState(() {
                              sizesel = size;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: size == sizesel ? primaryColor : Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                color: size == sizesel ? primaryColor : Colors.grey[500],
                                width: 2.0
                              ),
                            ),
                            width: 50.0,
                            alignment: Alignment.center,
                            child: Text(size,
                              style: TextStyle(
                                  color: size == sizesel ? Colors.white : Colors.black
                              )),
                          ),
                        );
                      }).toList(),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: sizesel != null ? (){
                    } : null,
                    child: Text('Adicionar ao carrinho',
                        style: TextStyle(fontSize: 18.0),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text('Descrição',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500
                  ),
                ),
                Text(product.description,
                  style: TextStyle(
                      fontSize: 16.0
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  int _QtdRowsSize(int qtdSizes)
  {
    int result = (qtdSizes % 5) > 0 ? 1 : 0;
    int div = (qtdSizes / 5).floor();
    return div + result;
  }

  double _SizeHeightRow(int qtdSizes)
  {
    return _QtdRowsSize(qtdSizes) * 36.0;
  }
}
