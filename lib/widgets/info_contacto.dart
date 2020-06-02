import 'package:flutter/material.dart';

import 'package:precheckin/tools/translation.dart';
import 'package:precheckin/blocs/pms_bloc.dart';
import 'package:precheckin/styles/styles.dart';

class InfoContacto extends StatefulWidget {
  PMSBloc block;

  InfoContacto({ this.block });

  @override
  _InfoContactoState createState() => _InfoContactoState();
}

class _InfoContactoState extends State<InfoContacto> {
  PMSBloc _block;
  TextEditingController _ctrlEmail;
  TextEditingController _ctrlTelefono;
  bool _enableEmail;
  bool _enableTel;

  @override
  void initState() {
    super.initState();
    _block = widget.block;

    _ctrlEmail    = new TextEditingController(text: _block?.emailTitular);
    _ctrlTelefono = new TextEditingController(text: _block?.telefonoTitular);
    _enableEmail  = _ctrlEmail.text.isEmpty;
    _enableTel    = _ctrlTelefono.text.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 5.0, right: 5.0),
          decoration: boxDecorationDefault,
          child: Text(Translations.of(context).text('info_contacto'),style:blueAcentText.copyWith(fontWeight: FontWeight.bold),)
        ),
        SizedBox(height: 20.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(Translations.of(context).text('mail'),style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),),
            TextFormField(
              controller: _ctrlEmail,
              enabled: _enableEmail,
              keyboardType: TextInputType.emailAddress,
              onChanged: (email) => _block.emailTitular = email,
            ),
            SizedBox(height: 5,),
            Text(Translations.of(context).text('telefono'),style: TextStyle(fontWeight: FontWeight.w300,fontSize: 16),),
            TextFormField(
              controller: _ctrlTelefono,
              enabled: _enableTel,
              keyboardType: TextInputType.number,
              onChanged: (tel) => _block.telefonoTitular = tel,
            ),
          ],
        )
      ],
    );
  }
}