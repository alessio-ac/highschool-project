window.addEventListener("DOMContentLoaded", function() {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            document.getElementById("navbarContainer").innerHTML = xhr.responseText;
        }
    };
    xhr.open("GET", "nav.html", true);
    xhr.send();
});
