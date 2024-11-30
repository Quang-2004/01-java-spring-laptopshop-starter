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
            <form:form method="POST" action="/register" modelAttribute="registerUser">

                <c:set var="errorEmail">
                    <form:errors cssClass="invalid-feedback" path="email" />
                </c:set>
                <c:set var="errorPassword">
                    <form:errors cssClass="invalid-feedback" path="password" />
                </c:set>
                <c:set var="errorConFirmPassword">
                    <form:errors cssClass="invalid-feedback" path="confirmPassword" />
                </c:set>

                <form:input path="firstName" placeholder="First Name" cssClass="form-control" required="true" />


                <form:input path="lastName" placeholder="Last Name" cssClass="form-control" required="true" />


                <form:input path="email" placeholder="Email" 
                    cssClass="form-control ${not empty errorEmail ? 'is-invalid' : ''}" required="true" />
                ${errorEmail}

                <form:input path="password" placeholder="Password" 
                    cssClass="form-control  ${not empty errorPassword ? 'is-invalid' : ''}" type="password" required="true" />
                ${errorPassword}
                
                <form:input path="confirmPassword" placeholder="Confirm Password" 
                    cssClass="form-control ${not empty errorConFirmPassword ? 'is-invalid' : ''}" type="password" required="true" />
                ${errorConFirmPassword}
                
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
