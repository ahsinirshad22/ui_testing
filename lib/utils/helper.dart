import 'package:flutter/material.dart';

addWidth([double value = 10]) {
  return SizedBox(
    width: value,
  );
}

addHeight([double value = 10]) {
  return SizedBox(
    height: value,
  );
}

getShrinkBox() {
  return const SizedBox.shrink();
}
