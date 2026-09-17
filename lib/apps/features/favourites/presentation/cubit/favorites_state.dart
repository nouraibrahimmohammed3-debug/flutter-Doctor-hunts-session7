class FavoritesState {
  const FavoritesState({required this.favoriteDoctorIds, this.searchText = ''});

  final Set<String> favoriteDoctorIds;
  final String searchText;

  FavoritesState copyWith({
    Set<String>? favoriteDoctorIds,
    String? searchText,
  }) {
    return FavoritesState(
      favoriteDoctorIds: favoriteDoctorIds ?? this.favoriteDoctorIds,
      searchText: searchText ?? this.searchText,
    );
  }
}
