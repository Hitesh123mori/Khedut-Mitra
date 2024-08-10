import 'package:flutter/material.dart';
import 'package:hack_24/screens/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:hack_24/screens/provider/user_provider.dart';
import '../../../apis/helper_api/season_identification.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppUserProvider>(
        builder: (context, userProvider, child) {
          final user = userProvider.user;
          String imagePath;

          // Determine the current plant season
          String currentSeason = SeasonIdntification.getCurrentPlantSeason();

          // Select the image based on the current season
          switch (currentSeason) {
            case 'Spring':
              imagePath = 'assets/images/spring.png';
              break;
            case 'Summer':
              imagePath = 'assets/images/summer.png';
              break;
            case 'Winter':
              imagePath = 'assets/images/winter.png';
              break;
            default:
              imagePath = 'assets/images/moonsoon.png';
              break;
          }

          return user == null
              ? Center(child: CircularProgressIndicator())
              : Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                  color:
                  AppColors.theme['primaryColor'].withOpacity(0.12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.theme['primaryColor'],
                      radius: 25,
                      backgroundImage:
                      AssetImage("assets/images/profile_pic.png"),
                    ),
                    title: Text(
                      user.name ?? "No Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(user.email ?? "No Email"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Current Season",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Card(
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
              ],
            ),
          );
        },
      ),
    );
  }
}
