// snowflakes.js
const snowflakeCount = 100; // Number of snowflakes
const snowflakeContainer = document.body;

for (let i = 0; i < snowflakeCount; i++) {
    const snowflake = document.createElement('div');
    snowflake.className = 'snowflake';
    snowflake.innerHTML = '❄'; // Snowflake character
    snowflake.style.left = Math.random() * 100 + 'vw'; // Random horizontal position
    snowflake.style.animationDuration = Math.random() * 3 + 2 + 's'; // Random fall duration
    snowflake.style.opacity = Math.random(); // Random opacity
    snowflakeContainer.appendChild(snowflake);

    // Remove snowflake after it falls
    snowflake.addEventListener('animationend', () => {
        snowflake.remove();
    });
}