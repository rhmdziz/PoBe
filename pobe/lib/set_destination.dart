import 'package:flutter/material.dart';
import 'package:pobe/destination_result.dart';
import 'package:pobe/help.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SetDestiny extends StatefulWidget {
  final String startPoint;
  final String endPoint;

  const SetDestiny(
      {super.key, required this.startPoint, required this.endPoint});

  @override
  State<SetDestiny> createState() => _SetDestinyState();
}

class _SetDestinyState extends State<SetDestiny> {
  final TextEditingController _startPointController = TextEditingController();
  final TextEditingController _endPointController = TextEditingController();
  final TextEditingController _fromTimeController = TextEditingController();
  final TextEditingController _toTimeController = TextEditingController();

  double _scale = 1.0;
  final TransformationController _transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();
    _startPointController.text = widget.startPoint;
    _endPointController.text = widget.endPoint;
  }

  void _zoomIn() {
    setState(() {
      _scale = (_scale * 1.2).clamp(1.0, 5.0);
      _transformationController.value = Matrix4.identity()..scale(_scale);
    });
  }

  void _zoomOut() {
    setState(() {
      _scale = (_scale / 1.2).clamp(1.0, 5.0);
      _transformationController.value = Matrix4.identity()..scale(_scale);
    });
  }

  Future<List<String>> _getSuggestions(String query) async {
    final response =
        await http.get(Uri.parse('http://192.168.50.226:8000/haltes/'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data
          .map((item) => item['nama_halte'] as String)
          .where((name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final String formattedTime = picked.format(context);
      setState(() {
        controller.text = formattedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.lightBlue[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios),
                          color: const Color.fromRGBO(31, 54, 113, 1),
                        ),
                        const Text(
                          'Schedule',
                          style: TextStyle(
                            color: Color.fromRGBO(31, 54, 113, 1),
                            fontSize: 18,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const HelpPage())),
                        );
                      },
                      icon: const Icon(
                        Icons.help_rounded,
                        color: Color.fromRGBO(31, 54, 113, 1),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Insert your starting point',
                      style: TextStyle(
                        color: Color.fromARGB(255, 26, 159, 255),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.25),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Image.asset('assets/starting.png'),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TypeAheadField(
                                controller: _startPointController,
                                builder: (context, controller, focusNode) =>
                                    TextField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: 'Starting Point ...',
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 26, 159, 255),
                                      fontSize: 16,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(0, 0, 0, 0.6),
                                  ),
                                ),
                                hideKeyboardOnDrag: true,
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    title: Text(suggestion),
                                  );
                                },
                                onSelected: (suggestion) {
                                  _startPointController.text = suggestion;
                                },
                                suggestionsCallback: (pattern) async {
                                  return await _getSuggestions(pattern);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Insert your end point',
                      style: TextStyle(
                        color: Color.fromARGB(255, 26, 159, 255),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.25),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      width: double.infinity,
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Image.asset('assets/end.png'),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TypeAheadField(
                                controller: _endPointController,
                                builder: (context, controller, focusNode) =>
                                    TextField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintText: 'End Point ...',
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 26, 159, 255),
                                      fontSize: 16,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(0, 0, 0, 0.6),
                                  ),
                                ),
                                hideKeyboardOnDrag: true,
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    title: Text(suggestion),
                                  );
                                },
                                onSelected: (suggestion) {
                                  _endPointController.text = suggestion;
                                },
                                suggestionsCallback: (pattern) async {
                                  return await _getSuggestions(pattern);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'From',
                              style: TextStyle(
                                color: Color.fromARGB(255, 26, 159, 255),
                                fontSize: 16,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.25),
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _fromTimeController,
                                readOnly: true,
                                textAlign: TextAlign.center,
                                onTap: () =>
                                    _selectTime(context, _fromTimeController),
                                decoration: const InputDecoration(
                                  hintText: '--:--',
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 26, 159, 255),
                                    fontSize: 18,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w300,
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(0, 0, 0, 0.6),
                                ),
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'To',
                              style: TextStyle(
                                color: Color.fromARGB(255, 26, 159, 255),
                                fontSize: 16,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.25),
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _toTimeController,
                                readOnly: true,
                                textAlign: TextAlign.center,
                                onTap: () =>
                                    _selectTime(context, _toTimeController),
                                decoration: const InputDecoration(
                                  hintText: '--:--',
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 26, 159, 255),
                                    fontSize: 18,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w300,
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(0, 0, 0, 0.6),
                                ),
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultDestiny(
                                    startPoint: _startPointController.text,
                                    endPoint: _endPointController.text,
                                    fromTime: _fromTimeController.text,
                                    toTime: _toTimeController.text,
                                  )),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromRGBO(31, 54, 113, 1)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        minimumSize: const MaterialStatePropertyAll(
                            Size(double.infinity, 50)),
                      ),
                      child: const Text(
                        'Find Transportation',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Lexend',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(250, 135, 0, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(7.5),
                            topRight: Radius.circular(7.5))),
                    child: const Text(
                      'BSD Link',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: Color.fromRGBO(250, 135, 0, 1),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: InteractiveViewer(
                          transformationController: _transformationController,
                          minScale: 1.0,
                          maxScale: 2.0,
                          constrained: true,
                          child: Image.asset(
                            'assets/transport/bsdlink_route.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.white,
                        onPressed: _zoomIn,
                        elevation: 0,
                        heroTag: 'zoomIn',
                        child: const Icon(Icons.zoom_in, color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.white,
                        onPressed: _zoomOut,
                        elevation: 0,
                        heroTag: 'zoomOut',
                        child: const Icon(Icons.zoom_out, color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
