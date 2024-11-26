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
        <title>Delete Product</title>
        <link href="/css/styles.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>
            .myLink {
                text-decoration: none;
                color: white;
            }
        </style>
    </head>
    <body class="sb-nav-fixed">
        <!-- HEADER -->
        <jsp:include page="../layout/header.jsp"></jsp:include>
        <div id="layoutSidenav">
            <jsp:include page="../layout/sidebar.jsp"></jsp:include>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Manage Products</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active">
                                <a href="/admin">Dashboard</a> / 
                                <a href="/admin/product">Product</a> /
                                Delete </li>
                        </ol>
                        <h3>Delete the product with ID = ${id}</h3> <hr>
                        <div class="alert alert-danger" role="alert">
                            Are you sure to delete this product?
                        </div>
                        <form:form action="/admin/product/delete" method="POST" modelAttribute="newProduct">
                            <form:input type="hidden" path="id" value="${id}"></form:input>
                            <button type="submit" class="btn btn-danger">Confilm</button>
                        </form:form>
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
