<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi-VN" scope="session"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<c:url value="/css/site.css"/>" rel="stylesheet" type="text/css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script> 
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

        <title>LaptopEmporium</title>

        <style>
            /* Thiết lập màu nền gradient cho toàn bộ trang */
            body {
                background: linear-gradient(to bottom, #3B5284, #5BA8A0);
                color: #ffffff; /* Màu chữ trắng để tương phản */;
            }

            /* Thiết lập màu nền cho header */
            .header {
                background-color: white; /* Màu nền trắng */;
                border-bottom: 1px solid rgba(0, 0, 0, 0.1); /* Viền dưới nhẹ */;
                border-radius: 10px; /* Bo tròn góc */;
                padding: 0; /* Bỏ đi padding của header */;
                margin: 1rem; /* Khoảng cách giữa header và nội dung khác */;
                display: flex;
                justify-content: space-around;
                align-items: center;
            }

            /* Thiết lập layout cho navigation */
            .nav-menu {
                display: flex;
                justify-content: space-around; /* Cách đều các phần tử navigation */;
                gap: 1rem; /* Khoảng cách giữa các phần tử navigation */;
            }

            .nav-menu ul {
                list-style-type: none;
                padding: 0;
                margin: 0;
                display: flex;
                align-items: center;
            }

            .nav-menu li {
                margin: 0;
            }

            .nav-menu a {
                color: #333; /* Màu chữ đen */;
                text-decoration: none;
                padding: 0.5rem 1rem;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            .nav-menu a:hover {
                background-color: #f0f0f0; /* Màu nền khi hover */;
            }

            /* Thiết lập màu nền cho modal */
            .modal-content {
                background-color: rgba(0, 0, 0, 0.9); /* Màu nền tối cho modal */;
                color: #ffffff; /* Màu chữ trắng */;
            }

            /* Thiết lập màu nền cho nút */
            .btn-outline-primary {
                color: #bb86fc; /* Màu chữ tím nhạt */;
                border-color: #bb86fc; /* Màu viền */;
            }
            .btn-outline-primary:hover {
                background-color: #bb86fc; /* Màu nền khi hover */;
                color: #000; /* Màu chữ khi hover */;
            }

            /* Thiết lập màu nền cho giỏ hàng */
            .btn-outline-dark {
                color: #ffab40; /* Màu chữ cam */;
                border-color: #ffab40; /* Màu viền */;
            }
            .btn-outline-dark:hover {
                background-color: #ffab40; /* Màu nền khi hover */;
                color: #000; /* Màu chữ khi hover */;
            }

            /* Thiết lập footer */
            .footer {
                background-color: rgba(0, 0, 0, 0.7);
                color: #ffffff;
                padding: 2rem;
                text-align: center;
                margin-top: 2rem;
                border-radius: 10px;
            }

            .footer a {
                color: #ffffff;
                text-decoration: none;
                margin: 0 1rem;
            }

            .footer a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <!-- Logo -->
                <a href="<c:url value='/'/>">
                    <img src="<c:url value='/laptops/Laptop_logo2.png'/>" alt="Shop Logo" 
                         class="logo mr-4" 
                         style="max-width: 100px; height: auto;">
                </a>

                <!-- Navigation Menu -->
                <nav class="navbar navbar-expand-lg navbar-light">
                    <ul class="navbar-nav mx-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="<c:url value='/'/>">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#about">About Us</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#contact">Contact</a>
                        </li>
                    </ul>
                </nav>

                <!-- Login and Cart buttons -->
                <div class="ml-auto">
                    <c:if test="${account == null}">
                        <a href="#" class="btn btn-outline-primary me-3" data-bs-toggle="modal" data-bs-target="#loginModal">Login</a>
                    </c:if>
                    <c:if test="${account != null}">
                        <span class="btn btn-secondary me-3">Welcome, ${account.fullName}</span> |
                        <a href="<c:url value='/account/logout.do'/>" class="btn btn-danger me-3">Logout</a>
                    </c:if>
                    <a href="<c:url value='/cart/index.do'/>" class="btn btn-outline-dark">
                        <c:if test="${cart.total == 0}">
                            <i class="bi bi-cart"></i>
                        </c:if>
                        <c:if test="${cart.total != 0}">
                            <i class="bi bi-cart-fill"></i>
                        </c:if>
                        <fmt:formatNumber value="${cart.total}" type="currency"/>
                    </a>
                </div>
            </div>

            <div class="row my-3">
                <jsp:include page="/WEB-INF/${controller}/${action}.jsp"></jsp:include>
            </div>
        </div>

        <!-- Footer -->
        <!-- Footer -->
        <div class="footer" id="about">
            <p>Copyright &COPY; by FPT Students</p>
            <p>Gmail: Group2@gmail.com</p>
            <p>Phone number: 0789334455</p>
        </div>

        <!-- Modal -->
        <div class="modal" id="loginModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="<c:url value="/account/login.do"/>">
                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h4 class="modal-title">Login</h4>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>

                        <!-- Modal body -->
                        <div class="modal-body">
                            <div class="mb-3 mt-3">
                                <label for="email" class="form-label">Email:</label>
                                <input type="email" class="form-control" id="email" placeholder="Enter email" name="email">
                            </div>
                            <div class="mb-3">
                                <label for="pwd" class="form-label">Password:</label>
                                <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="password">
                            </div>
                            <div class="form-check mb-3">
                                <label class="form-check-label">
                                    <input class="form-check-input" type="checkbox" name="remember"> Remember me
                                </label>
                            </div>
                        </div>

                        <!-- Modal footer -->
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary" data-bs-dismiss="modal">Login</button>
                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>