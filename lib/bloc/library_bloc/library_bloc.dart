import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_downloder/bloc/library_bloc/library_event.dart';
import 'package:video_downloder/bloc/library_bloc/library_state.dart';
import 'package:video_downloder/repository/library_repository/library_repository.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  final LibraryRepository _libraryRepository;
  LibraryBloc({required LibraryRepository libraryRepository})
    : _libraryRepository = libraryRepository,
      super(LibraryInitial()) {
    on<StartDownload>(_onStartDownload);
    on<UpdateProgress>((event, emit) {
      if (state is LibraryLoading) {
        emit(LibraryLoading(progress: event.progress));
      }
    });
  }

  Future<void> _onStartDownload(
    StartDownload event,
    Emitter<LibraryState> emit,
  ) async {
    emit(LibraryLoading(progress: 0.0));
    try {
      final fileName = 'video_${DateTime.now().millisecondsSinceEpoch}.mp4';

      await _libraryRepository.downloadVideo(
        url: event.url,
        fileName: fileName,
        onProgress: (received, total) {
          if (total != -1) {
            add(UpdateProgress(received / total));
          }
        },
      );

      emit(LibrarySuccess('Video downloaded successfully!'));
    } catch (e) {
      emit(LibraryError(e.toString()));
    }
  }
}
