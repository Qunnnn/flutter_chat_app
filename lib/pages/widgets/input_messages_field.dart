import '../../project_export/project_export.dart';

class InputMessageField extends StatefulWidget {
  const InputMessageField({super.key});

  @override
  State<InputMessageField> createState() => _InputMessageFieldState();
}

class _InputMessageFieldState extends State<InputMessageField> {
  final _controller = TextEditingController();

  void _submitting() async {
    final enteredMsg = _controller.text;

    if (enteredMsg.trim().isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();
    _controller.clear();

    final currentUser = FirebaseAuth.instance.currentUser;

    final userData = await userRef.doc(currentUser!.uid).get();

    await chatRef.add({
      'createdAt': Timestamp.now(),
      'text': enteredMsg,
      'userId': currentUser.uid,
      'userName': userData.data()!['name'],
      'userImage': userData.data()!['image_url'],
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  labelText: 'Send a message...'),
            ),
          ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: _submitting,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
