import 'package:flutter/material.dart';
import 'package:sample_application/constants/image_class.dart';
import 'package:sample_application/widgets/key_value_pair.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.itemcount,
    this.isStaff = false,
    required this.name,
    required this.designation,
    this.course,
    this.year,
    required this.imageUrl,
    this.department,
  });

  final int itemcount;
  final bool isStaff;
  final List<String> name;
  final List<String> designation;
  final List<String>? course;
  final List<String>? department;
  final List<String>? year;
  final List<String> imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemCount: itemcount,
        separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                print('object');
                showAlertDialog(
                  context,
                  isStaff: isStaff,
                  name: name[index],
                  imageUrl: imageUrl[index],
                  designation: designation[index],
                  course: course == null ? 'course' : course![index],
                  department: department == null ? 'dep' : department![index],
                  year: year == null ? 'yr' : year![index],
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.7),
                      blurRadius: 4,
                      spreadRadius: -2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage(
                      ImageClass.birthDayImg,
                    ),
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),
                      CircleAvatar(
                        radius: 48,
                        backgroundColor:
                            Colors.transparent, // Set a transparent background
                        child: ClipOval(
                          child: Image(
                            image: NetworkImage(
                              imageUrl.isNotEmpty
                                  ? imageUrl[index]
                                  : ImageClass.profileImg,
                            ),
                            fit: BoxFit.fill, // Set the BoxFit property here
                            width: 96, // Set the desired width
                            height: 96, // Set the desired height
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "It is ${name[index]}'s Birthday",
                        textAlign: TextAlign.center,
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
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Let this special day brings you\na sea of happiness and joy.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  void showAlertDialog(
    BuildContext context, {
    required String name,
    String? designation,
    String? imageUrl,
    String? course,
    String? year,
    String? department,
    bool isStaff = false,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.purple[100],
            content: SizedBox(
              height: 320,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image(
                          image:
                              NetworkImage(imageUrl ?? ImageClass.profileImg),
                          fit: BoxFit.fill, // Set your BoxFit here
                          width: 120, // Set your desired width
                          height: 120, // Set your desired height
                        ),
                      ),
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
                          text: designation ?? 'Na',
                          label: "Designation",
                        ),
                        isStaff
                            ? KeyValuePairWidget(
                                text: department ?? 'Na',
                                label: "Department",
                              )
                            : const SizedBox(),
                        isStaff
                            ? const SizedBox()
                            : KeyValuePairWidget(
                                text: course ?? 'NA',
                                label: "Course",
                              ),
                        isStaff
                            ? const SizedBox()
                            : KeyValuePairWidget(
                                text: year ?? 'NA',
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
