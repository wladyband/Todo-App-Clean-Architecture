import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/ui/presentation/core/image.dart';

import '../../../../aplication/auth/authBloc/auth_bloc.dart';

class FlexibleSpace extends StatelessWidget {
  const FlexibleSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Image.asset(BannerImages.images.assets),
      titlePadding: const EdgeInsets.only(left: 20, bottom: 20),
      title: Row(
        children: [
          Text(
            "TODO",
            textScaleFactor: 2,
            style:
            Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(SignOutPressedEvent());
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
    );
  }
}
