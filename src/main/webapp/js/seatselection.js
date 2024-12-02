let selectedSeats = 0;

function updateSeatCount() {
    const adults = parseInt(document.getElementById("adults").value, 10);
    const children = parseInt(document.getElementById("children").value, 10);
    const totalSeats = adults + children;

    document.getElementById("seatCount").innerText =
            selectedSeats + " ticket(s) selected. Please select attendees.";

    const continueButton = document.getElementById("continueButton");
    if (selectedSeats === totalSeats) {
        continueButton.disabled = false;
    } else {
        continueButton.disabled = true;
    }
}

function toggleSeat(seat) {
    if (seat.classList.contains("selected")) {
        seat.classList.remove("selected");
        selectedSeats--;
    } else {
        seat.classList.add("selected");
        selectedSeats++;
    }
    updateSeatCount();
}

function handleDropdownChange() {
    updateSeatCount();
}

