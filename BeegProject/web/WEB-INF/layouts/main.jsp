<%-- 
    Document   : main
    Created on : Feb 10, 2025, 10:43:50 AM
    Author     : AN KHUONG
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    </head>
    <body>
        <!-- Header -->
<div class="header-container py-3 border-bottom" style="background-color: black; color: white;">
    <div class="row align-items-center">
        <div class="col-md-1"></div>
        <!-- Left Section (Navigation Links) -->
        <div class="col-md-4 d-flex gap-3">
            <a href="<c:url value='/'/>" class="btn btn-outline-light">Home</a>
            <a href="#footer" class="btn btn-outline-light">About Us</a>
            <c:if test="${account.role=='ADMIN'}">
                <a class="btn btn-outline-light" href="<c:url value="/laptop/manage.do"/>">Manage</a>
            </c:if>
        </div>
        <!-- Middle Section (Logo) -->
        <div class="col-md-2 text-center">
            <a href="<c:url value='/'/>">
                <img src="<c:url value='/laptops/Laptop_logo3.png'/>" alt="Shop Logo" class="logo" style="width: 180px; padding: 0">
            </a>
        </div>
        <!-- Right Section (Account, Cart) -->
        <div class="col-md-4 d-flex justify-content-end align-items-center">
            <div style="padding-right: 20px;">
                <c:if test="${account == null}">
                    <a href="#" style="text-decoration: none" data-bs-toggle="modal" data-bs-target="#loginModal">
                        <img src="<c:url value='/laptops/login.png'/>" style="width: 36px">
                    </a>
                </c:if>
                <c:if test="${account != null}">
                    <span class="btn btn-secondary">Welcome, ${account.fullName}</span> |
                    <a href="<c:url value='/account/logout.do'/>" class="btn btn-danger">Logout</a>
                </c:if>
                |
                <a href="<c:url value='/cart/index.do'/>" class="btn btn-outline-light">
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
        <div class="col-md-1"></div>
    </div>
</div>

        <!-- Main Content -->
        <div class="container">
            <div class="row my-3">
                <jsp:include page="/WEB-INF/${controller}/${action}.jsp"></jsp:include>
                </div>
            </div>

            <!-- Footer -->
            <footer id="footer" class="bg-dark text-white py-4 mt-auto">
                <div class="container">
                    <div class="row">
                        <!-- About Us -->

                        <div class="col-md-4 text-center">
                            <h5>About Us</h5>
                            <p>We are a leading provider of high-quality laptops and accessories. Our mission is to deliver the best products and services to our customers.</p>
                        </div>

                        <!-- Contact Information -->

                        <div class="col-md-4 text-center">
                            <h5>Contact Us</h5>
                            <ul class="list-unstyled">
                                <li><i class="bi bi-geo-alt-fill"></i> FPTU D1 Street, High Tech Park</li>
                                <li><i class="bi bi-telephone-fill"></i> +123 456 7890</li>
                                <li><i class="bi bi-envelope-fill"></i> contact@laptopemporium.com</li>
                            </ul>
                        </div>

                        <!-- Quick Links -->
                        <div class="col-md-4 text-center">
                            <h5>Quick Links</h5>
                            <ul class="list-unstyled">
                                <li><a href="<c:url value='/'/>" class="text-white text-decoration-none">Home</a></li>
                            <li><a href="#footer" class="text-white text-decoration-none">About Us</a></li>
                            <li><a href="<c:url value='/cart/index.do'/>" class="text-white text-decoration-none">Cart</a></li>
                        </ul>
                    </div>
                </div>
                <hr>
                <div class="text-center">

                    &copy; 2025 Group2 Store. All rights reserved.
                </div>
            </div>
        </footer>

        <!-- Login and Register Modal -->
        <div class="modal" id="loginModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <!-- Modal Header with Tabs -->
                    <div class="modal-header">
                        <ul class="nav nav-tabs card-header-tabs" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" data-bs-toggle="tab" href="#loginTab">Login</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-bs-toggle="tab" href="#registerTab">Register</a>
                            </li>
                        </ul>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <!-- Modal Body with Tabs Content -->
                    <div class="modal-body">
                        <div class="tab-content">
                            <!-- Login Tab -->
                            <div id="loginTab" class="tab-pane fade show active">
                                <form action="<c:url value="/account?action=login"/>" method="post">
                                    <div class="mb-3 mt-3">
                                        <label for="email" class="form-label">Email:</label>
                                        <input type="email" class="form-control" id="email" placeholder="Enter email" name="email" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="pwd" class="form-label">Password:</label>
                                        <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="password" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Login</button>
                                </form>
                            </div>

                            <!-- Register Tab -->
                            <div id="registerTab" class="tab-pane fade">
                                <form action="<c:url value="/account?action=register"/>" method="post">
                                    <div class="mb-3 mt-3">
                                        <label for="fullName" class="form-label">Full Name:</label>
                                        <input type="text" class="form-control" id="fullName" placeholder="Enter full name" name="fullName" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="emailRegister" class="form-label">Email:</label>
                                        <input type="email" class="form-control" id="emailRegister" placeholder="Enter email" name="email" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="passwordRegister" class="form-label">Password:</label>
                                        <input type="password" class="form-control" id="passwordRegister" placeholder="Enter password" name="password" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="confirmPassword" class="form-label">Confirm Password:</label>
                                        <input type="password" class="form-control" id="confirmPassword" placeholder="Confirm password" name="confirmPassword" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="role" class="form-label">Role:</label>
                                        <select class="form-select" id="role" name="role" required>
                                            <option value="">Select Role</option>
                                            <option value="USER">User</option>
                                            <option value="ADMIN">Admin</option>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-success">Register</button>
                                    <div id="registerMessage" class="mt-2">
                                        <!-- Hiển thị thông điệp từ session -->
                                        <c:if test="${not empty sessionScope.registerMessage}">
                                            <div class="alert alert-success">
                                                ${sessionScope.registerMessage}
                                            </div>
                                            <c:remove var="registerMessage" scope="session" />
                                        </c:if>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Modal Footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>