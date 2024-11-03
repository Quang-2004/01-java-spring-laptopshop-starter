<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>User detail</title>
                <!-- Latest compiled and minified CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            </head>

            <body>
                <div class="container mt-5">
                    <h3>User detail</h3>
                    <hr>
                    <div class="card" style="width: 60%;">
                        <div class="card-header">
                            Infomation of user
                        </div>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">Id: ${user.getId()}</li>
                            <li class="list-group-item">Email: ${user.getEmail()}</li>
                            <li class="list-group-item">Password: ${user.getPassword()}</li>
                            <li class="list-group-item">Phone number: ${user.getPhoneNumber()}</li>
                            <li class="list-group-item">Full name: ${user.getFullName()}</li>
                            <li class="list-group-item">Address: ${user.getPassword()}</li>
                        </ul>
                    </div>
                </div>
            </body>

            </html>