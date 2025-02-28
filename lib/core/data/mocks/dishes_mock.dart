import 'package:neoeats/features/data/models/category_model.dart';
import 'package:neoeats/features/data/models/client_model.dart';
import 'package:neoeats/features/data/models/dish_model.dart';
import 'package:neoeats/features/data/models/order_model.dart';

class MockData {
  static List<Category> categories = [
    Category(id: 1, name: 'Entradas'),
    Category(id: 2, name: 'Pratos Principais'),
    Category(id: 3, name: 'Sobremesas'),
    Category(id: 4, name: 'Bebidas'),
    Category(id: 5, name: 'Massas'),
    Category(id: 6, name: 'Saladas'),
    Category(id: 7, name: 'Frutos do Mar'),
    Category(id: 8, name: 'Vegetarianos'),
    Category(id: 9, name: 'Veganos'),
    Category(id: 10, name: 'Sanduíches'),
  ];

  static List<Dish> dishes = [
    Dish(
      id: 1,
      name: 'Salada Caesar',
      image:
          'https://static.itdg.com.br/images/1200-675/3f0787cb6db2f0db10269fc45bd8abee/shutterstock-1078415420.jpg',
      description:
          'Salada com alface, frango grelhado, croutons e molho caesar.',
      price: 19.99,
      status: 'active',
      categories: [categories[0], categories[6]],
    ),
    Dish(
      id: 2,
      name: 'Filé Mignon com Fritas',
      image:
          'https://blogdocheftaico.com/wp-content/uploads/2023/05/File-com-Fritas-Chef-Taico.png',
      description: 'Filé mignon grelhado servido com batatas fritas.',
      price: 49.99,
      status: 'active',
      categories: [categories[1], categories[7]],
    ),
    Dish(
      id: 3,
      name: 'Torta de Chocolate',
      image:
          'https://bolosparavender.com/wp-content/uploads/2023/03/Torta-de-chocolate-cremosa.jpg',
      description: 'Deliciosa torta de chocolate com cobertura cremosa.',
      price: 15.99,
      status: 'active',
      categories: [categories[2], categories[8]],
    ),
    Dish(
      id: 4,
      name: 'Suco de Laranja',
      image:
          'https://www.citrosuco.com.br/wp-content/uploads/2022/02/THUMB-05.png',
      description: 'Suco de laranja natural, servido gelado.',
      price: 7.99,
      status: 'active',
      categories: [categories[3], categories[9]],
    ),
    Dish(
      id: 5,
      name: 'Pizza Margherita',
      image:
          'https://s2-receitas.glbimg.com/c9vjNPzOeu1WdW8jvhuuRecGni4=/696x390/smart/filters:cover():strip_icc()/i.s3.glbimg.com/v1/AUTH_1f540e0b94d8437dbbc39d567a1dee68/internal_photos/bs/2024/h/r/EfCbvqTbeDRAD3Lzc5xA/pizza-margherita.jpg',
      description: 'Pizza com molho de tomate, mussarela e manjericão.',
      price: 35.99,
      status: 'active',
      categories: [categories[1], categories[4]],
    ),
    Dish(
      id: 6,
      name: 'Cheesecake de Morango',
      image:
          'https://claudia.abril.com.br/wp-content/uploads/2020/02/sobremesas-para-o-natal-cheesecake-pracc81tico-de-morangos.jpg',
      description: 'Cheesecake cremoso com cobertura de morango.',
      price: 18.99,
      status: 'active',
      categories: [categories[2], categories[8]],
    ),
    Dish(
      id: 7,
      name: 'Sopa de Abóbora',
      image: 'https://assets.unileversolutions.com/recipes-v2/36187.jpg',
      description: 'Sopa cremosa de abóbora com especiarias.',
      price: 14.99,
      status: 'active',
      categories: [categories[0], categories[8]],
    ),
    Dish(
      id: 8,
      name: 'Espaguete à Bolonhesa',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJ_iehSDAIwEQat6sEJd31QvcrqqpYj_ki0g&s',
      description: 'Espaguete com molho bolonhesa feito com carne moída.',
      price: 29.99,
      status: 'active',
      categories: [categories[4], categories[1]],
    ),
    Dish(
      id: 9,
      name: 'Pudim de Leite',
      image:
          'https://static.itdg.com.br/images/640-440/d1307a2e17cda187df76b78cfd3ac464/shutterstock-2322251819-1-.jpg',
      description: 'Pudim cremoso de leite condensado.',
      price: 12.99,
      status: 'active',
      categories: [categories[2]],
    ),
    Dish(
      id: 10,
      name: 'Refrigerante Cola',
      image:
          'https://brf.file.force.com/servlet/servlet.ImageServer?id=015U600000027Gj&oid=00D410000012TJa&lastMod=1703778094000',
      description: 'Refrigerante sabor cola gelado.',
      price: 5.99,
      status: 'active',
      categories: [categories[3]],
    ),
    Dish(
      id: 11,
      name: 'Risoto de Funghi',
      image:
          'https://i.ytimg.com/vi/iSad1ksd4eM/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLCfihOgO0bU-LW79L-PQjnDBr02SA',
      description: 'Risoto cremoso feito com cogumelos funghi.',
      price: 34.99,
      status: 'active',
      categories: [categories[4], categories[7]],
    ),
    Dish(
      id: 12,
      name: 'Brownie com Sorvete',
      image: 'https://assets.unileversolutions.com/recipes-v2/93463.jpg',
      description: 'Brownie de chocolate servido com sorvete de creme.',
      price: 16.99,
      status: 'active',
      categories: [categories[2]],
    ),
    Dish(
      id: 13,
      name: 'Salsicha Vina',
      image:
          'https://conteudo.imguol.com.br/c/entretenimento/7d/2023/04/04/salsicha-1680621703758_v2_1255x835.jpg',
      description: '38% sal e 62% sicha',
      price: 19.99,
      status: 'active',
      categories: [categories[3]],
    ),
  ];

  static List<Client> clients = [
    Client(
      name: 'client',
      email: '',
      registrationDate: DateTime.now().toString(),
      access: 'client',
    )
  ];

  static List<Order> orders = [
    Order(
      userId: 1,
      orderDate: DateTime.now().toIso8601String(),
      status: 'open',
      orderItems: [],
    )
  ];
}
