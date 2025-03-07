<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!-- Modal Search Start -->
        <!-- <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen">
                <div class="modal-content rounded-0">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body d-flex align-items-center">
                        <div class="input-group w-75 mx-auto d-flex">
                            <form action="/products" method="GET">
                                <input type="search" class="form-control p-3" placeholder="keywords"
                                    aria-describedby="search-icon-1" name="search">
                                <span id="search-icon-1" class="input-group-text p-3"><i
                                        class="fa fa-search"></i></span>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div> -->
        
        <!-- Modal Search End -->

        <!-- Navbar start -->
        <div class="container-fluid fixed-top">
            <div class="container px-0">
                <nav class="navbar navbar-light bg-white navbar-expand-xl">
                    <a href="/" class="navbar-brand">
                        <h1 class="text-primary display-6">Laptopshop</h1>
                    </a>
                    <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars text-primary"></span>
                    </button>
                    <div class="collapse navbar-collapse bg-white justify-content-between mx-5" id="navbarCollapse">
                        <div class="navbar-nav">
                            <a href="/" class="nav-item nav-link active">Trang Chủ</a>
                            <a href="/products" class="nav-item nav-link">Sản Phẩm</a>

                        </div>
                        <div class="d-flex m-3 me-0">
                            <c:if test="${not empty pageContext.request.userPrincipal}">
                                <div class="d-flex align-items-center justify-content-start">
                                    <form action="/products" method="get" class="flex-grow-1 me-3">
                                        <div class="input-group shadow-sm" style="max-width: 500px;">
                                            <input type="search" class="form-control py-3 px-4 border-0 rounded-start" 
                                                   placeholder="Nhập từ khóa..." 
                                                   name="search">
                                            <span id="search-icon-1" class="input-group-text py-3 px-4 text-white rounded-end" style="color: rgb(34, 148, 38) !important;">
                                                <i class="fa fa-search fs-5"></i>
                                            </span>
                                        </div>
                                    </form>
                                </div>
                                <a href="/cart" class="position-relative me-4 my-auto ">
                                    <i class="fa fa-shopping-bag fa-2x"></i>
                                    <span
                                        class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
                                        style="top: -5px; left: 15px; height: 20px; min-width: 20px;" id="sumCart">
                                        ${sessionScope.sum}
                                    </span>
                                </a>

                                <div class="dropdown my-auto">

                                    <a href="#" class="dropdown" role="button" id="dropdownMenuLink"
                                        data-bs-toggle="dropdown" aria-expanded="false" data-bs-toggle="dropdown"
                                        aria-expanded="false">
                                        <i class="fas fa-user fa-2x"></i>
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end p-4" aria- labelledby="dropdownMenuLink">

                                        <li class="d-flex align-items-center flex-column" style="min-width: 300px;">

                                            <c:if test="${not empty sessionScope.avatar}">
                                                <img style="width: 150px; height: 150px; border-radius: 50%; overflow: hidden;"
                                                    src="/images/avatar/${sessionScope.avatar}" />
                                            </c:if>
                                            <c:if test="${empty sessionScope.avatar}">
                                                <img style="width: 150px; height: 150px; border-radius: 50%; overflow: hidden;"
                                                    src="/images/avatar/defaut-avatar.jpg" />
                                            </c:if>

                                            <div class="text-center my-3">
                                                <c:out value="${sessionScope.fullName}" />
                                            </div>

                                        </li>
                                        <li><a class="dropdown-item" href="/account/my-profile">Tài khoản của tôi</a>
                                        </li>
                                        <li><a class="dropdown-item" href="/order-history">Lịch sử mua hàng</a></li>
                                        <li>
                                            <hr class="dropdown-divider">
                                        </li>
                                        <li>
                                            <form method="post" action="/logout">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <button class="dropdown-item">Đăng xuất</button>
                                            </form>
                                        </li>
                                    </ul>

                                </div>
                            </c:if>
                            <c:if test="${empty pageContext.request.userPrincipal}">
                                <h5><a href="/login" class="a-login">Đăng nhập</a></h5>
                                <h5>
                                    <p> | </p>
                                </h5>
                                <h5><a href="/register">Đăng ký</a></h5>
                            </c:if>


                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <!-- Navbar End -->