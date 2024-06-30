var ratingElement = document.getElementById('rating');

var promise1 = new Promise(function(resolve, reject) {
    var xhr = new XMLHttpRequest(),
      method = "GET",
      url = "https://beverage-api.onrender.com/api/beverages/get/653165a2718ee8811bfd6cc0";
  
    xhr.open(method, url, true);
    xhr.onreadystatechange = function() {
      if (xhr.readyState === 4 && xhr.status === 200) {
        resolve(JSON.parse(xhr.responseText));
      }
    };
    xhr.send();
  });

promise1.then(function(value) {
    ratingElement.textContent = value.rating;
  
});

function rate(x) {
    var obj;

    fetch("https://beverage-api.onrender.com/api/beverages/get/653165a2718ee8811bfd6cc0")
    .then(res => res.json())
    .then(data => {
        obj = data;
        obj.rating = x
        obj.scanned = "true"
        ratingElement.textContent = x;
        fetch("https://beverage-api.onrender.com/api/beverages/update/653165a2718ee8811bfd6cc0", {
            method: 'PUT',
            headers: {
              'Content-Type': 'application/json'
            },
            body: JSON.stringify(obj)
          })
          .then(response => {
            if(response.ok) {
              return response;
            } else {
                var error = new Error('Error- ' + response.status + ":" + response.statusText);
                error.response = response;
                throw error;
            }
          },
          error => {
            var errmess = new Error(error.message);
            throw errmess;
          })
          .then(response => response.json())
          .then(response => {console.log("response:"+JSON.stringify(response));})
          .catch(error => {console.log('Error Message: '+ error.message);
          });
    })
    .then(() => {
        console.log(obj);
    });
    
} 






