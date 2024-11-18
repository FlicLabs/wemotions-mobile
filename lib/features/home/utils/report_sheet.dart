import 'package:socialverse/export.dart';

class ReportSheet extends StatefulWidget {
  const ReportSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends State<ReportSheet> {
  String? _selectedReason = ""; // Initialize the variable

  @override
  Widget build(BuildContext context) {
    // RadioListTile builder function
    Widget _buildRadioListTile(
        String title, String? selectedReason, Function(String?) onChanged) {
      bool isSelected = title == selectedReason;

      return Container(
        height: 48, // Adjust this value to decrease or increase the tile height
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio<String>(
                value: title,
                groupValue: selectedReason,
                onChanged:
                    onChanged, // Calls the passed setState method from StatefulBuilder
                activeColor: Color(0xFF0A858F4),
                fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Color(0xFF0A858F4); // Selected color
                    }
                    return Theme.of(context).indicatorColor; // Unselected color (white)
                  },
                ),
              ),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontSize: 14,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Consumer<ReportProvider>(
      builder: (_, __, ____) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, // Moves the bottom sheet up when keyboard is open
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              color: Theme.of(context).canvasColor,
            ),
            child: Container(
              height: 540,
              width: cs().width(context),
              child: Column(
                children: [
                  Container(
                    width: cs().width(context),
                    padding: EdgeInsets.only(
                        top: 18, bottom: 18, left: 20, right: 20),
                    child: Stack(
                      alignment:
                          Alignment.center, // Center the Stack's children
                      children: [
                        Positioned(
                          child: Text(
                            "Select a reason",
                            style: AppTextStyle.normalSemiBold20Black.copyWith(
                              color: Theme.of(context).focusColor,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.grey.shade600,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Theme.of(context).focusColor,
                    height: 0,
                  ),
                  Expanded(
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return ListView(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5, right: 24),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _buildRadioListTile(
                                      "Bullying or harassment", _selectedReason,
                                      (String? value) {
                                    setState(() {
                                      _selectedReason = value;
                                    });
                                  }),
                                  _buildRadioListTile("Spam", _selectedReason,
                                      (value) {
                                    setState(() {
                                      _selectedReason = value;
                                    });
                                  }),
                                  _buildRadioListTile(
                                      "Intellectual property", _selectedReason,
                                      (String? value) {
                                    setState(() {
                                      _selectedReason = value;
                                    });
                                  }),
                                  _buildRadioListTile(
                                      "Nudity or sexual activity",
                                      _selectedReason, (String? value) {
                                    setState(() {
                                      _selectedReason = value;
                                    });
                                  }),
                                  _buildRadioListTile(
                                      "Violence, hate or exploitation",
                                      _selectedReason, (String? value) {
                                    setState(() {
                                      _selectedReason = value;
                                    });
                                  }),
                                  _buildRadioListTile(
                                      "I don't want to see this",
                                      _selectedReason, (String? value) {
                                    setState(() {
                                      _selectedReason = value;
                                    });
                                  }),
                                  _buildRadioListTile(
                                      "False information", _selectedReason,
                                      (String? value) {
                                    setState(() {
                                      _selectedReason = value;
                                    });
                                  }),
                                  _buildRadioListTile(
                                      "Something else", _selectedReason,
                                      (String? value) {
                                    setState(() {
                                      _selectedReason = value;
                                    });
                                  }),
                                  if (_selectedReason == "Something else") ...[
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: AuthTextFormField(

                                        maxLines: 8,
                                        keyboardType: TextInputType.text,
                                        hintText: 'Enter your Reason here please',
                                        controller: __.reason,
                                        fillColor: Colors.transparent,
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 20, left: 20, right: 20),
                    child: AuthButtonWithColor(
                      title: "Submit",
                      onTap: () {
                        Navigator.pop(context);
                        // Handle submit action
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ReportSubmitDialog();
                          },
                        );
                        print('Selected reason: $_selectedReason');
                      },
                      isGradient: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
