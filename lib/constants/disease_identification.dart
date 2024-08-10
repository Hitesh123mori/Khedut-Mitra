

class DImage {
  final String path;
  final String name;
  final String Dname ;
  final int id;

  DImage({
    required this.path,
    required this.name,
    required this.Dname,
    required this.id,
  });
}



class Dintification {

  static final List<DImage> diseaseImages = [
    DImage(
      path: 'assets/images/dirty_blog.jpq',
      Dname: 'Dirty Blog',
      name: "Demo A",
      id: 1,
    ),
    DImage(
      path: 'assets/images/downy_mildew.jpg',
      Dname: 'Downy Mildew',
      name : "Demo B",
      id: 2,
    ),
    DImage(
      path: 'assets/images/rust.jpeg',
      Dname: 'Rust',
      name: "Demo C",
      id: 3,
    ),
    DImage(
      path: 'assets/images/scab.jpeg',
      Dname: 'Scab',
      id: 4,
      name: 'Demo D',
    ),
  ];

}
