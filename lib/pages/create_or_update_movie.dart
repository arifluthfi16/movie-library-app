import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_library/api/MovieAPI.dart';
import 'package:movie_library/components/CustomButton.dart';
import 'package:movie_library/components/ThemeWrapper.dart';
import 'package:movie_library/dto/MovieDTO.dart';
import '../dto/AuthDTO.dart';

class CreateOrUpdateMovieScreen extends StatefulWidget {
  final UserDTO user;
  final MovieDTO? movieToUpdateDTO;
  final String action;

  const CreateOrUpdateMovieScreen({Key? key, required this.user, this.movieToUpdateDTO, required this.action }) : super(key: key);

  @override
  State<CreateOrUpdateMovieScreen> createState() => _CreateOrUpdateMovieScreenState();
}

class _CreateOrUpdateMovieScreenState extends State<CreateOrUpdateMovieScreen> {
  final titleController = TextEditingController();
  final releaseYearController = TextEditingController();
  String? genre = null;
  final ratingController = TextEditingController();
  final descriptionController = TextEditingController();
  final thumbnailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isSubmitLoading = false;
  String action = "CREATE";

  @override
  void initState() {
    super.initState();
    initiateForm();
  }

  void initiateForm() {
    if (widget.action == "UPDATE") {
      setState(() {
        if (widget.movieToUpdateDTO != null) {
          titleController.text = widget.movieToUpdateDTO!.title ?? '';
          releaseYearController.text = widget.movieToUpdateDTO!.releaseYear?.toString() ?? '';
          ratingController.text = widget.movieToUpdateDTO!.rating?.toString() ?? '';
          descriptionController.text = widget.movieToUpdateDTO!.description ?? '';
          thumbnailController.text = widget.movieToUpdateDTO!.thumbnailUrl ?? '';
          genre = widget.movieToUpdateDTO!.genre;
          action = "UPDATE";
        }
      });
    }
  }

  void setLoading (bool newValue) {
    setState(() {
      isSubmitLoading = newValue;
    });
  }

  void  onSubmitCreate () async {
    try {
      setLoading(true);
      CreateOrUpdateMovieRequestDTO requestDTO = getRequestDTO();
      SingleMovieResponseDTO responseDTO = await MovieAPI.createMovie(requestDTO);
      handleResponse(responseDTO);
    } catch (e) {
      showToast("Failed to Submit Data $e");
    } finally {
      setLoading(false);
    }
  }

  void  onSubmitUpdate () async {
    try {
      setLoading(true);
      CreateOrUpdateMovieRequestDTO requestDTO = getRequestDTO();
      SingleMovieResponseDTO responseDTO = await MovieAPI.updateMovie(widget.movieToUpdateDTO!.id,requestDTO);
      handleResponse(responseDTO);
    } catch (e) {
      showToast("Failed to Submit Data $e");
    } finally {
      setLoading(false);
    }
  }

  void handleResponse (SingleMovieResponseDTO responseDTO) {
    if (responseDTO.data != null) {
      String actionKeyword = action == "CREATE" ? "Created" : "Updated";
      showToast("Successfully $actionKeyword a Movie, redirecting in 2 second");
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacementNamed(
          "/home",
          arguments: widget.user
        );
      });
    } else if (responseDTO.data == null && responseDTO.message != null){
      showToast(responseDTO.message.toString());
    } else if (responseDTO.errors != null && responseDTO.errors!.isNotEmpty) {
      showToast(responseDTO.errors!.first.toString());
    }
  }

  void showToast (String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.lightGreen,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  CreateOrUpdateMovieRequestDTO getRequestDTO () {
    CreateOrUpdateMovieRequestDTO requestDTO = CreateOrUpdateMovieRequestDTO(
      thumbnailUrl: thumbnailController.text,
      title: titleController.text,
      description: descriptionController.text,
      genre: genre.toString(),
      rating: int.parse(ratingController.text),
      releaseYear: int.parse(releaseYearController.text),
    );
    return requestDTO;
  }

  Widget buildMovieForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Title is required';
              }
              return null;
            },
          ),
          TextFormField(
            controller: releaseYearController,
            decoration: const InputDecoration(labelText: 'Release Year'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 200,
            height: 60,
            child: DropdownButton<String>(
              value: genre,
              onChanged: (value) {
                setState(() {
                  genre = value.toString();
                });
              },
              items: const [
                DropdownMenuItem<String>(
                  value: "SciFi",
                  child: SizedBox(
                    width: 170,
                    child: Text("SciFi", overflow: TextOverflow.ellipsis),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: "Action",
                  child: SizedBox(
                    width: 170,
                    child: Text("Action", overflow: TextOverflow.ellipsis),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: "Thriller",
                  child: SizedBox(
                    width: 170,
                    child: Text("Thriller", overflow: TextOverflow.ellipsis),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: "Romance",
                  child: SizedBox(
                    width: 170,
                    child: Text("Romance", overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
          ),
          TextFormField(
            controller: ratingController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Rating'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Rating is required';
              }
              if (int.tryParse(value) == null || int.parse(value) < 1 || int.parse(value) > 10) {
                return 'Please enter a valid rating between 1 and 10';
              }
              return null;
            },
          ),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 3,
          ),
          TextFormField(
            controller: thumbnailController,
            decoration: const InputDecoration(labelText: 'Thumbnail URL (Use image format e.g .jpg)'),
            maxLines: 2,
          ),
          const SizedBox(height: 4,),
          const Text(
            'Thumbnail can be left empty',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black38,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 40),
          CustomButton(
            backgroundColor: Colors.lightGreen,
            text: "Submit",
            isLoading: isSubmitLoading,
            onPressed: () {
              if (action == "CREATE") {
                onSubmitCreate();
              } else {
                onSubmitUpdate();
              }
            },
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    initiateForm();
    return ThemeWrapper(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(action == "CREATE" ? "Create new Movie" : "Update Movie",
            style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildMovieForm(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
