import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // void task1() {
  //   Future.delayed(Duration(seconds: 2), () {
  //     print("Task 1 completed after 2 seconds");
  //   });
  // }
  //
  // void task2() {
  //   Future.delayed(Duration(seconds: 4), () {
  //     print("Task 2 completed after 4 seconds");
  //   });
  // }
  //
  // void task3() {
  //   Future.delayed(Duration(seconds: 6), () {
  //     print("Task 3 completed after 6 seconds");
  //   });
  // }
  //
  // void task4() {
  //   Future.delayed(Duration(seconds: 8), () {
  //     print("Task 4 completed after 8 seconds");
  //   });
  // }
  //
  // void task5() {
  //   Future.delayed(Duration(seconds: 10), () {
  //     print("Task 5 completed after 10 seconds");
  //   });
  // }
  //
  // void task6() {
  //   Future.delayed(Duration(seconds: 12), () {
  //     print("Task 6 completed after 12 seconds");
  //   });
  // }
  //
  // void task7() {
  //   Future.delayed(Duration(seconds: 14), () {
  //     print("Task 7 completed after 14 seconds");
  //   });
  // }
  //
  // void task8() {
  //   Future.delayed(Duration(seconds: 16), () {
  //     print("Task 8 completed after 16 seconds");
  //   });
  // }
  //
  // void task9() {
  //   Future.delayed(Duration(seconds: 18), () {
  //     print("Task 9 completed after 18 seconds");
  //   });
  // }
  //
  // void task10() {
  //   Future.delayed(Duration(seconds: 20), () {
  //     print("Task 10 completed after 20 seconds");
  //   });
  // }
  //
  // void task11() {
  //   Future.delayed(Duration(seconds: 18), () {
  //     print("Task 11 completed after 18 seconds");
  //   });
  // }
  //
  // void task12() {
  //   Future.delayed(Duration(seconds: 16), () {
  //     print("Task 12 completed after 16 seconds");
  //   });
  // }
  //
  // void task13() {
  //   Future.delayed(Duration(seconds: 14), () {
  //     print("Task 13 completed after 14 seconds");
  //   });
  // }
  //
  // void task14() {
  //   Future.delayed(Duration(seconds: 12), () {
  //     print("Task 14 completed after 12 seconds");
  //   });
  // }
  //
  // void task15() {
  //   Future.delayed(Duration(seconds: 10), () {
  //     print("Task 15 completed after 10 seconds");
  //   });
  // }
  //
  // void task16() {
  //   Future.delayed(Duration(seconds: 8), () {
  //     print("Task 16 completed after 8 seconds");
  //   });
  // }
  //
  // void task17() {
  //   Future.delayed(Duration(seconds: 6), () {
  //     print("Task 17 completed after 6 seconds");
  //   });
  // }
  //
  // void task18() {
  //   Future.delayed(Duration(seconds: 4), () {
  //     print("Task 18 completed after 4 seconds");
  //   });
  // }
  //
  // Future<void> task19() async {
  //   await Future.delayed(Duration(seconds: 2), () {
  //     print("Task 19 completed after 2 seconds");
  //   });
  // }
  //
  // void task20() {
  //   Future.delayed(Duration(seconds: 0), () {
  //     print("Task 20 completed immediately");
  //   });
  // }

  void task1() {
    Future.delayed(Duration(seconds: 2), () {
      print("Task 1 completed after 2 seconds");
      task2();
    });
  }

  void task2() {
    Future.delayed(Duration(seconds: 4), () {
      print("Task 2 completed after 4 seconds");
      task3();
    });
  }

  void task3() {
    Future.delayed(Duration(seconds: 6), () {
      print("Task 3 completed after 6 seconds");
      task4();
    });
  }

  void task4() {
    Future.delayed(Duration(seconds: 8), () {
      print("Task 4 completed after 8 seconds");
      task5();
    });
  }

  void task5() {
    Future.delayed(Duration(seconds: 10), () {
      print("Task 5 completed after 10 seconds");
      task6();
    });
  }

  void task6() {
    Future.delayed(Duration(seconds: 12), () {
      print("Task 6 completed after 12 seconds");
      task7();
    });
  }

  void task7() {
    Future.delayed(Duration(seconds: 14), () {
      print("Task 7 completed after 14 seconds");
      task8();
    });
  }

  void task8() {
    Future.delayed(Duration(seconds: 16), () {
      print("Task 8 completed after 16 seconds");
      task9();
    });
  }

  void task9() {
    Future.delayed(Duration(seconds: 18), () {
      print("Task 9 completed after 18 seconds");
      task10();
    });
  }

  void task10() {
    Future.delayed(Duration(seconds: 20), () {
      print("Task 10 completed after 20 seconds");
      task11();
    });
  }

  void task11() {
    Future.delayed(Duration(seconds: 18), () {
      print("Task 11 completed after 18 seconds");
      task12();
    });
  }

  void task12() {
    Future.delayed(Duration(seconds: 16), () {
      print("Task 12 completed after 16 seconds");
      task13();
    });
  }

  void task13() {
    Future.delayed(Duration(seconds: 14), () {
      print("Task 13 completed after 14 seconds");
      task14();
    });
  }

  void task14() {
    Future.delayed(Duration(seconds: 12), () {
      print("Task 14 completed after 12 seconds");
      task15();
    });
  }

  void task15() {
    Future.delayed(Duration(seconds: 10), () {
      print("Task 15 completed after 10 seconds");
      task16();
    });
  }

  void task16() {
    Future.delayed(Duration(seconds: 8), () {
      print("Task 16 completed after 8 seconds");
      task17();
    });
  }

  void task17() {
    Future.delayed(Duration(seconds: 6), () {
      print("Task 17 completed after 6 seconds");
      task18();
    });
  }

  void task18() {
    Future.delayed(Duration(seconds: 4), () {
      print("Task 18 completed after 4 seconds");
      task19();
    });
  }

  void task19() {
    Future.delayed(Duration(seconds: 2), () {
      print("Task 19 completed after 2 seconds");
      task20();
    });
  }

  void task20() {
    Future.delayed(Duration(seconds: 0), () {
      print("Task 20 completed immediately");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
              onTap: () {},
              child: Container(
                width: 100,
                height: 200,
                color: Colors.red,
              )),
          InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("ok"),
                  backgroundColor: Colors.red,
                ));
              },
              child: Container(
                width: 100,
                height: 200,
                color: Colors.blue,
              ))
        ],
      ),
    );
  }
}
