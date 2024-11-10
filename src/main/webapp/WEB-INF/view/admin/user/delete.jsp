<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- <link rel="stylesheet" href="/css/demo.css"> -->
</head>

<body>
    <div class="container mt-5 col-5">
        <h3>Delete the user with ID = ${id}</h3> <hr>
        <div class="alert alert-danger" role="alert">
            Are you sure to delete this user?
        </div>
        <form:form action="/admin/user/delete" method="POST" modelAttribute="newUser">
            <form:input type="hidden" path="id" value="${id}"></form:input>
            <button type="submit" class="btn btn-danger">Confilm</button>
        </form:form>
        
    </div>
</body>

</html>