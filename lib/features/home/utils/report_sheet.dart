import 'package:socialverse/export.dart';

class ReportSheet extends StatefulWidget {
  const ReportSheet({Key? key}) : super(key: key);

  @override
  State<ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends State<ReportSheet> {
  String? _selectedReason;

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportProvider>(
      builder: (_, reportProvider, __) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: 540,
            width: cs().width(context),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              color: Theme.of(context).canvasColor,
            ),
            child: Column(
              children: [
                // Header with close button
                Container(
                  width: cs().width(context),
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        "Select a reason",
                        style: AppTextStyle.normalSemiBold20Black.copyWith(
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                      Positioned(
                        right: 10,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
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
                const Divider(height: 0),

                // Radio button list
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildRadioListTile(
                                "Bullying or harassment", setState),
                            _buildRadioListTile("Spam", setState),
                            _buildRadioListTile(
                                "Intellectual property", setState),
                            _buildRadioListTile(
                                "Nudity or sexual activity", setState),
                            _buildRadioListTile(
                                "Violence, hate or exploitation", setState),
                            _buildRadioListTile(
                                "I don't want to see this", setState),
                            _buildRadioListTile("False information", setState),
                            _buildRadioListTile("Something else", setState),

                            if (_selectedReason == "Something else")
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: AuthTextFormField(
                                  maxLines: 8,
                                  keyboardType: TextInputType.text,
                                  hintText: 'Enter your Reason here please',
                                  controller: reportProvider.reason,
                                  fillColor: Colors.transparent,
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                // Submit Button
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 20),
                  child: AuthButtonWithColor(
                    title: "Submit",
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => ReportSubmitDialog(),
                      );
                      print('Selected reason: $_selectedReason');
                    },
                    isGradient: true,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // RadioListTile builder function
  Widget _buildRadioListTile(String title, StateSetter setState) {
    bool isSelected = title == _selectedReason;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Radio<String>(
        value: title,
        groupValue: _selectedReason,
        onChanged: (value) {
          setState(() {
            _selectedReason = value;
          });
        },
        activeColor: const Color(0xFF0A858F4),
        fillColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            return states.contains(MaterialState.selected)
                ? const Color(0xFF0A858F4)
                : Theme.of(context).indicatorColor;
          },
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).focusColor,
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
