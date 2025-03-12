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
            Model: ${laptop.model} <br>
            Description: ${laptop.description} <br>
            Price: <fmt:formatNumber value="${laptop.price}" type="currency"/>
            <a href="<c:url value="/cart/add.do?id=${laptop.id}"/>" class="btn btn-lg " style="background-color: lightgreen"><i class="bi bi-cart-plus"></i> Add to cart</a>
            <c:if test="${account.role=='ADMIN'}">
                <a href="<c:url value="/laptop/edit.do?id=${laptop.id}"/>" class="btn">Edit</a>
                <a class="btn btn-danger" onclick="confirmDelete('<c:url value="/laptop/delete.do?id=${laptop.id}"/>')">Delete</a>
                <script>
                    function confirmDelete(url) {
                        if (confirm("Are you sure you want to delete this laptop?")) {
                            window.location.href = url;
                        }
                    }
                </script>

            </c:if>
        </div>
    </div>
</div>
