import 'package:draggable_icons/social_icons.dart';

var listIcons = [
  SocialIcons(imageUrl: "images/fb.png", title: "Facebook"),
  SocialIcons(imageUrl: "images/linkedin.png", title: "Linkedin"),
  SocialIcons(imageUrl: "images/github.png", title: "Github"),
  SocialIcons(imageUrl: "images/fiver.png", title: "Fiver"),
  SocialIcons(imageUrl: "images/upwork.png", title: "Upwork"),
  SocialIcons(imageUrl: "images/twitter.png", title: "Twitter"),
];

var listSocialTitle = [
  SocialIcons(title: "Facebook"),
  SocialIcons(title: "Linkedin"),
  SocialIcons(title: "Github"),
  SocialIcons(title: "Fiver"),
  SocialIcons(title: "Upwork"),
  SocialIcons(title: "Twitter"),
];

void resetList() {
  var tempList = listSocialTitle;
  listSocialTitle.clear();
  listSocialTitle = tempList;
}

String title = "";