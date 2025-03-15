<%-- 
    Document   : cart
    Created on : Feb 24, 2025, 10:09:47 AM
    Author     : AN KHUONG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="container mt-4">
    <div class="row">
        <div class="col-md-8">
            <table class="table table-striped align-middle">
                <thead class="table-light">
                    <tr>
                        <th>No.</th>
                        <th>Image</th>
                        <th>Id</th>
                        <th>Description</th>
                        <th class="text-end">Price</th>
                        <th class="text-end">Quantity</th>
                        <th class="text-end">Cost</th>
                        <th>Operations</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${cart.items}" varStatus="loop">
                        <tr>
                            <td>${loop.count}</td>
                            <td><img src="<c:url value="/laptops/${item.id}.png"/>" alt="" height="60px"/></td>
                            <td>${item.id}</td>
                            <td>${item.laptop.description}</td>
                            <td class="text-end"><fmt:formatNumber value="${item.laptop.price}" type="currency"/></td>
                            <td class="text-end">
                                <input type="number" min="0" name="quantity" value="${item.quantity}" class="form-control text-center" style="width: 60px;">
                            </td>
                            <td class="text-end"><fmt:formatNumber value="${item.cost}" type="currency"/></td>
                            <td>
                                <a href="#" class="update btn btn-sm btn-warning" data-id="${item.id}" data-quantity="${item.quantity}"><i class="bi bi-pencil"></i></a>
                                <a href="<c:url value="/cart/remove.do?id=${item.id}"/>" class="btn btn-sm btn-danger"><i class="bi bi-trash3"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="col-md-4">
            <div class="card p-3 shadow">
                <h4 class="mb-3">Order Summary</h4>
                <div class="d-flex justify-content-between">
                    <span>Subtotal:</span>
                    <strong><fmt:formatNumber value="${cart.total}" type="currency"/></strong>
                </div>
                <div class="d-flex justify-content-between">
                    <span>Delivery:</span>
                    <strong>FREE</strong>
                </div>
                <hr>
                <div class="d-flex justify-content-between">
                    <span>Total:</span>
                    <strong><fmt:formatNumber value="${cart.total}" type="currency"/></strong>
                </div>
                <a href="<c:url value="/cart/checkout.do"/>" class="btn btn-success w-100 mt-3">Checkout</a>
                <a href="<c:url value="/cart/empty.do"/>" class="btn btn-outline-danger w-100 mt-2">Empty Cart</a>
            </div>
        </div>
    </div>
</div>
<<script>
        $(".update").click(function(){
           var id=$(this).data("id");
           var quantity = $(this).closest("tr").find("input[name='quantity']").val();
           var url = `<c:url value="/cart/update.do?id=\${id}&quantity=\${quantity}" />`;
           window.location=url;
        });
    </script>