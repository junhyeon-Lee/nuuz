// import 'package:flutter/material.dart';
// import 'package:nuuz/models/nuuz_talk/data_model.dart';
// import 'package:nuuz/ui/common_widget/flying_animation.dart';
// import 'package:nuuz/ui/theme/icon_path.dart';
//
// class CartridgeScreen extends StatelessWidget {
//   CartridgeScreen({Key? key}) : super(key: key);
//
//   final List<DataModel> userList=[
//     DataModel('1', 'A', 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80'),
//     DataModel('2', 'B', 'https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=170667a&w=0&k=20&c=MRMqc79PuLmQfxJ99fTfGqHL07EDHqHLWg0Tb4rPXQc='),
//     DataModel('3', 'C', 'https://media.istockphoto.com/id/1338134336/photo/headshot-portrait-african-30s-man-smile-look-at-camera.jpg?b=1&s=170667a&w=0&k=20&c=j-oMdWCMLx5rIx-_W33o3q3aW9CiAWEvv9XrJQ3fTMU='),
//     DataModel('4', 'D', 'https://media.istockphoto.com/id/1311634222/photo/portrait-of-successful-black-male-modern-day-student-holding-smartphone.jpg?b=1&s=170667a&w=0&k=20&c=qdZ9RCZsdzSqmeBrluO_S-sC8Y7lUBre80UvjwTCRxE='),
//     DataModel('5', 'E', 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80'),
//     DataModel('6', 'F', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQEZrATmgHOi5ls0YCCQBTkocia_atSw0X-Q&usqp=CAU'),
//     DataModel('7', 'G', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR63KoribGVDB_dswx8iUX99udIebJK_EsaYYTwg2vJoIeIECXhO8iWnI5VBU64wLJ-8gg&usqp=CAU'),
//     DataModel('8', 'G', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwJzyQcBu_7EH0wSSW14L4Edxsj3X8AJKcy3UBpQE33iMrZ8Z3SNXmPpEZyqsl898vYwI&usqp=CAU'),
//     DataModel('9', 'I', 'https://img.freepik.com/free-photo/portrait-smiley-modern-male_23-2148514900.jpg'),
//     DataModel('10', 'J', 'https://us.123rf.com/450wm/fizkes/fizkes2007/fizkes200700173/150873587-headshot-portrait-of-young-caucasian-male-director-or-boss-in-glasses-posing-at-workplace-profile.jpg?ver=6'),
//     DataModel('11', 'K', 'https://www.shutterstock.com/image-photo/profile-picture-confident-young-caucasian-260nw-1779265493.jpg'),
//     DataModel('12', 'L', 'https://www.shutterstock.com/image-photo/young-hispanic-businessman-arms-crossed-260nw-1923080534.jpg'),
//     DataModel('13', 'M', 'https://media.gettyimages.com/id/637232624/photo/enhancing-his-entrepreneurial-ambition-with-the-right-tools.jpg?s=612x612&w=gi&k=20&c=QT6ODbpt-sVs60nhczaYF-gwwQOLw8PByDOBingK81k='),
//     DataModel('14', 'N', 'https://media.gettyimages.com/id/611904222/photo/young-entrepreneur-working-on-a-new-project.jpg?s=612x612&w=gi&k=20&c=mZFSRdq9Ql8DgoM4OaJe79bcbrlcjEv7md847zOIQk-M='),
//     DataModel('15', 'O', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxLDEajEW8QIw_X_Zt5S-1rxj0-lhuljenolf6zjfThRco-WTZIlp_QU-BIFFBhjhp9uM&usqp=CAU'),
//     DataModel('16', 'P', 'https://www.corporatephotographerslondon.com/wp-content/uploads/2021/07/LinkedIn_profile_photo_sample_1-300x300.jpg'),
//     DataModel('17', 'Q', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZF8F8M7wiyVxk5XscUmKNPijRFEKwT6NH0fAgqpdfezLOomoHjnOqd8L9cj9niEwkADc&usqp=CAU'),
//     DataModel('18', 'R', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRMlcYYdpn9HleCLqzIcI8BswbjHc6oSjz6VbL8IMa5Br-IGDklWZSaY3J5N-HFgeZSms&usqp=CAU'),
//     DataModel('19', 'S', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZwz5vtndWOj3pg6DAj1IsqwRpVkReTkh5Wy8-NqX6cLmwRTy7UP7NCJ6OOigzKXqSH6U&usqp=CAU'),
//     DataModel('20', 'T', 'https://img.freepik.com/premium-vector/avatar-profile-colorful-illustration-2_549209-82.jpg'),
//     DataModel('21', 'U', 'https://cdn4.vectorstock.com/i/1000x1000/06/18/male-avatar-profile-picture-vector-10210618.jpg'),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned(
//             left: 0,
//             right: 0,
//             top: 0,
//             bottom: 0,
//             child: Image.asset(IconPath.girlImage,),),
//
//           Positioned(child: FlyingAnimation(Icons.heart_broken,width: 400,height: 650,list: userList,),),
//
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Column(
//             children: [
//
//             ],
//           ),),
//
//         ],
//       ),
//     );
//   }
// }
