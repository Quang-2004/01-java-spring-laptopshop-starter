<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Địa Chỉ Của Tôi</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
        }
        a {
            text-decoration: none;
        }

        .container {
            width: 500px;
            padding: 30px;
            border: 2px solid #ccc;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .address-item {
            margin: 20px 0;
            padding: 15px;
            border: 2px solid #eee;
            border-radius: 6px;
            transition: border-color 0.3s, background-color 0.3s;
            cursor: pointer;
        }

        .default-address {
            background-color: #fff0f0;
            border-color: #ffcccc;
        }

        .phone {
            color: #666;
            font-size: 1em;
        }

        .location {
            color: #333;
            margin: 10px 0;
        }

        .update-btn {
            color: blue;
            text-decoration: none;
            cursor: pointer;
        }

        .add-btn,
        .cancel-btn,
        .confirm-btn {
            margin: 10px 0;
            padding: 12px 25px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1em;
        }

        .add-btn {
            background-color: #f5f5f5;
            color: #333;
        }

        .cancel-btn {
            background-color: #fff;
            color: #666;
        }

        .confirm-btn {
            background-color: #ff4444;
            color: white;
        }

        .default-text {
            color: red;
            margin-top: 10px;
            font-weight: bold;
            display: none;
        }
    </style>
</head>

<body>
    <div class="container">
        <h2 style="text-align: center;">Địa Chỉ Của Tôi</h2>
        <form id="addressForm" action="/account/change-default-address" method="POST">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="hidden" id="selectedAddressId" name="id" value="" />
            
            <c:forEach var="address" items="${addresses}" varStatus="loop">
                <div class="address-item" id="address${loop.count}">
                    <input type="radio" name="default" value="${address.id}">
                    <strong>${address.receiverName}</strong> | <span class="phone">(+84) ${address.receiverPhone}</span>
                    <a href="/account/update-address?id=${address.id}" class="update-btn">Cập nhật</a>
                    <div class="location">
                        ${address.receiverAddress}<br>
                        Phường Tân Chánh Hiệp, Quận 12, TP. Hồ Chí Minh
                    </div>
                    <div class="default-text">Mặc định</div>
                    <!-- Kiểm tra nếu địa chỉ này là myAddress (địa chỉ mặc định) -->
                    <c:if test="${address == myAddress}">
                        <script>
                            document.getElementById('address${loop.count}').classList.add('default-address');
                            document.querySelector('#address${loop.count} .default-text').style.display = 'block';
                            document.querySelector('input[name="default"][value="${address.id}"]').checked = true;
                            document.getElementById('selectedAddressId').value = '${address.id}';
                        </script>
                    </c:if>
                </div>
            </c:forEach>
            
            <button class="add-btn"><a href="/account/add-address">+ Thêm Địa Chỉ Mới</a></button>
            <button class="add-btn"><a href="/checkout">Quay lại</a></button>
            <button class="cancel-btn"><a href="/checkout"></a></button>
            <button type="submit" class="confirm-btn">Xác nhận</button>
        </form>
    </div>

    <script>
        // Lấy tất cả các phần tử địa chỉ, radio button, chữ "Mặc định", và hidden input
        const addressItems = document.getElementsByClassName('address-item');
        const radios = document.getElementsByName('default');
        const defaultTexts = document.getElementsByClassName('default-text');
        const selectedAddressIdInput = document.getElementById('selectedAddressId');

        // Hàm để xóa trạng thái mặc định khỏi tất cả các địa chỉ
        function clearDefault() {
            for (let item of addressItems) {
                item.classList.remove('default-address');
            }
            for (let text of defaultTexts) {
                text.style.display = 'none';
            }
            // Đảm bảo tất cả radio button không được chọn
            for (let radio of radios) {
                radio.checked = false;
            }
            // Reset hidden input
            selectedAddressIdInput.value = '';
        }

        // Thêm sự kiện click cho mỗi khung địa chỉ
        for (let item of addressItems) {
            item.addEventListener('click', function (e) {
                // Chỉ xử lý nếu click không phải vào link "Cập nhật"
                if (e.target.tagName !== 'A') { // Bỏ qua nếu click vào link "Cập nhật"
                    clearDefault();

                    // Lấy radio button trong địa chỉ hiện tại
                    const radio = item.querySelector('input[type="radio"]');
                    if (radio) {
                        radio.checked = true; // Đảm bảo radio button được tick
                        item.classList.add('default-address'); // Thêm lớp default-address
                        const defaultText = item.querySelector('.default-text');
                        if (defaultText) {
                            defaultText.style.display = 'block'; // Hiển thị chữ "Mặc định"
                        }
                        // Cập nhật hidden input với ID của địa chỉ được chọn
                        selectedAddressIdInput.value = radio.value; // Sử dụng ID thực từ database (ví dụ: ${address.id})
                    }
                }
            });
        }

        // Thêm sự kiện change cho radio button (để đảm bảo khi click trực tiếp vào radio cũng hoạt động)
        for (let radio of radios) {
            radio.addEventListener('change', function () {
                clearDefault();

                // Lấy địa chỉ tương ứng với radio được chọn
                const addressItem = document.getElementById(this.value);
                if (addressItem) {
                    addressItem.classList.add('default-address'); // Thêm lớp default-address cho khung
                    const defaultText = addressItem.querySelector('.default-text');
                    if (defaultText) {
                        defaultText.style.display = 'block'; // Hiển thị chữ "Mặc định"
                    }
                    // Cập nhật hidden input với ID của địa chỉ được chọn
                    selectedAddressIdInput.value = this.value; // Sử dụng ID thực từ database (ví dụ: ${address.id})
                    this.checked = true; // Đảm bảo radio button được tick
                }
            });
        }

        // Đặt trạng thái mặc định ban đầu (nếu có)
        const initialChecked = document.querySelector('input[name="default"]:checked');
        if (initialChecked) {
            const initialAddress = initialChecked.closest('.address-item');
            initialAddress.classList.add('default-address');
            const defaultText = initialAddress.querySelector('.default-text');
            if (defaultText) {
                defaultText.style.display = 'block';
            }
            // Cập nhật hidden input với ID của địa chỉ mặc định ban đầu
            selectedAddressIdInput.value = initialChecked.value; // Sử dụng ID thực từ database (ví dụ: ${address.id})
        }
    </script>
</body>

</html>