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
            <img src="<c:url value="/laptops/${laptop.id}.png" />">
        </div>
        <div class="col-sm-6 laptopDetail">
            <c:if test="${account.role=='ADMIN'}">
                ID: ${laptop.id}<br>
            </c:if>
            Brand: ${laptop.brand} <br>
            Description: ${laptop.description} <br>
            Price: <fmt:formatNumber value="${laptop.price}" type="currency"/>
            <a href="<c:url value="/cart/add.do?id=${laptop.id}"/>" class="btn btn-lg " style="background-color: lightgreen"><i class="bi bi-cart-plus"></i> Add to cart</a>
            <c:if test="${account.role=='ADMIN'}">
                            <a href="<c:url value="/laptop/edit.do?id=${laptop.id}"/>" class="btn">Edit</a>
            </c:if>

        </div>


    </div>

</div>