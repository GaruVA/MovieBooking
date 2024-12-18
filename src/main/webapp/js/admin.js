// document.addEventListener('DOMContentLoaded', function() {
//     console.log('Admin panel loaded');

//     // Sales data chart
//     const salesData = [
//         // Example data: ["2023-10-01,1000.0", "2023-10-02,1500.0"]
//         // Replace with actual data from the server
//         <% for (String data : (List<String>) request.getAttribute("salesData")) { %>
//             "<%= data %>",
//         <% } %>
//     ];

//     const labels = salesData.map(data => data.split(',')[0]);
//     const sales = salesData.map(data => parseFloat(data.split(',')[1]));

//     const ctx = document.getElementById('salesChart').getContext('2d');
//     new Chart(ctx, {
//         type: 'line',
//         data: {
//             labels: labels,
//             datasets: [{
//                 label: 'Total Sales',
//                 data: sales,
//                 borderColor: 'rgba(75, 192, 192, 1)',
//                 backgroundColor: 'rgba(75, 192, 192, 0.2)',
//                 borderWidth: 1
//             }]
//         },
//         options: {
//             scales: {
//                 y: {
//                     beginAtZero: true
//                 }
//             }
//         }
//     });
// });
