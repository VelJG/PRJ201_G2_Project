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
        <c:if test="${account.role == 'ADMIN'}">
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
            <c:if test="${account.role == 'ADMIN'}">
                <td>${order.id}</td>
                <td>${order.accountId}</td>
            </c:if>

            <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy" /></td>
            <td><fmt:formatNumber value="${order.formattedPrice}" type="currency" /></td> 
            <td>
                <c:if test="${account.role == 'ADMIN'}">
                    <form action="<c:url value="/order/changeStatus.do"/>">
                        <select name="status" onchange="this.form.submit()">
                            <option value="Order Placed" ${order.status == 'Order Placed' ? 'selected' : ''}>Order Placed</option>
                            <option value="Processing" ${order.status == 'Processing' ? 'selected' : ''}>Processing</option>
                            <option value="Shipped" ${order.status == 'Shipped' ? 'selected' : ''}>Shipped</option>
                            <option value="Out for Delivery" ${order.status == 'Out for Delivery' ? 'selected' : ''}>Out for Delivery</option>
                            <option value="Delivered" ${order.status == 'Delivered' ? 'selected' : ''}>Delivered</option>
                        </select>
                        <input type="hidden" name="orderId" value="${order.id}">
                        <input type="hidden" name="id" value="${account.id}">
                    </form>
                </c:if>
                <c:if test="${account.role != 'ADMIN'}">
                    ${order.status}
                </c:if>
            </td>
            <td><a href="<c:url value="/order/detail.do?id=${order.id}"/>" class="btn btn-outline-dark">View details</a></td>
            <td>
                <c:if test="${order.status != 'Delivered'}">
                    <a href="<c:url value="/order/delete.do?id=${order.id}&accountId=${account.id}"/>" class="btn btn-outline-dark">Cancel Order</a>

                </c:if>
                <c:if test="${order.status == 'Delivered'}">
                    Order delivered
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>
