
<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title>Laptopshop - Information of User</title>
                    <meta content="width=device-width, initial-scale=1.0" name="viewport">
                    <meta content="" name="keywords">
                    <meta content="" name="description">

                    <!-- Google Web Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet">

                    <!-- Icon Font Stylesheet -->
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <!-- Libraries Stylesheet -->
                    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


                    <!-- Customized Bootstrap Stylesheet -->
                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                    <!-- Template Stylesheet -->
                    <link href="/client/css/style.css" rel="stylesheet">
                    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/sidebars/">
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

                <body>
                    <!-- Spinner Start -->
                    <div id="spinner"
                        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                        <div class="spinner-grow text-primary" role="status"></div>
                    </div>
                    <!-- Spinner End -->

                    <jsp:include page="../layout/header.jsp" />
                    <div class="container-fluid mt-5 pt-5">


                        <div class="container col-6 m-auto">
                            <h3>Thông tin tài khoản</h3>
                            <hr>
                            <form:form action="/account/my-profile" method="POST" modelAttribute="updateUser"
                                enctype="multipart/form-data">

                                <c:set var="errorFullname">
                                    <form:errors path="fullName" cssClass="invalid-feedback" />
                                </c:set>

                                <div class="mb-3" style="display: none;">
                                    <form:input type="text" class="form-control" path="id" />
                                </div>
                                <div class="mb-3" style="display: none;">
                                    <form:input type="text" class="form-control" path="password" />
                                </div>


                                <div class="mb-3">
                                    <label class="form-label">Email: </label>
                                    <form:input type="email" class="form-control" path="email" disabled="true" />
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Số điện thoại: </label>
                                    <form:input type="text" class="form-control" path="phoneNumber" />
                                </div>
                                <div class="mb-3">
                                    <c:set var="errorFullname">
                                        <form:errors cssClass="invalid-feedback" path="fullName" />
                                    </c:set>

                                    <label class="form-label">Họ và tên: </label>
                                    <form:input type="text"
                                        class="form-control ${not empty errorFullname ? 'is-invalid' : ''}"
                                        path="fullName" />
                                    ${errorFullname}
                                </div>

                                <div class="mb-3 col-6">
                                    <label for="avatarFile" class="form-label">Avatar: </label>
                                    <input type="file" class="form-control" id="avatarFile" name="avatarPreview" 
                                        accept=".png, .jpg, .jpeg"/>	
                                </div>


                                <div class="row">
                                    <div class="col-6">
                                        <c:if test="${not empty updateUser.avatar}">
                                            <img id="avatarPreview" style="max-height: 250px;" 
                                            src="/images/avatar/${updateUser.avatar}" 
                                             alt="Avatar Image">
                                        </c:if>
                                        <c:if test="${empty updateUser.avatar}">
                                            <img id="avatarPreview" style="max-height: 250px;" 
                                            src="/images/avatar/defaut-avatar.jpg" 
                                             alt="Avatar Image">
                                        </c:if>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Lưu</button>
                                </div>

                            </form:form>
                        </div>

                    </div>
                    <jsp:include page="../layout/footer.jsp" />
                    <!-- Back to Top -->
                    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                            class="fa fa-arrow-up"></i></a>


                    <!-- JavaScript Libraries -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
                    
                    <!-- Template Javascript -->
                    <script src="/client/js/main.js"></script>
                </body>
