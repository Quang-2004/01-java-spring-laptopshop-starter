<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8">
                <title>Laptopshop - Checkout</title>
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
                <link href="/client/css/empty-cart.css" rel="stylesheet">
            </head>

            <body>

                <!-- Spinner Start -->
                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>
                <!-- Spinner End -->

                <jsp:include page="../layout/header.jsp" />



                <div class="container py-5 mt-lg-5 ">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Thông tin thanh toán</li>
                    </ol>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Sản phẩm</th>
                                    <th scope="col">Tên sản phẩm</th>
                                    <th scope="col">Giá</th>
                                    <th scope="col">Số lượng</th>
                                    <th scope="col">Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cartDetail" items="${cartDetails}">

                                    <tr>
                                        <th scope="row">
                                            <div class="d-flex align-items-center">
                                                <img src="/images/product/${cartDetail.product.image}"
                                                    class="img-fluid me-5 rounded-circle"
                                                    style="width: 80px; height: 80px;" alt="">
                                            </div>
                                        </th>
                                        <td>
                                            <p class="mb-0 mt-4">
                                                <a href="/product/${cartDetail.product.id}" target="_blank">
                                                    ${cartDetail.product.name}
                                                </a>
                                            </p>
                                        </td>
                                        <td>
                                            <p class="mb-0 mt-4">
                                                <fmt:formatNumber type="number" value="${cartDetail.price}" /> đ
                                            </p>
                                        </td>
                                        <td>
                                            <div class="input-group quantity mt-4" style="width: 100px;">

                                                <input type="text" disabled="true"
                                                    class="form-control form-control-sm text-center border-0"
                                                    value="${cartDetail.quantity}"
                                                    data-cart-detail-id="${cartDetail.id}"
                                                    data-cart-detail-price="${cartDetail.price}">

                                            </div>
                                        </td>
                                        <td>
                                            <p class="mb-0 mt-4" data-cart-detail-id="${cartDetail.id}">
                                                <fmt:formatNumber type="number"
                                                    value="${cartDetail.price * cartDetail.quantity}" /> đ
                                            </p>
                                        </td>

                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <c:if test="${not empty cartDetails}">
                        <form action="/place-order" method="POST" modelAtribute="cart">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <div class="row g-4 mt-5">
                                <div class="col-md-6">
                                    <div class="container-fluid">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="container py-3 mt-2">
                                                    <div class="card">
                                                        <div class="card-body cart">
                                                            <div class="col-sm-12 empty-cart-cls text-center">
                                                                <svg xmlns="http://www.w3.org/2000/svg" width="32"
                                                                    height="32" fill="currentColor" style="color: red;"
                                                                    class="bi bi-geo-alt-fill" viewBox="0 0 16 16">
                                                                    <path
                                                                        d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10m0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6" />
                                                                </svg>
                                                                <span style="color: red;">Địa chỉ nhận hàng</span> <br>
                                                                <c:if test="${empty myAddress}">
                                                                    <a href="/account/add-address"><i class="bi bi-plus"></i> <span>Thêm địa chỉ</span></a>
                                                                </c:if>
                                                                <c:if test="${not empty myAddress}">
                                                                    <span>${myAddress.receiverName}(${myAddress.receiverPhone}) ${myAddress.receiverAddress}</span> <br>
                                                                    <a href="/account/change-address"><i class="bi bi-plus"></i> <span>Thay đổi</span></a>
                                                                </c:if>
                                                                
                                                            </div>
                                                        </div>
                                                        
                                                    </div>
                                                    <i class="bi bi-arrow-left"></i>
                                                        <a href="/cart">Quay lại giỏ hàng</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6 justify-content-end d-block">
                                    <div class="bg-light rounded">
                                        <div class="p-4">
                                            <h1 class="display-6 mb-4">Thông Tin <span class="fw-normal">Đơn Hàng</span>
                                            </h1>
                                            <div class="d-flex justify-content-between mb-4">
                                                <h5 class="mb-0 me-4">Tạm tính:</h5>
                                                <p class="mb-0" data-cart-total-price="${totalPrice}">
                                                    <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                                </p>
                                            </div>
                                            <div class="d-flex justify-content-between">
                                                <h5 class="mb-0 me-4">Phí vận chuyển</h5>
                                                <div class="">
                                                    <p class="mb-0">0 đ</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                            <h5 class="mb-0 ps-4 me-4">Tổng số tiền</h5>
                                            <p class="mb-0 pe-4" data-cart-total-price="${totalPrice}">
                                                <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                            </p>
                                        </div>

                                        <button
                                            class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4"
                                            type="submit">Xác nhận thanh toán</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </c:if>






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

            </html>