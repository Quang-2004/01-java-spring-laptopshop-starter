<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Update User - Table Users</title>
        <link href="/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <style>
            .myLink {
                text-decoration: none;
                color: white;
            }
        </style>
        <script>
            $(document).ready(() => {
                const avatarFile = $("#avatarFile");
                avatarFile.change(function (e) {
                    const imgURL = URL.createObjectURL(e.target.files[0]);
                    $("#avatarPreview").attr("src", imgURL);
                    $("#avatarPreview").css({ "display": "block" });
                });
            });
        </script>
    </head>
    <body class="sb-nav-fixed">
        <!-- HEADER -->
        <jsp:include page="../layout/header.jsp"></jsp:include>
        <div id="layoutSidenav">
            <jsp:include page="../layout/sidebar.jsp"></jsp:include>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Manage Users</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active"><a href="/admin">Dashboard</a> / Users</li>
                        </ol>
                        <div class="container col-6">
                            <h3>Update a user</h3> <hr>
                            <form:form action="/admin/user/update" method="POST" modelAttribute="newUser"
                                enctype="multipart/form-data">
                                <div class="mb-3" style="display: none;">
                                    <label class="form-label">Id: </label>
                                    <form:input type="text" class="form-control" path="Id"/>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Email: </label>
                                    <form:input type="email" class="form-control" path="email" disabled="true"/>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Phone number: </label>
                                    <form:input type="text" class="form-control" path="phoneNumber"/>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Full name: </label>
                                    <form:input type="text" class="form-control" path="fullName"/>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Address: </label>
                                    <form:input type="text" class="form-control" path="address"/>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Role: </label>
                                    <form:select class="form-select" path="role.name">
                                        <form:option value="USER">USER</form:option>
                                        <form:option value="ADMIN">ADMIN</form:option>
                                    </form:select>
                                </div>
                                <div class="mb-3">
                                    <label for="avatarFile" class="form-label">Avatar: </label>
                                    <input type="file" class="form-control" id="avatarFile" name="hoidanitFile"
                                        accept=".png, .jpg, .jpeg"/>
                                </div>
                                <div class="row">
                                    <div class="col-6">
                                        <img style="max-height: 250px; display: none;" alt="avatar preview"
                                            id="avatarPreview">
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary">Update</button>
                            </form:form>
                        </div>
                        
                    </div>
                    
                </main>
                <!-- FOOTER -->
                <jsp:include page="../layout/footer.jsp"></jsp:include>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/js/scripts.js"></script>
    </body>
</html>
