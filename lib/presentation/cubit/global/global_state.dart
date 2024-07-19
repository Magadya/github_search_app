import 'package:flutter/material.dart';

@immutable
abstract class GlobalStates {}

class GlobalInitial extends GlobalStates {}

class GlobalInitialState extends GlobalStates {}

class ChangeAppThemeState extends GlobalStates {}

class GetAppThemeState extends GlobalStates {}
