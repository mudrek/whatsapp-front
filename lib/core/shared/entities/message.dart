import 'package:kydrem_whatsapp/core/shared/entities/user.dart';

class Message {
  final int id;
  final String text;
  final User sender;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.text,
    required this.sender,
    required this.createdAt,
  });
}



// @Id
//     @GeneratedValue(strategy = GenerationType.AUTO)
//     private Long id;
//     @ManyToOne
//     @Lazy
//     private Chat chat;
//     private String text;
//     @ManyToOne
//     private User sender;
//     private LocalDateTime createdAt;