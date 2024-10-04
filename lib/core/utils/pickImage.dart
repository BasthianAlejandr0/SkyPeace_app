
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  final XFile? image = await _imagePicker.pickImage(source: source);
  if(image!=null){
    return await image.readAsBytes();
  }
  print('No se selecciono ninguna imagen');

}
