<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>${param.title}</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/remixicon@2.2.0/fonts/remixicon.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Common styles for header and footer -->
        <link href="css/common.css" rel="stylesheet">
        <!-- Allow for page-specific CSS -->
    <c:if test="${not empty param.css}">
        <link href="css/${param.css}" rel="stylesheet">
    </c:if>
</head>
<body>
    <!-- Header content here -->
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
            <div class="container">
                <a class="navbar-brand" href="#">ABC Cinema</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="./index.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Movies</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Theatres</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">About</a>
                        </li>
                    </ul>
                    <div class="d-flex gap-3">
                        <a href="#" class="nav-link">Login</a>
                        <a href="./booking-selection.jsp" class="btn btn-book-now">Book Now</a>
                    </div>
                </div>
            </div>
        </nav>
    </header>
    <!-- Main content container starts -->
    <main>