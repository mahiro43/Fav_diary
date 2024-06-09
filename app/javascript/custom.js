document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll('.img-thumbnail').forEach(item => {
      item.addEventListener('click', event => {
        const imageUrl = item.getAttribute('src');
        document.getElementById('modalImage').setAttribute('src', imageUrl);
        $('#imageModal').modal('show');
      })
    });
  });
