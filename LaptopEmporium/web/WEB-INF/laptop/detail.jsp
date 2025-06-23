<%--
Document : detail
Created on : Mar 6, 2025, 9:32:47 PM
Author : AN KHUONG
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="container">
    <div class="row detail my-5">
        <!-- Ảnh sản phẩm -->
        <div class="col-sm-5 text-center p-4"> <!-- Thêm padding -->
            <img src="<c:url value="/laptops/${laptop.id}.png" />" alt="${laptop.name}" class="product-image">
        </div>


        <!-- Thông tin sản phẩm -->
        <div class="col-sm-7 laptopDetail p-4 bg-light rounded">
            <c:if test="${account.role=='ADMIN'}">
                <p>ID: ${laptop.id}</p>
            </c:if>
            <h2>${laptop.name}</h2>
            <p><strong>Brand:</strong> ${laptop.brand}</p>
            <p><strong>Model:</strong> ${laptop.model}</p>
            <p><strong>Description:</strong> ${laptop.description}</p>
            <p><strong>Price:</strong> <fmt:formatNumber value="${laptop.price}" type="currency"/></p>
            <a href="<c:url value="/cart/add.do?id=${laptop.id}"/>" class="btn btn-success btn-lg mt-3">Add to cart <i class="bi bi-cart-plus"></i></a>
        </div>
    </div>
</div>