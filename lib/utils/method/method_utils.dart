import 'package:flutter/material.dart';

RenderBox? getRenderBox(BuildContext context) {
  RenderObject? renderObject = context.findRenderObject();
  RenderBox? box;
  if (renderObject != null) {
    box = renderObject as RenderBox;
  }
  return box;
}
