import '../../project_export/project_export.dart';

class MessagesSection extends StatelessWidget {
  const MessagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
        stream: chatRef.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, chatSnapshots) {
          if (chatSnapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
            return const Center(
              child: Text('No messages found!'),
            );
          }

          if (chatSnapshots.hasError) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }

          final loadedMsgs = chatSnapshots.data!.docs;

          return ListView.builder(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 40),
              reverse: true,
              itemCount: loadedMsgs.length,
              itemBuilder: (context, index) {
                final chatMsg = loadedMsgs[index].data();
                final nextChatMsg = index + 1 < loadedMsgs.length
                    ? loadedMsgs[index + 1].data()
                    : null;

                final currentMsgUserId = chatMsg['userId'];
                final nextMsgUserId =
                    nextChatMsg != null ? nextChatMsg['userId'] : null;

                final nextUserIsSame = nextMsgUserId == currentMsgUserId;

                if (nextUserIsSame) {
                  return MessageBubble.next(
                    message: chatMsg['text'],
                    isMe: authenticatedUser.uid == currentMsgUserId,
                  );
                } else {
                  return MessageBubble.first(
                    userImage: chatMsg['userImage'],
                    username: chatMsg['userName'],
                    message: chatMsg['text'],
                    isMe: authenticatedUser.uid == currentMsgUserId,
                  );
                }
              });
        });
  }
}
