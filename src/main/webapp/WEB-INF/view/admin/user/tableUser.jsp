<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Table user</title>
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .myLink {
            text-decoration: none;
            color: white;
        }
    </style>
</head>
<body>
    
    <div class="container mt-5">
        <div class="row">
            <div class="col-12 mx-auto">
                <div class="d-flex justify-content-between">
                    <h2>Table User</h2>
                    <button type="button" class="btn btn-primary"><a href="/admin/user/create" class="myLink">Create a user</a></button> 
                    
                </div>
                <hr>
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                          <th scope="col">ID</th>
                          <th scope="col">Email</th>
                          <th scope="col">Full Name</th>
                          <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <c:forEach var="user" items="${listUsers}">
                        <tbody>
                            <tr>
                              <th scope="row">${user.getId()}</th>
                              <td>${user.getEmail()}</td>
                              <td>${user.getFullName()}</td>
                              <td>
                                <button type="button" class="btn btn-success"><a href="/admin/user/informationUser?idUser=user.getId" class="myLink">View</a></button>
                                <button type="button" class="btn btn-warning"><a href="/admin/user/updateUser?idUser=user.getId" class="myLink">Update</a></button> 
                                <button type="button" class="btn btn-danger"><a href="/admin/user/deleteUser?idUser=user.getId" class="myLink">Delete</a></button>
                              </td>
                            </tr>
                        </tbody>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
</body>
</html>