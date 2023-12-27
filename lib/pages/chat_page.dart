import '../project_export/project_export.dart';

class ChatPage extends StatelessWidget {
  static const String routeName = '/chatPage';

  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Flutter Chat',
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                    SignoutRequestedEvent(),
                  );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: const Column(
        children: [
          Expanded(child: MessagesSection()),
          InputMessageField(),
        ],
      ),
    );
  }
}
