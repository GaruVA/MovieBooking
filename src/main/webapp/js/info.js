function populateEditModal(id, title, genre, description, imdb_rating, duration, release_date, status, actors, characters, director, produce, writer, music, image_path) {
    document.getElementById('editMovieId').value = id;
    document.getElementById('editMovieTitle').value = title;
    document.getElementById('editMovieGenre').value = genre;
    document.getElementById('editMovieDescription').value = description;
    document.getElementById('editMovieImdb_Rating').value = imdb_rating;
    document.getElementById('editMovieDuration').value = duration;
    document.getElementById('editMovieRelease_date').value = release_date;
    document.getElementById('editMovieStatus').value = status;
    document.getElementById('editMovieActors').value = actors;
    document.getElementById('editMovieCharacters').value = characters;
    document.getElementById('editMovieDirector').value = director;
    document.getElementById('editMovieProduce').value = produce;
    document.getElementById('editMovieWriter').value = writer;
    document.getElementById('editMovieMusic').value = music;
    document.getElementById('currentMovieImage').src = image_path || './images/placeholder.png';

    // Preview new image when selected
    document.getElementById('editImageInput').addEventListener('change', function (e) {
        if (this.files && this.files[0]) {
            const reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('currentMovieImage').src = e.target.result;
            };
            reader.readAsDataURL(this.files[0]);
        }
    });

    const editModal = new bootstrap.Modal(document.getElementById('editMovieModal'));
    editModal.show();

    // Ensure modal is properly hidden and backdrop is removed when close or cancel button is clicked
    document.querySelector('#editMovieModal .btn-close').addEventListener('click', function () {
        editModal.hide();
    });
    document.querySelector('#editMovieModal .btn-outline-secondary').addEventListener('click', function () {
        editModal.hide();
    });

    document.getElementById('editMovieModal').addEventListener('hidden.bs.modal', function () {
        document.querySelector('.modal-backdrop').remove();
    });
}

function setDeleteMovieId(movieId) {
    document.getElementById('deleteMovieId').value = movieId;
    const deleteModal = new bootstrap.Modal(document.getElementById('deleteMovieModal'));
    deleteModal.show();

    // Ensure modal is properly hidden and backdrop is removed when close or cancel button is clicked
    document.querySelector('#deleteMovieModal .btn-close').addEventListener('click', function () {
        deleteModal.hide();
    });
    document.querySelector('#deleteMovieModal .btn-secondary').addEventListener('click', function () {
        deleteModal.hide();
    });

    document.getElementById('deleteMovieModal').addEventListener('hidden.bs.modal', function () {
        document.querySelector('.modal-backdrop').remove();
    });
}