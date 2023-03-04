import 'package:equatable/equatable.dart';

///Create abstract class to ceate extensions and Using an abstract class for creating events in Flutter BLoC pattern 
///allows for better type checking and helps in avoiding runtime errors. 
///It defines a base structure that all event classes should follow, 
///which ensures that the events will have the necessary methods and properties. 
///By defining a ProductEvent as an abstract class, we can create concrete classes that extend it and 
///define their own implementations of the necessary methods and properties. 
///This helps to keep our code organized and maintainable as we add more events and functionality to our application. 
///Additionally, we can ensure that all events have the same basic structure and properties, 
///which makes it easier to reason about the events and how they are being handled in the BLoC.
abstract class NewsArticleEvents extends Equatable {}

///User to create fetch data we can add different based on our needed
class FetchNewsEvent extends NewsArticleEvents {
  @override
  List<Object> get props => [];
}
