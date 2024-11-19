<%@page contentType="text/html" pageEncoding="UTF-8"%>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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

        .footer {
            background-color: var(--primary);
            color: var(--text-light);
            margin-top: auto;
            padding: 2rem 0;
        }

        .footer h5 {
            color: var(--surface);
            margin-bottom: 1rem;
        }

        .footer-link {
            color: var(--text-light);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-link:hover {
            color: var(--accent);
        }

        .social-icon {
            color: var(--text-light);
            font-size: 1.5rem;
            margin-right: 1rem;
            transition: color 0.3s ease;
        }

        .social-icon:hover {
            color: var(--accent);
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