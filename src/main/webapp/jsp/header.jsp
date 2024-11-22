<%@page contentType="text/html" pageEncoding="UTF-8"%>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@2.2.0/fonts/remixicon.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    
</body>
<style>
    .navbar {
        background-color: var(--primary);
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .navbar-brand {
        color: var(--surface) !important;
        font-weight: bold;
        font-size: 1.5rem;
    }

    .nav-link {
        color: var(--text-light) !important;
        transition: color 0.3s ease;
        margin: auto 0;
    }

    .nav-link:hover {
        color: var(--accent) !important;
    }

    .nav-link.active {
        color: var(--surface) !important;
    }

    .btn-book-now {
        background-color: var(--secondary);
        color: var(--surface);
        border: none;
        padding: 0.5rem 1.5rem;
        transition: opacity 0.3s ease;
    }

    .btn-book-now:hover {
        opacity: 0.9;
        color: var(--surface);
    }

    /*footer*/

    .footer {
        background-color: var(--primary);
        color: var(--text-light) !important;
        padding: 40px 20px;
        text-align: center;
        margin-top: 40px;
    }

    .footer .container {
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        max-width: 1200px;
        margin: 0 auto;
    }

    /* Footer Sections */
    .footer-section {
        flex: 1 1 30%;
        margin: 10px;
        text-align: left;
    }

    .footer-section h3 {
        color: var(--surface) !important;
        margin-bottom: 15px;
        font-size: 1.25rem;
    }

    .footer-section p {
        margin: 5px 0;
        line-height: 1.5;
    }

    .footer-links {
        list-style: none;
        padding: 0;
    }

    .footer-links li {
        margin: 10px 0;
    }

    .footer-links a {
        color: var(--text-light) !important;
        text-decoration: none;
        font-size: 1rem;
    }

    .footer-links a:hover {
        color: var(--accent) !important;
        text-decoration: underline;
    }

    /* Social Media Icons */
    .social-icons {
        display: flex;
        gap: 15px;
        justify-content: flex-start;
    }

    .social-icons img {
        width: 30px;
        height: 30px;
        transition: transform 0.3s;
    }

    .social-icons img:hover {
        transform: scale(1.2);
    }

    /* Footer Bottom */
    .footer-bottom {
        margin-top: 20px;
        border-top: 1px solid var(--secondary);
        padding-top: 15px;
        font-size: 0.9rem;
        color: var(--surface) !important;
    }

    /* Responsive Design */
    @media (max-width: 768px) {
        .footer .container {
            flex-direction: column;
            text-align: center;
        }

        .footer-section {
            margin-bottom: 20px;
        }

        .social-icons {
            justify-content: center;
        }
    }
</style>
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container">
            <a class="navbar-brand" href="#">ABC Cinema</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Movies</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Schedule</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">About</a>
                    </li>
                </ul>
                <div class="d-flex gap-3">
                    <a href="#" class="nav-link">Login</a>
                    <a href="#" class="btn btn-book-now">Book Now</a>
                </div>
            </div>
        </div>
    </nav>
</body>