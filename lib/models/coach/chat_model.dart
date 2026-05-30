enum ChatRole { user, ai }

class ChatMessage {
  final String text;
  final ChatRole role;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.role,
    required this.timestamp,
  });
}

final List<ChatMessage> kInitialMessages = [
  ChatMessage(
    text:
        "Hello! I'm your Persona AI coach. I've analyzed your report. Are you ready to work on your public speaking today?",
    role: ChatRole.ai,
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
];
