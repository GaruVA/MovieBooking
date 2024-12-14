let selectedSeats = [];

function updateSeatCount() {
    const adults = parseInt(document.getElementById("adults").value, 10);
    const children = parseInt(document.getElementById("children").value, 10);
    const totalSeats = adults + children;

    document.getElementById("seatCount").innerText =
            selectedSeats.length + " ticket(s) selected. Please select attendees.";

    const continueButton = document.getElementById("continueButton");
    if (selectedSeats.length === totalSeats) {
        continueButton.disabled = false;
    } else {
        continueButton.disabled = true;
    }
}
function submitSeats() {
    const selectedSeatsInput = document.getElementById('selectedSeatsInput');
    selectedSeatsInput.value = JSON.stringify(selectedSeats); // Pass the list as a JSON string
    console.log(JSON.stringify(selectedSeats));
}

function toggleSeat(seat) {
    const seatId = seat.id;
    console.log(seatId);
    if (seat.classList.contains("selected")) {
        seat.classList.remove("selected");
        selectedSeats = selectedSeats.filter(seat => seat !== seatId); // Remove seat
        // selectedSeats--;
    } else {
        seat.classList.add("selected");
        selectedSeats.push(seatId); // Add seat
        // selectedSeats++;
    }
    updateSeatCount();
}

function handleDropdownChange() {
    updateSeatCount();
}

