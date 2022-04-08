import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:upload_percentage/core/enum/upload_status.dart';
import 'package:upload_percentage/features/users/domain/entities/personal_pic.dart';
import 'package:upload_percentage/features/users/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:upload_percentage/features/users/presentation/providers/users/users_provider.dart';
import '../../../../../../../../../core/enum/viewstate.dart';
import '../../../../../../../../../core/util/constants.dart';

import '../../../../../../../../../injection_container.dart' as di;

class CustomerPersonalPic extends StatefulWidget {
  final User user;
  CustomerPersonalPic({ @required this.user}) ;

  @override
  _CustomerPersonalPicState createState() => _CustomerPersonalPicState();
}

class _CustomerPersonalPicState extends State<CustomerPersonalPic> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _image;
  ImagePicker _picker;

  @override
  void initState() {
    super.initState();
    debugPrint('CustomerPersonalPic  widget.user ${widget.user}');
    _picker = new ImagePicker();
      }


  Future<void> _getImage({BuildContext context}) async {
    UsersProvider userProvider = Provider.of<UsersProvider>(context, listen: false);
    try{
      XFile image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          preferredCameraDevice: CameraDevice.front
      );
      setState(() {
        _image = image != null ? File(image.path) : null;
      });
      if(image != null){
        Map fields = {
          'id'          : widget.user.id,
          'name'          : widget.user.name,
          'photo'       : image.path,
          'updated_at'  : DateTime.now().toString(),
        };


        showDownloadProgressDialog(context);
        await userProvider.updateUserPhoto(parameters: fields);




      }
    } catch(e){
      debugPrint('_getImage error: $e');
    }
  }

  Future<void> _deleteImage({BuildContext context}) async {
    debugPrint('_deleteImage called');
  }

  buildBody({BuildContext context, PersonalPic photo}){

    String userPhoto="";
    if(photo != null && photo.photoLink != null){
      debugPrint('buildBody photo.photoLink = ${photo.toString()}');
      userPhoto = Constants.USER_PHOTOS_PATH+photo.photoLink.toString();
    }
    debugPrint('buildBody photo out = ${photo.toString()}');
    return SizedBox(
      key: _scaffoldKey,
      height: 230,
      width: 200,
      child: Stack(
        clipBehavior: Clip.none, fit: StackFit.expand,
        children: [
          Container(
              width: 200,
              height: 200,
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                  color: Color(0xFFFF7643)),
              child: _image != null
                 ?  Image.file(
                _image,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.fill,

              )
                  : Container(
                decoration: BoxDecoration(
                    color: Color(0xFFFF7643)),
                width: 200,
                height: 200,
                child:
                photo != null && photo.photoLink != null
                ? CachedNetworkImage(
                  imageUrl: userPhoto,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image.asset(
                      Constants.DEFAULT_USER_IMAGE
                  ),
                )
                    :  Image.asset(Constants.DEFAULT_USER_IMAGE)
                ,
              )
          ),

          photo != null && photo.photoLink != null && photo.photoLink != ''  ?  Positioned(
            left: -16,
            top: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
                color: Colors.red,
                onPressed: () async {
                  await _deleteImage(context: context);
                },
                child: Icon(Icons.remove_circle_outline_rounded, color: Colors.white,),
              ),
            ),
          )
              : Container(),

          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
                color: Color(0xFFFF7643),
                onPressed: () {
                  _getImage(context: context);
                },
                child: Icon(Icons.camera_alt_outlined,
                color: Colors.white, ),
              ),
            ),
          ),



        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UsersProvider>(
    builder: (context, myUserProvider, child){
      if(myUserProvider.currentPersonalPic != null){
        return myUserProvider.state == ViewState.Busy
             ? CircularProgressIndicator()
            : buildBody(context: context, photo: myUserProvider.currentPersonalPic,);
      } else {
        return buildBody(context: context, photo: myUserProvider.currentPersonalPic,);
      }});
  }

  showDownloadProgressDialog(BuildContext ctx)  {
    showDialog(
      context: ctx,
      builder: (_) {
        return AlertDialog(
          content: Consumer<UsersProvider>(
            builder: (ctx, provider, child) {
              if (provider.uploadStatus == UploadStatus.fetchingUpload) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('LOADING'),
                  ],
                );
              } else if (provider.uploadStatus == UploadStatus.uploading) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Positioned(
                      right: 5,
                      child: Text("${provider.progressProgress.toStringAsFixed(
                          0)}%"),
                    ),
                  ],
                );
              } else if (provider.uploadStatus == UploadStatus.notUploaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red),
                    SizedBox(width: 16),
                    Expanded(child: Text('NOT UPLOADED')),
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 16),
                    Text('Photo Uploaded Successfully'),
                  ],
                );
              }
            },
          ),
        );
      },
    );
  }

}
