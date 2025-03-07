<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Trang chủ - Laptopshop</title>

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

                <meta name="_csrf" content="${_csrf.token}" />
                <!-- default header is X-CSRF_TOKEN-->
                <meta name="_csrf_header" content="${_csrf.headerName}" />
                <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"
                    rel="stylesheet">


                <style>
                    .myButton:hover,
                    .my-button.active {
                        background-color: rgba(234, 159, 53, 0.8) !important;
                    }

                    .page-link.disabled {
                        color: var(--bs-pagination-disabled-color);
                        pointer-events: none;
                        background-color: var(--bs-pagination-disabled-color);
                    }
                </style>
            </head>

            <body>

                <!-- Spinner Start -->
                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>
                <!-- Spinner End -->

                <jsp:include page="../layout/header.jsp" />


                <jsp:include page="../layout/banner.jsp" />


                <!-- Fruits Shop Start-->
                <div class="container-fluid fruite py-5">
                    <div class="container py-5">
                        <div class="tab-class text-center">
                            <div class="row g-4">
                                <div class="col-lg-4 text-start">
                                    <h1>Sản phẩm nổi bật</h1>
                                </div>
                                <div class="col-lg-8 text-end" id="clickButton">
                                    <ul class="nav nav-pills d-inline-flex text-center mb-5">
                                        <form action="/" method="get">
                                            <li class="nav-item">
                                                <button class="d-flex py-2 m-2 bg-light rounded-pill myButton"
                                                    data-bs-toggle="pill">
                                                    <span class="text-dark" style="width: 130px;">All Products</span>
                                                </button>
                                            </li>
                                        </form>
                                        <form action="/" method="get">
                                            <input type="hidden" name="categoryName" value="laptop">
                                            <li class="nav-item">
                                                <button class="d-flex py-2 m-2 bg-light rounded-pill myButton"
                                                    data-bs-toggle="pill">
                                                    <span class="text-dark" style="width: 130px;">Laptop</span>
                                                </button>
                                            </li>
                                        </form>
                                        <form action="/" method="get">
                                            <input type="hidden" name="categoryName" value="phu_kien">
                                            <li class="nav-item">
                                                <button class="d-flex py-2 m-2 bg-light rounded-pill myButton"
                                                    data-bs-toggle="pill">
                                                    <span class="text-dark" style="width: 130px;">Phụ kiện</span>
                                                </button>
                                            </li>
                                        </form>


                                    </ul>
                                </div>
                            </div>
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane fade show p-0 active">
                                    <div class="row g-4">
                                        <div class="col-lg-12">
                                            <div class="row g-4">
                                                <c:forEach var="product" items="${products}">
                                                    <div class="col-md-6 col-lg-4 col-xl-3">
                                                        <div class="rounded position-relative fruite-item">
                                                            <div class="fruite-img">
                                                                <a href="/product/${product.id}">
                                                                    <img src="/images/product/${product.getImage()}"
                                                                        class="img-fluid w-100 rounded-top" alt=""></a>
                                                            </div>
                                                            <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                                style="top: 10px; left: 10px;">
                                                                ${product.category.content}</div>
                                                            <div
                                                                class="p-4 border border-secondary border-top-0 rounded-bottom text-start">
                                                                <h4 style="font-size: 15px">${product.name}</h4>
                                                                <p style="display: -webkit-box;
                                                                    -webkit-line-clamp: 2;
                                                                    -webkit-box-orient: vertical;
                                                                    overflow: hidden;
                                                                    text-overflow: ellipsis;
                                                                    font-size: 13px;">
                                                                    ${product.shortDesc}</p>
                                                                <div
                                                                    class="d-flex flex-lg-wrap justify-content-start flex-column">
                                                                    <p style="font-size: 15px; text-align: start; width: 100%;"
                                                                        class="text-dark fs-5 fw-bold mb-2">
                                                                        <fmt:formatNumber type="number"
                                                                            value="${product.price}" /> đ
                                                                    </p>

                                                                    <!-- <form action="/add-product-to-cart/${product.id}"
                                                                        method="post">
                                                                        <input type="hidden"
                                                                            name="${_csrf.parameterName}"
                                                                            value="${_csrf.token}" /> -->
                                                                    <button data-product-id="${product.id}" style="text-align: start;"
                                                                        class="btnAddToCart mx-auto btn border border-secondary rounded-pill px-3 text-primary">
                                                                        <input type="hidden" class="form-control d-none" 
                                                                        id="cartDetails0.quantity" value="1" name="quantity"/>
                                                                        <i
                                                                            class="fa fa-shopping-bag me-2 text-primary">
                                                                        </i>
                                                                        Add to cart</button>
                                                                    <!-- </form> -->
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                                <!--PAGINATION-->

                                                <c:if test="${totalPages gt 0}">
                                                    <div class="col-12">
                                                        <div class="pagination d-flex justify-content-center mt-5">

                                                            <a href="${currentPage eq 1 ? '#' : '/?page='}${currentPage - 1}"
                                                                class="rounded">&laquo;</a>

                                                            <c:forEach begin="1" end="${totalPages}" varStatus="loop">
                                                                <a class="rounded ${currentPage eq loop.index ? 'active ' : ''}"
                                                                    href="/?page=${loop.index}">
                                                                    ${loop.index}
                                                                </a>
                                                            </c:forEach>

                                                            <a href="${currentPage eq totalPages ? '#' : '/?page='}${currentPage + 1}"
                                                                class="rounded">&raquo;</a>
                                                        </div>
                                                    </div>
                                                </c:if>

                                                <!--END PAGINATION-->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Fruits Shop End-->

                <jsp:include page="../layout/feature.jsp" />

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
                <script
                    src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
            </body>

            </html>