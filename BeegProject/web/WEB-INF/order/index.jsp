<%-- 
    Document   : index
    Created on : Mar 15, 2025, 11:36:35 AM
    Author     : AN KHUONG
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<h1>Orders</h1>
<table class="table table-striped">
    <tr>
        <th>Id</th>
        <th>Account id</th>
        <th>Order Date</th>
        <th>Total Price</th>
        <th>Status</th>
    </tr>
    <c:forEach var="order" items="${orders}" varStatus="loop" >
        <tr>
            <td>${order.id}</td>
            <td>${order.accountId}</td>
            <td>${order.orderDate}</td>
            <td>${order.totalPrice}</td>
            <td>${order.status}</td>
        </tr>
    </c:forEach>
</table>
