import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/constants/image_class.dart';
import 'package:sample_application/provider/students_provider.dart';
import 'package:sample_application/widgets/key_value_pair.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<StudentProvider>(context, listen: false).getStudent();
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String formattedDate = DateFormat('MMMM d, y').format(date);

    // List<String> imageUrl = [
    //   "assets/images/profileImg.jpg",
    //   "assets/images/profileImg.jpg",
    //   "assets/images/profileImg.jpg"
    // ];

    // List<String> designation = ["Student", "Student", "Student"];

    // List<String> course = ["BDS", "MBBS", "MBBS"];
    // List<String> year = ["2021", "2019", "2023"];
    // List<String> name = ["Neethu C N", "Ashok", "Ayisha"];

    return Scaffold(
      body: Consumer<StudentProvider>(builder: (context, studentProvider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        'Today',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        studentProvider.studentsModelData!.count == 0
                            ? ""
                            : "Its birthday for ${studentProvider.studentsModelData!.count ?? "0"} of us..!",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.settings_sharp,
                    size: 30,
                    color: Colors.black54,
                  )
                ],
              ),
              studentProvider.studentsModelData!.count == 0
                  ? const SizedBox(
                      height: 0,
                    )
                  : const SizedBox(
                      height: 14,
                    ),
              studentProvider.studentsModelData!.count == 0
                  ? Card(
                      elevation: 4,
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            ImageClass.noBirthdayBg,
                            width: MediaQuery.of(context).size.width,
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Positioned(
                          bottom: 26,
                          left: 80,
                          child: Text(
                            'No birthdays today',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ]),
                    )
                  : Expanded(
                      child: ListView.separated(
                        // shrinkWrap: true,
                        itemCount:
                            // 3,
                            studentProvider.studentsModelData!.count!,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
                        ),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            _showAlertDialog(context);
                          },
                          child: Card(
                              elevation: 4,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                // height: 540,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        ImageClass.birthDayImg,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                        top: 110,
                                        left: 60,
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                                radius: 80,
                                                backgroundImage: AssetImage(
                                                    studentProvider
                                                                .studentsModelData!
                                                                .count ==
                                                            0
                                                        ? "No data"
                                                        : studentProvider
                                                            .studentsModelData!
                                                            .students![index]
                                                            .profilePic!)
                                                // (imageUrl[index])
                                                // )
                                                ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              // "Its Name's Birthday",
                                              studentProvider.studentsModelData!
                                                          .count ==
                                                      0
                                                  ? "No data"
                                                  : "It is ${studentProvider.studentsModelData!.students![index].studentName}'s Birthday",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.brown[300]),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            const Text(
                                              "HAPPIEST BIRTHDAY!",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87,
                                                  letterSpacing: 2),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            const Text(
                                              "Let this special day brings you\na sea of happiness and joy.",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black54),
                                            ),
                                            const SizedBox(
                                              height: 14,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              studentProvider.studentsModelData!.count == 0
                  ? const Center(
                      child: Text(
                        "Come back tommorrow!",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45),
                      ),
                    )
                  : const Text("")
            ],
          ),
        );
      }),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return Consumer<StudentProvider>(
        //   builder: (context, studentprovider,_) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: const Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage(ImageClass.profileImg),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          KeyValuePairWidget(
                            text: "Neethu C N",
                            label: "Name",
                          ),
                          KeyValuePairWidget(
                            text: "Student",
                            label: "Designation",
                          ),
                          KeyValuePairWidget(
                            text: "BDS",
                            label: "Course",
                          ),
                          KeyValuePairWidget(
                            text: "2021",
                            label: "Year",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ));
          }
        );
        
    //   },
    // );
  }
}
