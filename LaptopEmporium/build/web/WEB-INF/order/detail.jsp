<%-- 
    Document   : detail
    Created on : Mar 15, 2025, 2:36:23 PM
    Author     : AN KHUONG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table class="table table-striped"> 
    <tr>
        <th>No.</th>
        <th>Image</th>
        <th style="text-align: right">Price</th>
        <th style="text-align: right">Quantity</th>
        <th style="text-align: right">Cost</th>
    </tr>
    <c:forEach var="item" items="${detail}" varStatus="loop">
        <tr>
            <td>${loop.count}</td>
            <td>  <img src="<c:url value="/laptops/${item.laptopId}.png"/>" alt="" class="laptop-thumbnail"/></td>
            <td style="text-align: right">
                <fmt:formatNumber value="${item.price}" type="currency"/>
            </td>
            <td style="text-align: right">
                ${item.quantity} 
            </td>
            <td style="text-align: right">
                <fmt:formatNumber value="${item.totalPrice}" type="currency"/>
            </td>

        </tr>
    </c:forEach>
    
</table>
<div class="row">
    <div class="col-md-10"></div>
    <div class="col-md-2">
        
    <a href="<c:url value="/order/index.do?id=${account.id}&role=${account.role}"/>" class="btn btn-outline-dark ">
        Back to orders</a>
    </div>

</div>
    
