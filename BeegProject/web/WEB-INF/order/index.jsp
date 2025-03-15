<%-- 
    Document   : index
    Created on : Mar 15, 2025, 11:36:35 AM
    Author     : AN KHUONG
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<h1>Orders</h1>
<table class="table table-striped">
    <tr>
        <c:if test="${account.id==1}">
            <th>Id</th>
            <th>Account id</th>
            </c:if>
        <th>Order Date</th>
        <th>Total Price</th>
        <th>Status</th>
        <th>Details</th>
        <th>Cancel</th>
    </tr>
    <c:forEach var="order" items="${orders}" varStatus="loop" >
        <tr>
            <c:if test="${account.id==1}">
                <td>${order.id}</td>
                <td>${order.accountId}</td>
            </c:if>

            <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" /></td>
            <td><fmt:formatNumber value="${order.formattedPrice}" type="currency" /></td> 
            <td>${order.status}</td>
            <td><a href="<c:url value="/order/detail.do?id=${order.id}"/>" class="btn btn-outline-dark">View details</a></td>
            <td><a href="<c:url value="/order/delete.do?id=${order.id}"/>" class="btn btn-outline-dark">Cancel Order</a></td>
        </tr>
    </c:forEach>
</table>
