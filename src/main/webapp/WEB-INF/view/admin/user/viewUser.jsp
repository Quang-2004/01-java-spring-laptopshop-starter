<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View user</title>
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
    <div class="container mt-5 col-5">
        <h3>Infomation of user</h3> <hr>
        
        <div class="mb-3">
            <label class="form-label">Email: </label>
            <div>${user.getEmail()}</div>
        </div>
        <div class="mb-3">
            <label class="form-label">Pass word: </label>
            <div>${user.getPassword()}</div>
        </div>
        <div class="mb-3">
            <label class="form-label">Phone number: </label>
            <div>${user.getPhoneNumber()}</div>
        </div>
        <div class="mb-3">
            <label class="form-label">Full name: </label>
            <div>${user.getFullName()}</div>
        </div>
        <div class="mb-3">
            <label class="form-label">Address: </label>
            <div>${user.getPassword()}</div>
        </div>
        
    </div>
</body>

</html>