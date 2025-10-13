import 'package:flutter/material.dart';
import 'package:task_manager2/ui/screens/update_profile_screen.dart';

class TMAppbar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppbar({
    super.key, this.fromUpdateProfile,
  });

  final bool? fromUpdateProfile;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: GestureDetector(
        onTap: () {
          if (fromUpdateProfile ?? false) {
            return;
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProfileScreen()));
        },
        child: Row(
          spacing: 8,
          children: [
            CircleAvatar(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Mohammad Shafin", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
                Text("mohammadshafin63@gmai.com", style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),),
              ],
            )
          ],
        ),
      ),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.logout))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}