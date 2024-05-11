import 'package:flutter/material.dart';

class DonorForm extends StatefulWidget {
  const DonorForm({super.key});

  @override
  _DonorFormFormState createState() => _DonorFormFormState();
}

class _DonorFormFormState extends State<DonorForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  bool? food = false;
  bool? clothes = false;
  bool? cash = false;
  bool? necessities = false;
  bool? others = false;
  String logistics = 'Pick up';
  String? address;
  String? weight;
  String? phoneNum;

  final TextEditingController _dateValue = TextEditingController();
  final TextEditingController _timeValue = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? pickDate = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(1999), 
      lastDate: DateTime(2100)
    );

    if(pickDate != null) {
      setState(() {
        _dateValue.text = pickDate.toString().split(' ')[0];
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickTime =  await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now()
    );
    if(pickTime != null){
      setState(() {
        _timeValue.text = pickTime.format(context).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Center(
            child: Text('Donation Items', style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.5,
            )),
          ),
          CheckboxListTile(
            title: const Text('Food'),
            value: food, 
            onChanged: (newValue) {
              setState(() {
                food = newValue;
              });
            },
            activeColor: const Color.fromARGB(255, 112, 0, 0),
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: const Text('Clothes'),
            value: clothes, 
            onChanged: (newValue) {
              setState(() {
                clothes = newValue;
              });
            },
            activeColor: const Color.fromARGB(255, 112, 0, 0),
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: const Text('Cash'),
            value: cash, 
            onChanged: (newValue) {
              setState(() {
                cash = newValue;
              });
            },
            activeColor: const Color.fromARGB(255, 112, 0, 0),
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: const Text('Necessities'),
            value: necessities, 
            onChanged: (newValue) {
              setState(() {
                necessities = newValue;
              });
            },
            activeColor: const Color.fromARGB(255, 112, 0, 0),
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: const Text('Others'),
            value: others, 
            onChanged: (newValue) {
              setState(() {
                others = newValue;
              });
            },
            activeColor: const Color.fromARGB(255, 112, 0, 0),
            checkColor: Colors.white,
            controlAffinity: ListTileControlAffinity.leading,
          ),
          const Center(
            child: Text('Logistics', style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.5,
            )),
          ),
          DropdownButton(
            value: logistics,
            items: const [
              DropdownMenuItem<String>(
                value: 'Pick up',
                child: Text('Pick up')
              ),
              DropdownMenuItem<String>(
                value: 'Drop-off',
                child: Text('Drop-off')
              )
            ],
            icon: const Icon(Icons.arrow_drop_down),
            style: const TextStyle(color: Colors.black),
            underline: Container(
              color: Colors.white,
              height: 2,
            ),
            onChanged: (String? newValue){
              setState(() {
                logistics = newValue!;
              });
            }
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            onSaved: (newValue) => weight = newValue,
            onChanged: (value) {
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter the weight of the items";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Weight of Items",
              hintText: "Enter weight in kilograms",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.monitor_weight),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _dateValue,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please select a date";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Pick a date',
              filled: true,
              prefixIcon: Icon(Icons.calendar_today),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 112, 0, 0))
              )
            ),
            readOnly: true,
            onTap: (){
              _selectDate();
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _timeValue,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please select a time";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Pick time',
              filled: true,
              prefixIcon: Icon(Icons.calendar_today),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 112, 0, 0))
              )
            ),
            readOnly: true,
            onTap: (){
              _selectTime();
            },
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text('INPUT FOR PICTURE/PROOF HERE'),
          ),
          const SizedBox(height: 20),
          logistics == 'Pick up' ? Column(
            children: [
              TextFormField(
                onSaved: (newValue) => address = newValue,
                onChanged: (value) {
                  return;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your address";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Address",
                  hintText: "Enter your address",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(Icons.pin_drop)
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.phone,
                onSaved: (newValue) => phoneNum = newValue,
                onChanged: (value) {
                  return;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your phone number";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Enter your phone number",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Icon(Icons.phone)
                ),
              ),
            ],
          ) : Container(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context, 'Donation submitted! Kindly wait for approval.');
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
