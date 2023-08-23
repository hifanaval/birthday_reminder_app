import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/constants/image_class.dart';
import 'package:sample_application/provider/staff_provider.dart';
import 'package:sample_application/provider/students_provider.dart';
import 'package:sample_application/utils/api_support.dart';
import 'package:sample_application/widgets/card_container.dart';

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
      Provider.of<StudentProvider>(context, listen: false).getStudent();
      Provider.of<StaffProvider>(context, listen: false).getStaff();
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String formattedDate = DateFormat('MMMM d, y').format(date);

    return Scaffold(
      body: Consumer2<StudentProvider, StaffProvider>(
        builder: (context, studentProvider, staffProvider, _) {
          return studentProvider.isLoading || staffProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      HeaderWidget(
                        formattedDate: formattedDate,
                        count: staffProvider.staffModelData!.staffcount! +
                            studentProvider.studentsModelData!.count!,
                      ),
                      staffProvider.staffModelData == null ||
                              studentProvider.studentsModelData == null ||
                              staffProvider.staffModelData!.staffs!.isEmpty ||
                              studentProvider
                                  .studentsModelData!.students!.isEmpty
                          ? const NoBirthdayCard()
                          : Visibility(
                              visible: studentProvider
                                  .studentsModelData!.students!.isNotEmpty,
                              child: SizedBox(
                                height: 600,
                                child: CardContainer(
                                  itemcount: studentProvider
                                      .studentsModelData!.students!.length,
                                  name: studentProvider
                                      .studentsModelData!.students!
                                      .map((e) => e.studentName ?? "NA")
                                      .toList(),
                                  designation: studentProvider
                                      .studentsModelData!.students!
                                      .map((e) => e.designation ?? "NA")
                                      .toList(),
                                  imageUrl: studentProvider
                                      .studentsModelData!.students!
                                      .map((e) =>
                                          '${Apis.baseUrl}${e.profilePic}')
                                      .toList(),
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class NoBirthdayCard extends StatelessWidget {
  const NoBirthdayCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 4,
          child: Stack(
            children: [
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
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        const Center(
          child: Text(
            "Come back tommorrow!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black45,
            ),
          ),
        ),
      ],
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.formattedDate,
    required this.count,
  });

  final String formattedDate;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              'Today',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              count != 0 ? "Its birthday for $count of us..!" : '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const Icon(
          Icons.settings_sharp,
          size: 30,
          color: Colors.black54,
        ),
      ],
    );
  }
}
