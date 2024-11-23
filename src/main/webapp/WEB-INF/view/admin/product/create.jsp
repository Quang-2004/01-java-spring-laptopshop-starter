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
        <title>Create a product</title>
        <link href="/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            $(document).ready(() => {
                const image = $("#image");
                image.change(function (e) {
                    const imgURL = URL.createObjectURL(e.target.files[0]);
                    $("#productPreview").attr("src", imgURL);
                    $("#productPreview").css({ "display": "block" });
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
                        <h1 class="mt-4">Create Product</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active"><a href="/admin">Dashboard</a> / Create Product</li>
                        </ol>
                        <div class="container col-6">
                            <h3>Create a product</h3> <hr>
                            <form:form action="/admin/product/create" method="POST" modelAttribute="newProduct"
                                enctype="multipart/form-data">
                                <div class="row">
                                    <div class="mb-3 col-6">
                                        <label class="form-label">Name: </label>
                                        <form:input type="text" class="form-control" path="name"/>
                                    </div>
                                    <div class="mb-3 col-6">
                                        <label class="form-label">Price: </label>
                                        <form:input type="number" class="form-control" path="price"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="mb-3">
                                        <label class="form-label">Detail description: </label>
                                        <form:textarea class="form-control" path="detailDesc"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="mb-3 col-6">
                                        <label class="form-label">Short description: </label>
                                        <form:input type="text" class="form-control" path="shortDesc"/>
                                    </div>
                                    <div class="mb-3 col-6">
                                        <label class="form-label">Quantity: </label>
                                        <form:input type="number" class="form-control" path="quantity"/>
                                    </div>
                                </div>
                                
                                <div class="row">
                                    <div class="mb-3 col-6">
                                        <label class="form-label">Factory: </label>
                                        <form:select class="form-select" path="factory">
                                            <form:option value="APPLE">Apple (MacBook)</form:option>
                                            <form:option value="ASUS">Asus</form:option>
                                            <form:option value="LEVONO">Lenovo</form:option>
                                            <form:option value="DELL">Dell</form:option>
                                            <form:option value="SAMSUNG">Samsung</form:option>
                                            <form:option value="LG">LG</form:option>
                                            <form:option value="ACER">Acer</form:option>
                                            <form:option value="MSI">MSI</form:option>
                                            <form:option value="MICROSOFT">Microsoft</form:option>
                                            <form:option value="RAZER">Razer</form:option>
                                            <form:option value="HUAWEI">Huawei</form:option>
                                            <form:option value="HP">HP</form:option>
                                        </form:select>
                                    </div>
                                    <div class="mb-3 col-6">
                                        <label class="form-label">Target: </label>
                                        <form:select class="form-select" path="target">
                                            <form:option value="GAMMING">Gamming</form:option>
                                            <form:option value="SINHVIEN-VANPHONG">Sinh viên - Văn phòng</form:option>
                                            <form:option value="THIET-KE-DO-HOA">Thiết kế đồ họa</form:option>
                                            <form:option value="MONG-NHE">Mỏng nhẹ</form:option>
                                            <form:option value="DOANH-NHAN">Doanh nhân</form:option>
                                        </form:select>
                                    </div>
                                    
                                </div>
                                <div class="row">
                                    <div class="mb-3 col-6">
                                        <label for="image" class="form-label">Image: </label>
                                        <input type="file" class="form-control" id="image" name="imageFile" 
                                            accept=".png, .jpg, .jpeg"/>	
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-6">
                                        <img style="max-height: 250px; display: none;" alt="product preview"
                                            id="productPreview">
                                    </div>
                                </div>
                                <div class="row">
                                    <label class="form-label"></label>
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </div>
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
