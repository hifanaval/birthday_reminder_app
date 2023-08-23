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
    return Expanded(
      child: ListView.separated(   
        ///idhok apporthenem ippotrheillenm expanded kodkan patla?
        ///patayi onnm illa   
        itemCount: itemcount,
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            // _showAlertDialog(
            //   context,
            //   isStaff: isStaff,
            //   name: name[index],
            //   designation: designation[index],
            //   course: course![index],
            //   department: department![index],
            //   year: year![index],
            // );
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
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(
                            imageUrl.isNotEmpty
                                ? imageUrl[index]
                                : ImageClass.profileImg,
                          )),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "It is ${name[index]}'s Birthday",
                      
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
                        height: 12,
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
                        height: 14,
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(
    BuildContext context, {
    required String name,
    required String designation,
    String? course,
    String? year,
    String? department,
    bool? isStaff,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            content: SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Column(
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
                          text: isStaff! ? course! : department!,
                          label: "Course",
                        ),
                        KeyValuePairWidget(
                          text: year!,
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
