var nameElement = document.getElementById('name');
var sugarElement = document.getElementById('sugar');
var ratingElement = document.getElementById('rating');

var promise1 = new Promise(function(resolve, reject) {
  var xhr = new XMLHttpRequest(),
    method = "GET",
    url = "https://beverage-api.onrender.com/api/beverages/get/653165e3718ee8811bfd6cc2";

  xhr.open(method, url, true);
  xhr.onreadystatechange = function() {
    if (xhr.readyState === 4 && xhr.status === 200) {
      resolve(JSON.parse(xhr.responseText));
    }
  };
  xhr.send();
});

promise1.then(function(value) {
  nameElement.textContent = value.name;
  sugarElement.textContent = value.sugar;
  ratingElement.textContent = value.rating;

});
