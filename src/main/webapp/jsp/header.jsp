<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <!-- Font Awesome CDN for star icon -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
        <!-- Common styles for header and footer -->
        <link href="css/common.css" rel="stylesheet">
        <!-- Allow for page-specific CSS -->
    <c:if test="${not empty param.css}">
        <link href="css/${param.css}" rel="stylesheet">
    </c:if>
</head>
<body class="bg-gray-900 text-gray-100">
    <!-- Header content here -->
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark sticky-top bg-gray-800">
            <div class="container">
                <a class="navbar-brand" href="./"><img src="./images/ABC.png" alt="ABC Cinema" height="50px"></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link ${param.activePage == 'home' ? 'active' : ''}" href="./">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.activePage == 'movies' ? 'active' : ''}" href="./movies">Movies</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.activePage == 'theatres' ? 'active' : ''}" href="./theatres">Theatres</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${param.activePage == 'feedback' ? 'active' : ''}" href="./feedback">Feedback</a>
                        </li>
                        <c:if test="${sessionScope.role == 'admin'}">
                            <li class="nav-item">
                                <a class="nav-link ${param.activePage == 'admin' ? 'active' : ''}" href="./admin">Analytics</a>
                            </li>
                        </c:if>
                    </ul>
                    <div class="d-flex gap-3">
                        <a href="./booking-selection" class="btn btn-book-now">Book Now</a>
                        <c:choose>
                            <c:when test="${sessionScope.user_id == null}">
                                <a href="./login" class="nav-link ${param.activePage == 'login' ? 'active' : ''}">Login</a>
                            </c:when>
                            <c:otherwise>
                                <a href="./account" class="nav-link ${param.activePage == 'account' ? 'active' : ''}">My Account</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>
    </header>
    <!-- Main content container starts -->
    <main>