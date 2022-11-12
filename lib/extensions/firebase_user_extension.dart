part of 'extensions.dart';

extension FirebaseUserExtension on auth.User {
  UserModel convertToUser({
    String name = "No Name",
    List<String> selectedGenres = const [],
    String selectedSchool = "",
    int balance = 20,
  }) =>
      UserModel(
        this.uid,
        this.email!,
        name: name,
        balance: balance,
        selectedSchool: selectedSchool,
      );

  Future<UserModel> fromFireStore() async => await UserServices.getUser(this.uid);
}
