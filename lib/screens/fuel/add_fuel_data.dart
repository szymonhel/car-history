import 'package:car_history/models/fuel_data_collection.dart';
import 'package:car_history/models/fuel_model.dart';
import 'package:car_history/widgets/fuel/FuelFormWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFuelScreen extends StatefulWidget {
  @override
  _AddFuelScreenState createState() => _AddFuelScreenState();
}

class _AddFuelScreenState extends State<AddFuelScreen> {
  final courseController = TextEditingController();
  final pricePerLiterController = TextEditingController();
  final totalLiterController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Function onDateUpdate = (newDate) {
      setState(() {
        this.date = newDate;
      });
    };

    return Scaffold(
      appBar: AppBar(
        title: Text("Nowe tankowanie"),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  if (formKey.currentState.validate()) {
                    var newModel = FuelModel(
                        amount: totalLiterController.text,
                        course: courseController.text,
                        date: date,
                        pricePerLiter: pricePerLiterController.text);
                    Provider.of<FuelDataCollection>(context, listen: false)
                        .addFuelElement(newModel);
                    Navigator.pop(context);
                  }
                },
                child: Icon(
                  Icons.done,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Center(
          child: FuelFormWidget(
              onDateUpdate: onDateUpdate,
              courseController: this.courseController,
              totalLiterController: this.totalLiterController,
              pricePerLiterController: this.pricePerLiterController,
              formKey: this.formKey)),
    );
  }
}
