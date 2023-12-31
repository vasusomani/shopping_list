import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controllers/data_text_field.dart';
import '../../data/models/item.dart';
import '../../data/provider/state_notifier.dart';

class NewItem extends ConsumerStatefulWidget {
  NewItem({super.key});

  @override
  ConsumerState<NewItem> createState() => _NewItemState();
}

class _NewItemState extends ConsumerState<NewItem> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController quantityController = TextEditingController(text: "1");

  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  void _saveItem(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Item newItem = Item(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: nameController.text.toString().trim(),
        quantity: int.parse(quantityController.text.toString()),
        category: ref.read(categoryProvider.notifier).returnCategory(),
      );
      Navigator.of(context).pop(newItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(children: [
              NameField(nameController),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: QuantityField(quantityController),
                  )),
                  const Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: CategoryField(),
                  ))
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: (_isLoading)
                          ? (const CircularProgressIndicator())
                          : const Text("Cancel")),
                  ElevatedButton(
                    onPressed: () {
                      _isLoading = true;
                      _saveItem(context);
                      _isLoading = false;
                    },
                    child: const Text("Add"),
                  )
                ],
              )
            ]),
          ),
        );
      },
    );
  }
}
