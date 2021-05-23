import 'package:flutter/material.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_species_details.dart';
import 'package:mypokedex/util/hex_color.dart';

Color getSliderColor(PokemonColor color) {
  if (color == null || color.name == null) {
    return Colors.greenAccent[700];
  }
  switch (color.name) {
    case "green":
      return Colors.green;
    case "red":
      return Colors.redAccent[700];
    case "blue":
      return Colors.blueAccent[400];
    case "yellow":
      return Colors.yellow[300];
    case "brown":
      return Colors.brown[300];
    case "purple":
      return Colors.purpleAccent[100];
    case "pink":
      return Colors.pink[400];
    case "gray":
      return Colors.grey[700];
    case "black":
      return Colors.grey;
    case "white":
      return Colors.black54;
    default:
      return Colors.white;
  }
}

Color green = HexColor("#7CBEB3");
Color red = HexColor("#E16855");
Color blue = HexColor("#83C6D6");
Color yellow = HexColor("#F4B83F");
Color brown = HexColor("#BB9461");
Color purple = HexColor("#977E9E");
Color pink = HexColor("#E99EA2");
Color gray = HexColor("#CEC7BF");
Color black = HexColor("#454B4D");
Color white = HexColor("#DAE1EB");
Color leafGreen = HexColor("#A6B91A");

Color getColor(PokemonColor color) {
  if (color == null || color.name == null) {
    return Colors.greenAccent[700];
  }
  switch (color.name) {
    case "green":
      return green;
    case "red":
      return red;
    case "blue":
      return blue;
    case "yellow":
      return yellow;
    case "brown":
      return brown;
    case "purple":
      return purple;
    case "pink":
      return pink;
    case "gray":
      return gray;
    case "black":
      return black;
    case "white":
      return white;
    default:
      return white;
  }
}

Color getTextColor(PokemonColor color) {
  if (color == null || color.name == null) {
    return Colors.white;
  }
  switch (color.name) {
    case "green":
      return Colors.white;
    case "red":
      return Colors.white;
    case "blue":
      return Colors.white;
    case "yellow":
      return Colors.black;
    case "brown":
      return Colors.white;
    case "purple":
      return Colors.white;
    case "pink":
      return Colors.white;
    case "gray":
      return Colors.black;
    case "black":
      return Colors.white;
    default:
      return Colors.black;
  }
}
