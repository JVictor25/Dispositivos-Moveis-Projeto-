import 'package:breakpoint_app/model/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class myDrawer extends StatefulWidget {
  final User activeUser;

  const myDrawer({
    super.key,
    required User this.activeUser,
  });

  @override
  State<myDrawer> createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {

  void _exit(){
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Sair', style: Theme.of(context).textTheme.headlineMedium, ),
        backgroundColor: Color(0xffCBDCEB),
        content: Text('Você realmente deseja fechar o aplicativo?',  style: Theme.of(context).textTheme.bodySmall),
        actions: [
          TextButton(
            child: Text('Não', style: Theme.of(context).textTheme.titleSmall),
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
          ),
          TextButton(
            child: Text('Sim', style: Theme.of(context).textTheme.titleSmall,),
            onPressed: () {
              SystemNavigator.pop(); // Fecha a aplicação
            },
          ),
        ],
      );
    },
  );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff133E87),
              Color(0xFF608BC1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF608BC1), // Cor do fundo do avatar
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        widget.activeUser.avatar!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    widget.activeUser.username,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.star_border,
                size: 30,
                color: Colors.white,
              ),
              title: Text(
                'Premium',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              //onTap: ,
            ),
            ListTile(
              leading: Icon(
                Icons.person_2_outlined,
                size: 30,
                color: Colors.white,
              ),
              title: Text(
                'Perfil',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              //onTap: ,
            ),
            ListTile(
              leading: Icon(
                Icons.person_add_alt,
                size: 30,
                color: Colors.white,
              ),
              title: Text(
                'Amigos',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              //onTap: ,
            ),
            ListTile(
              leading: Icon(
                Icons.flag_outlined,
                size: 30,
                color: Colors.white,
              ),
              title: Text(
                'Missões',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              //onTap: ,
            ),
            ListTile(
              leading: Icon(
                Icons.settings_outlined,
                size: 30,
                color: Colors.white,
              ),
              title: Text(
                'Configurações',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              //onTap: ,
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app_outlined,
                size: 30,
                color: Colors.white,
              ),
              title: Text(
                'Sair',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              onTap: _exit,
            ),
          ],
        ),
      ),
    );
  }
}
