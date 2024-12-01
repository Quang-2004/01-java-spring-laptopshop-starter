<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <link rel="stylesheet" href="/client/css/login.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="auth">
    <div class="auth-container">
        <div class="auth-box">
            <h2>Create Your Account!</h2>
            <p class="subtitle">Sign up to get started with us.</p>
            <form:form action="/register" method="POST" modelAttribute="registerUser">

               
                <c:set var="errorEmail">
                    <form:errors cssClass="invalid-feedback" path="email" />
                </c:set>
                <c:set var="errorPassword">
                    <form:errors cssClass="invalid-feedback" path="password" />
                </c:set>
                <c:set var="errorConFirmPassword">
                    <form:errors cssClass="invalid-feedback" path="confirmPassword" />
                </c:set>

                <div class="form-row">
                    <!-- First Name and Last Name -->
                    <div class="form-floating">
                        <c:set var="errorFirstName">
                            <form:errors cssClass="invalid-feedback" path="firstName" />
                        </c:set>

                        <form:input type="text" class="form-control ${not empty errorFirstName ? 'is-invalid' : ''}" 
                            path="firstName" />
                        <label for="firstName">First name</label>
                        ${errorFirstName}

                    </div>
                    <div class="form-floating">
                        <form:input type="text" class="form-control" 
                            path="lastName" />
                        <label for="lastName">Last name</label>
                    </div>
                </div>

                <!-- Email Address -->
                <div class="form-floating">
                    <form:input type="email" class="form-control ${not empty errorEmail ? 'is-invalid' : ''}" 
                        path="email" />
                    <label for="email">Email address</label>
                    ${errorEmail}
                </div>

                <!-- Password and Confirm Password -->
                <div class="form-row">
                    <div class="form-floating">
                        <form:input type="password" class="form-control ${not empty errorPassword ? 'is-invalid' : ''}" 
                            path="password" />
                        <label for="password">Password</label>
                        ${errorPassword}
                    </div>

                    <div class="form-floating">
                        <form:input type="password" class="form-control ${not empty errorConFirmPassword ? 'is-invalid' : ''}"  
                            path="confirmPassword" />
                        <label for="confirmPassword">Confirm Password</label>
                        ${errorConFirmPassword}
                    </div>
                </div>

                <button type="submit" class="btn btn-primary mt-3">Sign Up</button>
            </form:form>
            <p class="switch mt-3">
                Already have an account? 
                <a href="/login" class="transition-link">Login</a>
            </p>
        </div>
    </div>
</body>
</html>
