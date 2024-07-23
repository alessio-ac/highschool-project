function openTab(event, tabId) {
    // Hide all tab content
    var tabContents = document.getElementsByClassName("tab-content");
    for (var i = 0; i < tabContents.length; i++) {
        tabContents[i].style.display = "none";
    }

    // Remove active class from all tab buttons
    var tabButtons = document.getElementsByClassName("tab-button");
    for (var i = 0; i < tabButtons.length; i++) {
        tabButtons[i].className = tabButtons[i].className.replace(" active", "");
    }

    // Show the selected tab content
    document.getElementById(tabId).style.display = "block";

    // Add active class to the clicked tab button
    event.currentTarget.className += " active";
}

// Set the default tab on page load
document.getElementById("tab1").style.display = "block";
document.getElementsByClassName("tab-button")[0].className += " active";
