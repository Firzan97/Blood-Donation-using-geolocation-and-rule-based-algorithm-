import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _MyHomePageState extends State<MyHomePage> {
  AppState state;
  File _image;
  final picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: Container(

          child: Column(
            children: <Widget>[
              Container(
                height: size.height*0.6,
                child: _image == null
                    ? Text('No image selected.')
                    : Image.file(_image),
              ),
              RaisedButton(
                child: Text("Gallery"),
                onPressed: () => getImage(ImageSource.gallery),
              ),
              RaisedButton(
                child: Text("Camera"),
                onPressed: () => getImage(ImageSource.camera),
              ),
              Uploader(file: _image),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          if (state == AppState.free)
            _pickImage();
          else if (state == AppState.picked)
            _cropImage();
          else if (state == AppState.cropped) _clearImage();
        },
        child: _buildButtonIcon(),
      ),
    );
  }

  Widget _buildButtonIcon() {
    if (state == AppState.free)
      return Icon(Icons.add);
    else if (state == AppState.picked)
      return Icon(Icons.crop);
    else if (state == AppState.cropped)
      return Icon(Icons.clear);
    else
      return Container();
  }

  Future<Null> _pickImage() async {
    _image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      setState(() {
        state = AppState.picked;
      });
    }
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  void _clearImage() {
    _image = null;
    setState(() {
      state = AppState.free;
    });
  }
}

class Uploader extends StatefulWidget {
  final File file;
  Uploader({Key key, this.file}) : super(key: key);
  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {

  final FirebaseStorage _storage = FirebaseStorage( storageBucket: "gs://easy-blood-aa7fd.appspot.com");
  StorageUploadTask _uploadTask;

  void _startUpload(){
    String filePath = 'images/${DateTime.now()}.png';
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile((widget.file));
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_uploadTask!=null){
  return StreamBuilder<StorageTaskEvent>(
    stream:  _uploadTask.events,
    builder: (context, snapshot){
      var event = snapshot?.data?.snapshot;
      double progressPercent = event != null ? event.bytesTransferred / event.totalByteCount : 0;
      return Column(
        children: <Widget>[
          if(_uploadTask.isComplete)
            Text("FINISSSSSSHHHH"),
          if(_uploadTask.isPaused)
            FlatButton(
              child: Icon(Icons.play_arrow),
              onPressed: () => _uploadTask.resume(),
            ),
          if(_uploadTask.isInProgress)
            FlatButton(
              child: Icon(Icons.pause),
              onPressed: _uploadTask.pause,
            ),
          LinearProgressIndicator(value:  progressPercent,),
          Text('${(progressPercent*100).toStringAsFixed((2))} %')
        ],
      );
    },
  );
    }
    else{
      return FlatButton.icon(
        label:  Text('upload to firebase'),
        icon: Icon(Icons.cloud_upload),
        onPressed:  _startUpload,
      );
    }
  }
}
