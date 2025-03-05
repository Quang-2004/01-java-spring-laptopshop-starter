<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Thêm Địa Chỉ</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <style>
                        * {
                            margin: 0;
                            padding: 0;
                            box-sizing: border-box;
                            font-family: Arial, sans-serif;
                        }

                        a{
                            text-decoration: none;
                            text-align: center;
                        }

                        body {
                            background-color: #f5f5f5;
                            display: flex;
                            justify-content: center;
                            align-items: center;
                            min-height: 100vh;
                        }

                        .container {
                            width: 100%;
                            max-width: 550px;
                        }

                        .address-form {
                            background-color: white;
                            border-radius: 5px;
                            padding: 20px;
                            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                            border: 1px solid #ddd;
                        }

                        .address-form h2 {
                            font-size: 18px;
                            margin-bottom: 10px;
                            color: #333;
                        }

                        .address-form p {
                            font-size: 14px;
                            color: #666;
                            margin-bottom: 15px;
                        }

                        .input-field {
                            width: 100%;
                            padding: 10px;
                            margin-bottom: 10px;
                            border: 1px solid #ddd;
                            border-radius: 5px;
                            font-size: 14px;
                        }

                        select.input-field {
                            appearance: none;
                            background: url('data:image/svg+xml;utf8,<svg fill="%23333" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/></svg>') no-repeat right 10px center;
                            background-size: 15px;
                            padding-right: 30px;
                        }

                        .add-btn {
                            background-color: #fff;
                            border: 1px solid #ddd;
                            padding: 5px 15px;
                            border-radius: 5px;
                            cursor: pointer;
                            margin: 10px 0;
                            font-size: 14px;
                        }

                        .address-type {
                            margin: 15px 0;
                            display: flex;
                            gap: 10px;
                            align-items: center;
                        }

                        .type-btn {
                            background-color: #fff;
                            border: 1px solid #ddd;
                            padding: 8px 15px;
                            border-radius: 5px;
                            cursor: pointer;
                            font-size: 14px;
                            transition: background-color 0.3s, border-color 0.3s;
                        }

                        .type-btn.selected {
                            background-color: #ee4d2d;
                            border-color: #ee4d2d;
                            color: white;
                        }

                        .save-address {
                            font-size: 14px;
                            color: #666;
                            margin: 10px 0;
                            background-color: #f8f8f8;
                            padding: 10px;
                            border-radius: 5px;
                        }

                        .buttons {
                            display: flex;
                            gap: 10px;
                            margin-top: 20px;
                        }

                        .back-btn,
                        .submit-btn {
                            padding: 10px 20px;
                            border-radius: 5px;
                            border: none;
                            cursor: pointer;
                            font-size: 16px;
                            flex: 1;
                        }

                        .back-btn {
                            background-color: #fff;
                            border: 1px solid #ddd;
                            color: #333;
                        }

                        .submit-btn {
                            background-color: #ee4d2d;
                            color: white;
                        }
                    </style>
                </head>

                <body>
                    <div class="container">
                        <div class="address-form">

                            <form:form action="/account/update-address" method="POST" modelAttribute="updateAddress">
                                <h2>Update địa chỉ</h2>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <form:input type="hidden" path="id"/>

                                <c:set var="errorName">
                                    <form:errors cssClass="invalid-feedback" path="receiverName" />
                                </c:set>
                                <c:set var="errorAddress">
                                    <form:errors cssClass="invalid-feedback" path="receiverAddress" />
                                </c:set>
                                <c:set var="errorPhone">
                                    <form:errors cssClass="invalid-feedback" path="receiverPhone" />
                                </c:set>

                                

                                <form:input type="text" placeholder="Họ và tên" path="receiverName"
                                    class="form-control input-field ${not empty errorName ? 'is-invalid': ''}" />
                                ${errorName}
                                <form:input type="text" placeholder="Số điện thoại" path="receiverPhone"
                                    class="form-control input-field ${not empty errorPhone ? 'is-invalid': ''}" />
                                ${errorPhone}
                                <form:input type="text" placeholder="Địa chỉ cụ thể" path="receiverAddress"
                                    class="form-control input-field ${not empty errorAddress ? 'is-invalid': ''}" />
                                ${errorAddress}
                                <button class="add-btn">+ Thêm vị trí</button>
                                <div class="address-type">
                                    <label>Loại địa chỉ:</label>
                                    <button class="type-btn" path="typeAddress" id="home">Nhà
                                        Riêng</button>
                                    <button class="type-btn" path="typeAddress" id="office">Văn
                                        Phòng</button>
                                </div>
                                <form:checkbox path="defaultAddress" /> 
                                <span>Đặt làm địa chỉ mặc định</span>
                                <div class="buttons">
                                    <a href="/account/change-address" class="back-btn">Trở Lại</a>
                                    <button type="submit" class="submit-btn">Update</button>
                                </div>
                            </form:form>

                        </div>
                    </div>
                    <script>
                        document.addEventListener('DOMContentLoaded', () => {
                            const homeBtn = document.getElementById('home');
                            const officeBtn = document.getElementById('office');

                            // Xử lý khi nhấn nút "Nhà Riêng"
                            homeBtn.addEventListener('click', () => {
                                if (homeBtn.classList.contains('selected')) {
                                    // Nếu nút đã được chọn, bỏ chọn nó
                                    homeBtn.classList.remove('selected');
                                } else {
                                    // Nếu nút chưa được chọn, chọn nó và bỏ chọn nút kia
                                    homeBtn.classList.add('selected');
                                    officeBtn.classList.remove('selected');
                                }
                            });

                            // Xử lý khi nhấn nút "Văn Phòng"
                            officeBtn.addEventListener('click', () => {
                                if (officeBtn.classList.contains('selected')) {
                                    // Nếu nút đã được chọn, bỏ chọn nó
                                    officeBtn.classList.remove('selected');
                                } else {
                                    // Nếu nút chưa được chọn, chọn nó và bỏ chọn nút kia
                                    officeBtn.classList.add('selected');
                                    homeBtn.classList.remove('selected');
                                }
                            });
                        });
                    </script>

                </body>

                </html>