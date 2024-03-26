import 'package:application/data/globals.dart';
import 'package:application/services/db.dart';
import 'package:application/utiles/getImage.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        width: 250,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountEmail: Text(currentUser?.email ?? 'No email available'),
              accountName: Text(currentUser?.np ?? 'Aucun'),
              currentAccountPicture: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage:
                      currentUser != null && currentUser!.image.isNotEmpty
                          ? NetworkImage(currentUser!.image)
                          : null,
                  child: Stack(
                    children: [
                      if (currentUser?.image == null)
                        const Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.amber,
                          ),
                        ),
                      if (loading)
                        const Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.amber),
                          ),
                        ),
                      Positioned(
                        top: 38,
                        left: 13,
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            final data = await showModalBottomSheet(
                                context: context,
                                builder: (ctx) {
                                  return GetImage();
                                });
                            if (data != null) {
                              loading = true;
                              setState(() {});
                              String? urlImage = await DBServices()
                                  .uploadImage(data, path: "profil");
                              print(urlImage);
                              if (urlImage != null) {
                                currentUser?.image = urlImage;
                                bool isupdate =
                                    await DBServices().updateUser(currentUser!);
                                if (isupdate) {
                                  setState(() {});
                                  loading = false;
                                }
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
