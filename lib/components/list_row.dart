import 'dart:io';

import 'package:flutter/material.dart';

class ListRow extends StatelessWidget {
  ListRow(
      {super.key,
      required this.nome,
      required this.dataNascimento,
      // required this.image,
      required this.onTap,
      this.isSelected = false});
  String nome;
  String dataNascimento;
  // String image;
  bool isSelected;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepOrange : Colors.grey[900],
          boxShadow: [
            BoxShadow(
              color: const Color(0x00000000).withOpacity(1),
              offset: const Offset(0, 4),
              blurRadius: 9,
              spreadRadius: -1,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.deepOrange,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    nome,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    dataNascimento,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              IconButton(
                  onPressed: onTap,
                  icon: Icon(
                    Icons.edit,
                    color: isSelected ? Colors.white : Colors.deepOrange,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
