</main>
<!-- Footer content -->
<footer class="footer">
    <div class="container">
        <!-- Contact Info -->
        <div class="footer-section">
            <h3>Contact Us</h3>
            <p>Address: 123 ABC Cinema Lane, <br> Movie City</p>
            <p>Phone: +94 234 567 890</p>
            <p>Email: info@abccinema.com</p>
        </div>

        <!-- Links -->
        <div class="footer-section">
            <h3>Links</h3>
            <ul class="footer-links">
                <li><a href="index">Home</a></li>
                <li><a href="movies">Movies</a></li>
                <li><a href="#">Theatres</a></li>
                <li><a href="#">About Us</a></li>
                <li><a href="#">Contact Us</a></li>
            </ul>
        </div>

        <!-- Social Media -->
        <div class="footer-section">
            <h3>Follow Us</h3>
            <div class="social-icons">
                <a href="https://www.facebook.com/"><img src="./images/facebook.png" alt="Facebook"></a>
                <a href="https://www.twitter.com/"><img src="./images/twitter.png" alt="Twitter"></a>
                <a href="https://www.instagram.com/"><img src="./images/instagram.png" alt="Instagram"></a>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2024 ABC Cinema | All rights reserved</p>
    </div>
</footer>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- Common JavaScript -->
<script src="js/common.js"></script>
<!-- Allow for page-specific JavaScript -->
<c:if test="${not empty param.js}">
    <script src="js/${param.js}"></script>
</c:if>
</body>
</html>