var data;

fetch('data.json')
  .then(response => {

    if (!response.ok) {
      throw new Error(`Помилка при отриманні файлу: ${response.status}`);
    }

    return response.json();
  })
  .then(jsonData => {

    data = jsonData;
    console.log(data);

  })
  .catch(error => {
    // Обробка помилок
    console.error('Помилка:', error);
  });

function getSuggestions() {
  var input = document.getElementById('searchInput').value.trim().toLowerCase();
  var suggestionsList = document.getElementById('suggestionsList');

  if (input === '') {
    suggestionsList.innerHTML = '';
    return;
  }

  if (!data) {
    console.error('Дані не доступні');
    return;
  }

  suggestionsList.innerHTML = '';

  data.forEach(function (item) {
    if (item.Name.toLowerCase().includes(input)) {
      var li = document.createElement('li');
      li.textContent = item.Name;
      suggestionsList.appendChild(li);

      li.addEventListener('click', function () {
        document.getElementById('searchInput').value = this.textContent;
        suggestionsList.innerHTML = '';
      });
    }
  });
}

document.addEventListener('DOMContentLoaded', function () {
  var searchInput = document.getElementById('searchInput');
  var suggestionsList = document.getElementById('suggestionsList');

  searchInput.addEventListener('focus', function () {
    suggestionsList.style.display = 'block';
  });

  searchInput.addEventListener('input', function () {
    suggestionsList.style.display = 'block';
  });
});