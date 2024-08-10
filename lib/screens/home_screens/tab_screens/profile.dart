import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hack_24/screens/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:hack_24/screens/provider/user_provider.dart';
import '../../../apis/auth_apis/auth_api.dart';
import '../../../apis/helper_api/season_identification.dart';
import '../../../apis/user_profile/user_profile_apis.dart';
import '../../../apis/var_setup.dart';
import '../../../main.dart';
import '../../utils/widgets/custom_text_field.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController interestController = TextEditingController();
  List<String> currCrops = [];
  List<String>? crops = SeasonIdntification.seasonPlants[SeasonIdntification.getCurrentPlantSeason()];
  List<String> suggestedCrops = [];

  void updateSuggestedCrops(String userInput) {
    suggestedCrops = crops!.where((crop) => crop.toLowerCase().contains(userInput.toLowerCase())).toList();
    setState(() {});
  }




  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Consumer<AppUserProvider>(
          builder: (context, userProvider, child) {
            final user = userProvider.user;
            if (user != null) {
              currCrops = user.currCrops ?? [];
            }
            String imagePath;

            // Determine the current plant season
            String currentSeason = SeasonIdntification.getCurrentPlantSeason();

            switch (currentSeason) {
              case 'Summer':
                imagePath = 'assets/images/summer.png';
                break;
              case 'Winter':
                imagePath = 'assets/images/winter.png';
                break;
              default:
                imagePath = 'assets/images/monsoon.png';
                break;
            }

            return user == null
                ? Center(child: CircularProgressIndicator())
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    color: AppColors.theme['primaryColor'].withOpacity(0.12),
                    child: ListTile(
                      trailing: IconButton(
                        onPressed: () async {
                          await AppFirebaseAuth.signOut(context);
                        },
                        icon: Icon(Icons.logout),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: AppColors.theme['primaryColor'],
                        radius: 25,
                        backgroundImage: AssetImage("assets/images/profile_pic.png"),
                      ),
                      title: Text(
                        user.name ?? "No Name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(user.email ?? "No Email"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Season",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Card(
                          elevation: 0.1,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(imagePath),
                            ),
                            title: Text(currentSeason),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Type Season crop",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),

                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: CustomTextField(
                          hintText: "Type interest",
                          isNumber: false,
                          prefixicon: Icon(Icons.interests_sharp),
                          obsecuretext: false,
                          controller: interestController,
                          onChange: (value) {
                            if (value!.isEmpty) {
                              setState(() {
                                suggestedCrops.clear();
                              });
                            } else {
                              updateSuggestedCrops(value);
                            }
                          },
                        ),
                        height: 60,
                        width: mq.width * 0.61,
                      ),
                      SizedBox(
                        width: mq.width * 0.02,
                      ),
                      InkWell(
                        onTap: () async {
                          String interest = interestController.text.trim();
                          if (interest.isNotEmpty) {
                            setState(() {
                              currCrops.add(interest);
                              interestController.clear();
                              suggestedCrops.clear();
                            });
                            await UserProfile.updateCurrCrops(user.userId, currCrops);
                          }
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                                "Add",
                                style: TextStyle(color: AppColors.theme['backgroundColor'], fontWeight: FontWeight.bold),
                              )),
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.theme['primaryColor']),
                        ),
                      ),
                    ],
                  ),
                  if (interestController.text.isNotEmpty)
                    Container(
                      height: 50,
                      child: ListView.builder(
                        itemCount: suggestedCrops.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(suggestedCrops[index]),
                            onTap: () async {
                              setState(() {
                                currCrops.add(suggestedCrops[index]);
                                interestController.clear();
                                suggestedCrops.clear();
                              });
                              await UserProfile.updateCurrCrops(user.userId, currCrops);
                            },
                          );
                        },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Wrap(
                      children:  userProvider.user!.currCrops!
                          .map(
                            (crop) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
                          child: Chip(
                            avatar: CircleAvatar(

                            ),
                            backgroundColor: AppColors.theme['secondaryColor'],
                            label: Text(crop),
                            onDeleted: () {
                              setState(() {
                                userProvider.user!.currCrops!.remove(crop);
                              });
                            },
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  )

                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String getCropImagePath(String cropName) {
    Map<String, String> cropImages = {
      'Wheat': 'assets/images/wheat.png',
      'Rice': 'assets/images/rice.png',
      'Corn': 'assets/images/corn.png',
      'Barley': 'assets/images/barley.png',
    };
    return cropImages[cropName] ?? 'assets/images/default_crop.png'; // Default image if not found
  }
}
