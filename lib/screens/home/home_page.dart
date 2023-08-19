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
        return studentProvider.studentsModelData != null
            ? Padding(
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
                              studentProvider.studentsModelData!.count != null
                                  ? studentProvider.studentsModelData!.count! >
                                          0
                                      ? "Its birthday for ${studentProvider.studentsModelData!.count ?? "0"} of us..!"
                                      : ''
                                  : 'No Data',
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
                    studentProvider.studentsModelData!.count != null
                        ? studentProvider.studentsModelData!.count! <= 0
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
                            : studentProvider.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Expanded(
                                    child: ListView.separated(
                                      // shrinkWrap: true,
                                      itemCount: studentProvider
                                          .studentsModelData!.count!,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        height: 16,
                                      ),
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                        onTap: () {
                                          _showAlertDialog(
                                            context,
                                            name: studentProvider
                                                    .studentsModelData!
                                                    .students![index]
                                                    .studentName ??
                                                '',
                                            designation: studentProvider
                                                    .studentsModelData!
                                                    .students![index]
                                                    .designation ??
                                                '',
                                            course: studentProvider
                                                    .studentsModelData!
                                                    .students![index]
                                                    .course ??
                                                '',
                                            year: studentProvider
                                                    .studentsModelData!
                                                    .students![index]
                                                    .batchYear ??
                                                '',
                                          );
                                        },
                                        child: Card(
                                          elevation: 4,
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            // height: 540,
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: Image.asset(
                                                    ImageClass.birthDayImg,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
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
                                                        backgroundImage:
                                                            NetworkImage(
                                                          studentProvider
                                                                      .studentsModelData!
                                                                      .students![
                                                                          index]
                                                                      .profilePic !=
                                                                  null
                                                              ? studentProvider
                                                                  .studentsModelData!
                                                                  .students![
                                                                      index]
                                                                  .profilePic!
                                                              : ImageClass
                                                                  .profileImg,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 6,
                                                      ),
                                                      Text(
                                                        "It is ${studentProvider.studentsModelData!.students![index].studentName ?? 'NA'}'s Birthday",
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors
                                                                .brown[300]),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      const Text(
                                                        "HAPPIEST BIRTHDAY!",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black87,
                                                          letterSpacing: 2,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      const Text(
                                                        "Let this special day brings you\na sea of happiness and joy.",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 14,
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                        : const Text("No data"),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        studentProvider.studentsModelData!.count == 0
                            ? "Come back tommorrow!"
                            : '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const Text(
                'Something Went Wrong!!!',
                style: TextStyle(
                  fontSize: 24,
                ),
              );
      }),
    );
  }

  void _showAlertDialog(
    BuildContext context, {
    required String name,
    required String designation,
    required String course,
    required String year,
  }) {
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
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const Center(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(ImageClass.profileImg),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        KeyValuePairWidget(
                          text: name,
                          label: "Name",
                        ),
                        KeyValuePairWidget(
                          text: designation,
                          label: "Designation",
                        ),
                        KeyValuePairWidget(
                          text: course,
                          label: "Course",
                        ),
                        KeyValuePairWidget(
                          text: year,
                          label: "Year",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
