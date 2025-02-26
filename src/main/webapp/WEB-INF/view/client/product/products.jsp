<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8">
                <title>Laptopshop - Laptop Website Template</title>
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
            </head>

            <body>

                <!-- Spinner Start -->
                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>
                <!-- Spinner End -->

                <jsp:include page="../layout/header.jsp" />



                <!-- Single Product Start -->
                <div class="container-fluid py-5 mt-5">
                    <div class="container py-5">
                        <div class="row g-4 mb-5">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Danh sách sản phẩm</li>
                                </ol>
                            </nav>
                            <!-- PRODUCTS-->
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane fade show p-0 active">
                                    <div class="row g-4">
                                        
                                        <div class="col-lg-3">
                                            
                                            <div class="col-12" id="factoryFilter">
                                                <h6>Hãng sản xuất</h6>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="factory-1"
                                                        value="APPLE">
                                                    <label class="form-check-label" for="inlineCheckbox1">Apple</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="factory-2"
                                                        value="ASUS">
                                                    <label class="form-check-label" for="inlineCheckbox2">Asus</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="factory-3"
                                                        value="LENOVO">
                                                    <label class="form-check-label" for="inlineCheckbox2">Lenovo</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="factory-4"
                                                        value="DELL">
                                                    <label class="form-check-label" for="inlineCheckbox1">Dell</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="factory-5"
                                                        value="LG">
                                                    <label class="form-check-label" for="inlineCheckbox2">LG</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="factory-6"
                                                        value="ACER">
                                                    <label class="form-check-label" for="inlineCheckbox2">Acer</label>
                                                </div>
                                            </div><br>

                                            <div class="target" id="targetFilter">
                                                <h6>Mục đích sử dụng</h6>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="target-1"
                                                        value="GAMMING">
                                                    <label class="form-check-label"
                                                        for="inlineCheckbox1">Gamming</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="target-2"
                                                        value="SINHVIEN-VANPHONG">
                                                    <label class="form-check-label" for="inlineCheckbox2">Sinh viên -
                                                        Văn phòng</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="target-3"
                                                        value="THIET-KE-DO-HOA">
                                                    <label class="form-check-label" for="inlineCheckbox2">Thiết kế đồ
                                                        họa</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="target-4"
                                                        value="MONG-NHE">
                                                    <label class="form-check-label" for="inlineCheckbox1">Mỏng
                                                        nhẹ</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="target-5"
                                                        value="DOANH-NHAN">
                                                    <label class="form-check-label" for="inlineCheckbox2">Doanh
                                                        nhân</label>
                                                </div>

                                            </div><br>

                                            <div class="price" id="priceFilter">
                                                <h6>Mức giá</h6>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="price-1"
                                                        value="duoi-10-trieu">
                                                    <label class="form-check-label" for="inlineCheckbox1">Dưới 10
                                                        triệu</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="price-2"
                                                        value="10-toi-15-trieu">
                                                    <label class="form-check-label" for="inlineCheckbox2">Từ 10 - 15
                                                        triệu</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="price-3"
                                                        value="15-toi-20-trieu">
                                                    <label class="form-check-label" for="inlineCheckbox2">Từ 15 - 20
                                                        triệu</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="checkbox" id="price-4"
                                                        value="tren-20-trieu" >
                                                    <label class="form-check-label" for="inlineCheckbox1">Trên 20
                                                        triệu</label>
                                                </div>

                                            </div><br>

                                            <div class="sort">
                                                <h6>Sắp xếp</h6>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" id="sort-1"
                                                        value="gia-tang-dan" name="radio-sort">
                                                    <label class="form-check-label" for="inlineCheckbox1">Giá tăng
                                                        dần</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" id="sort-2"
                                                        value="gia-giam-dan" name="radio-sort">
                                                    <label class="form-check-label" for="inlineCheckbox2">Giá giảm
                                                        dần</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" id="sort-3" checked
                                                        value="khong-sap-sep" name="radio-sort">
                                                    <label class="form-check-label" for="inlineCheckbox2">Không sắp
                                                        xếp</label>
                                                </div>
                                            </div><br>
                                            <div class="d-flex justify-content-center my-4">
                                                <a href="#"
                                                    class="btn border border-secondary px-4 py-3 rounded-pill text-primary w-100"
                                                    id="btnFilter">
                                                    Lọc sản phẩm</a>
                                            </div>
                                        </div>
                                        <div class="col-lg-8">
                                            <div class="row g-4">
                                                <c:if test="${totalPages eq 0}">
                                                    <div class="container">
                                                        <div class="row d-flex justify-content-center align-items-center" style="min-height: 300px;">
                                                            <div class="col text-center">
                                                                <img src="/client/img/cant-find-product.png" alt="Can't find product" style="width: 400px; height: 270px;"> <br>
                                                                Rất tiếc, chúng tôi không tìm thấy sản phẩm.
                                                            </div>
                                                           
                                                        </div>
                                                    </div>
                                                </c:if>

                                                <c:if test="${quantityProduct gt 0}">
                                                    <span>Tìm thấy <strong>${quantityProduct}</strong> kết quả</span>
                                                </c:if>
                                                
                                                <c:forEach var="product" items="${products}">
                                                    <div class="col-6 col-md-6 col-lg-4 col-xl-4">
                                                        <div class="rounded position-relative fruite-item">
                                                            <div class="fruite-img">
                                                                <a href="/product/${product.id}">
                                                                    <img src="/images/product/${product.getImage()}"
                                                                        class="img-fluid w-100 rounded-top" alt=""></a>
                                                            </div>
                                                            <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                                style="top: 10px; left: 10px;">Laptop</div>
                                                            <div
                                                                class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                                <h4 style="font-size: 15px" class="text-center">
                                                                    ${product.name}</h4>
                                                                    <p class="text-center" style="display: -webkit-box;
                                                                        -webkit-line-clamp: 2;
                                                                        -webkit-box-orient: vertical;
                                                                        overflow: hidden;
                                                                        text-overflow: ellipsis;
                                                                        font-size: 13px;">
                                                                        ${product.shortDesc}
                                                                    </p>
                                                                <div class="d-flex flex-lg-wrap justify-content-center">
                                                                    <p style="font-size: 15px; text-align: center; width: 100%;"
                                                                        class="text-dark fs-5 fw-bold mb-2">
                                                                        <fmt:formatNumber type="number"
                                                                            value="${product.price}" /> đ
                                                                    </p>

                                                                    <form action="/add-product-to-cart/${product.id}"
                                                                        method="post">
                                                                        <!-- csrf token -->
                                                                        <input type="hidden"
                                                                            name="${_csrf.parameterName}"
                                                                            value="${_csrf.token}" />
                                                                        <button href="#" style="text-align: center;"
                                                                            class="mx-auto btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                                class="fa fa-shopping-bag me-2 text-primary"></i>
                                                                            Add to cart</button>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                            <!--PAGINATION-->
                                            
                                            <c:if test="${totalPages gt 0}">
                                                <div class="col-12">
                                                    <div class="pagination d-flex justify-content-center mt-5">
    
                                                        <a href="${currentPage eq 1 ? '#' : '/products?page='}${currentPage - 1}${queryString}"
                                                            class="rounded">&laquo;</a>
    
                                                        <c:forEach begin="1" end="${totalPages}" varStatus="loop">
                                                            <a class="rounded ${currentPage eq loop.index ? 'active ' : ''}"
                                                                href="/products?page=${loop.index}${queryString}">
                                                                ${loop.index}
                                                            </a>
                                                        </c:forEach>
    
                                                        <a href="${currentPage eq totalPages ? '#' : '/products?page='}${currentPage + 1}${queryString}"
                                                            class="rounded">&raquo;</a>
                                                    </div>
                                                </div>
                                            </c:if>
                                            
                                            <!--END PAGINATION-->
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- PRODUCTS-->
                        </div>

                    </div>
                </div>
                <!-- Single Product End -->

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