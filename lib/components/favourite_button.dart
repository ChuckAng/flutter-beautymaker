import 'package:flutter/material.dart';

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black,
      radius: 18,
      child: IconButton(
        alignment: Alignment.center,
        icon: const Icon(
          Icons.favorite_rounded,
          size: 18,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    );
  }
}
