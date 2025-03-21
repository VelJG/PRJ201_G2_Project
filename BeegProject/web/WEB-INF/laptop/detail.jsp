<%-- 
    Document   : detail
    Created on : Mar 6, 2025, 9:32:47 PM
    Author     : AN KHUONG
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="container">
    <div class="row detail">

        <div class="col-sm-6">
            <img src="<c:url value="/laptops/${laptop.id}.png" />" style="width: 80%; height: auto;">
        </div>
        <div class="col-sm-6 laptopDetail">
            <c:if test="${account.role=='ADMIN'}">
                ID: ${laptop.id}<br>
            </c:if>
            Name: ${laptop.name} <br>
            Brand: ${laptop.brand} <br>
            Model: ${laptop.model} <br>
            Description: ${laptop.description} <br>
            Price: <fmt:formatNumber value="${laptop.price}" type="currency"/>
            <a href="<c:url value="/cart/add.do?id=${laptop.id}"/>" class="btn btn-lg " style="background-color: lightgreen"><i class="bi bi-cart-plus"></i> Add to cart</a>
        </div>
    </div>
</div>
