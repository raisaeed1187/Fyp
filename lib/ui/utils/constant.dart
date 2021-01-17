final List<String> imgList = [
  'https://images.unsplash.com/photo-1534452203293-494d7ddbf7e0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1513884923967-4b182ef167ab?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  'https://images.unsplash.com/photo-1513885535751-8b9238bd345a?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  'https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  'https://images.unsplash.com/photo-1487412912498-0447578fcca8?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  'https://images.unsplash.com/photo-1526178613552-2b45c6c302f0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
  'https://images.unsplash.com/photo-1472417583565-62e7bdeda490?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
];

//  imgList.map(
//         (url) {
//           return Stack(
//             children: <Widget>[
//               Container(
//                 margin: EdgeInsets.all(5.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                   child: Image.network(
//                     url,
//                     fit: BoxFit.cover,
//                     width: 1000.0,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: <Widget>[
//                       Text(
//                         "Sunny Getaways",
//                         style: TextStyle(color: Colors.white, fontSize: 24),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Text(
//                             "Lorem Ipsım Dolar Lorem Ipsım Dolar Lorem Ipsım Dolar",
//                             style:
//                                 TextStyle(color: Colors.white, fontSize: 14)),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           );
//         },
//       ).toList(),
