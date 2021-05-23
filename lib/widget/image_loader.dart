import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:mypokedex/util/app_constants.dart';

class AppImageLoader extends StatelessWidget {
  final String imageUrl;
  final ImageType imageType;
  final bool showCircleImage;
  final bool roundCorners;
  final BoxFit boxFit;

  AppImageLoader.withImage(
      {Key key,
      @required this.imageUrl,
      @required this.imageType,
      @required this.showCircleImage,
      this.boxFit,
      @required this.roundCorners})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return _buildNoImageView(context);
    }
    switch (imageType) {
      case ImageType.ASSET:
        return loadAssetImage(context);
      case ImageType.NETWORK:
        return loadNetworkImage(context);
      case ImageType.FILE:
        return loadFromFile(context);
      default:
        return loadNetworkImage(context);
    }
  }

  Widget loadAssetImage(BuildContext context) {
    return ExtendedImage.asset(
      imageUrl,
      fit: BoxFit.cover,
      borderRadius: roundCorners != null && roundCorners
          ? BorderRadius.circular(4)
          : BorderRadius.circular(0),
      shape: showCircleImage != null && showCircleImage
          ? BoxShape.circle
          : BoxShape.rectangle,
      enableMemoryCache: true,
      clearMemoryCacheIfFailed: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            {
              return _buildNoAssetImageView(context);
            }
          case LoadState.completed:
            {
              return ExtendedRawImage(
                fit: boxFit == null ? BoxFit.cover : boxFit,
                image: state.extendedImageInfo?.image,
              );
            }
          case LoadState.failed:
            {
              return _buildNoAssetImageView(context);
            }
          default:
            {
              return _buildNoAssetImageView(context);
            }
        }
      },
    );
  }

  Widget _buildNoImageView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: showCircleImage ? BoxShape.circle : BoxShape.rectangle,
          color: Colors.transparent),
    );
  }

  Widget _buildNoAssetImageView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: showCircleImage ? BoxShape.circle : BoxShape.rectangle,
          color: Colors.transparent),
    );
  }

  Widget loadFromFile(BuildContext context) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return _buildNoImageView(context);
    }
    return ExtendedImage.file(
      File(imageUrl),
      fit: BoxFit.cover,
      borderRadius: roundCorners != null && roundCorners
          ? BorderRadius.circular(4)
          : BorderRadius.circular(0),
      shape: showCircleImage != null && showCircleImage
          ? BoxShape.circle
          : BoxShape.rectangle,
      enableMemoryCache: true,
      clearMemoryCacheIfFailed: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            {
              return _buildNoImageView(context);
            }
          case LoadState.completed:
            {
              return ExtendedRawImage(
                fit: boxFit == null ? BoxFit.cover : boxFit,
                image: state.extendedImageInfo?.image,
              );
            }
          case LoadState.failed:
            {
              return _buildNoImageView(context);
            }
          default:
            {
              return _buildNoImageView(context);
            }
        }
      },
    );
  }

  Widget loadNetworkImage(BuildContext context) {
    return ExtendedImage.network(
      imageUrl,
      fit: boxFit == null ? BoxFit.cover : boxFit,
      borderRadius: roundCorners != null && roundCorners
          ? BorderRadius.circular(4)
          : BorderRadius.circular(0),
      shape: BoxShape.rectangle,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            {
              return _buildNoImageView(context);
            }
          case LoadState.completed:
            {
              return ExtendedRawImage(
                fit: boxFit == null ? BoxFit.cover : boxFit,
                image: state.extendedImageInfo?.image,
              );
            }
          case LoadState.failed:
            {
              return _buildNoImageView(context);
            }
          default:
            {
              return _buildNoImageView(context);
            }
        }
      },
    );
  }
}
