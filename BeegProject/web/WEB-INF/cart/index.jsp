<%-- 
    Document   : cart
    Created on : Feb 24, 2025, 10:09:47 AM
    Author     : AN KHUONG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<table class="table table-striped"> 
    <tr>
        <th>No.</th>
        <th>Image</th>
        <th>Id</th>
        <th>Description</th>
        <th style="text-align: right">Price</th>
        <th style="text-align: right">Quantity</th>
        <th style="text-align: right">Cost</th>
        <th>Operations</th>
    </tr>
    <c:forEach var="item" items="${cart.items}" varStatus="loop">

        <tr>
            <td>${loop.count}</td>
            <td>  <img src="<c:url value="/laptops/${item.id}.png"/>" alt="" height="60px"/></td>
            <td>${item.id}</td>
            <td>${item.laptop.description}</td>
            <td style="text-align: right">
                <fmt:formatNumber value="${item.laptop.price}" type="currency"/>
            </td>
          
            <td style="text-align: right">
                <input type="number" min="0" name="quantity" value="${item.quantity}" style="width: 40px;">
            </td>
            <td style="text-align: right">
                <fmt:formatNumber value="${item.cost}" type="currency"/>
            </td>
            <td>
                <a href="#" class="update" data-id="${item.id}" data-quantity="${item.quantity}">Update</a> |
                <a href="<c:url value="/cart/remove.do?id=${item.id}"/>">Remove</a>
            </td>
        </tr>
    </c:forEach>
    <tr>
        <th style="text-align: right" colspan="7">Total</th>
        <th style="text-align: right"><fmt:formatNumber value="${cart.total}" type="currency"/></th>
        <th><a href="<c:url value="/cart/empty.do"/>">Empty Cart</a></th>
    </tr>
</table>
        <a href="<c:url value="/cart/checkout.do"/>">Check out</a>
    <script>
        $(".update").click(function(){
           var id=$(this).data("id");
           var quantity = $(this).closest("tr").find("input[name='quantity']").val();
           var url = `<c:url value="/cart/update.do?id=\${id}&quantity=\${quantity}" />`;
           window.location=url;
        });
    </script>