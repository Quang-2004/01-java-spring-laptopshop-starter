<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="" />
                    <meta name="author" content="" />
                    <title>Update Order - Table Orders</title>
                    <link href="/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
                                    <h1 class="mt-4">Manage Orders</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item active">
                                            <a href="/admin">Dashboard</a> /
                                            <a href="/admin/order">Orders</a> /
                                            Update
                                        </li>
                                    </ol>
                                    <div class="container col-6">
                                        <h3>Update a order</h3>
                                        <hr>
                                        <label class="form-label">Order id = ${order.id} 
                                            Price:  <fmt:formatNumber type="number"
                                            value="${order.totalPrice}" /> đ</label> <br>
                                        <form:form action="/admin/order/update" method="POST" modelAttribute="order">
                                            <form:input type="hidden" path="id" />
                                            <div class="row">
                                                <div class="mb-3 col-6">
                                                    
                                                    <label class="form-label">User: </label>

                                                    <form:input type="text" disabled="true"
                                                        class="form-control ${not empty errorName ? 'is-invalid': ''}"
                                                        path="receiverName" />

                                                </div>
                                                <div class="mb-3 col-6">
                                                    <label class="form-label">Status: </label>
                                                    <form:select class="form-select" path="status">
                                                        <option></option>
                                                        <form:option value="PENDING">PENDING</form:option>
                                                        <form:option value="SHIPPING">SHIPPING</form:option>
                                                        <form:option value="COMPLATE">COMPLATE</form:option>
                                                        <form:option value="CANCEL">CANCEL</form:option>
                                                    </form:select>
                                                </div>
                                            </div>


                                            <div class="row">
                                                <label class="form-label"></label>
                                                <button type="submit" class="btn btn-warning">Update</button>
                                            </div>
                                        </form:form>
                                    </div>

                                </div>

                            </main>
                            <!-- FOOTER -->
                            <jsp:include page="../layout/footer.jsp"></jsp:include>
                        </div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                        crossorigin="anonymous"></script>
                    <script src="/js/scripts.js"></script>
                </body>

                </html>