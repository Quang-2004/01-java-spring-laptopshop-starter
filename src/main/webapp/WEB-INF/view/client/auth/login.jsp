<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="/client/css/login.css">
</head>
<body class="auth">
    <div class="auth-container">
        <div class="auth-box">
            <h2>Welcome Back!</h2>
            <p class="subtitle">Please log in to your account.</p>
            <form method="POST" action="/login">
                <input type="email" placeholder="Email" required />
                <input type="password" placeholder="Password" required />
                <button type="submit">Login</button>
            </form>
            <p class="switch">
                Don’t have an account? 
                <a href="/register" class="transition-link">Sign Up</a>
            </p>
        </div>
    </div>
</body>
</html>
