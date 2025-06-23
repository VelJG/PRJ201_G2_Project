<%-- 
    Document   : manage
    Created on : Mar 21, 2025, 8:47:11 PM
    Author     : AN KHUONG
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${account.role != 'ADMIN'}">
            
    <jsp:forward page="/laptop/index.do"></jsp:forward>
           
        </c:if> 
<!DOCTYPE html>
<div class="laptop-manage-container">
    <div class="header-bar">
        <h2>Manage Laptops</h2>
        <a href="<c:url value='/laptop/create.do'/>" class="btn btn-success">
            <i class="fas fa-plus"></i> Add New Laptop
        </a>
        <a href="<c:url value='/order/revenue.do'/>" class="btn btn-success"><i class="bi bi-currency-dollar"></i>View Revenue
</a>
    </div>

    <!-- Laptops Table -->
    <div class="table-responsive">
        <table class="table custom-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Brand</th>
                    <th>Model</th>
                    <th>Description</th>
                    <th class="text-end">Price</th>
                    <th class="text-end">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="laptop" items="${list}" varStatus="loop">
                    <tr>
                        <td>${laptop.id}</td>
                        <td>
                            <img src="<c:url value='/laptops/${laptop.id}.png'/>" 
                                 alt="Laptop Image" class="laptop-thumbnail">
                        </td>
                        <td>${laptop.name}</td>
                        <td>${laptop.brand}</td>
                        <td>${laptop.model}</td>
                        <td>${laptop.description}</td>
                        <td class="text-end price">
                            <fmt:formatNumber value="${laptop.price}" type="currency"/>
                        </td>
                        <td class="text-end">
                            <a href="<c:url value='/laptop/edit.do?id=${laptop.id}'/>" 
                               class="btn btn-outline-primary btn-sm">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <button class="btn btn-outline-danger btn-sm" 
                                    onclick="confirmDelete('<c:url value='/laptop/delete.do?id=${laptop.id}'/>')">
                                <i class="fas fa-trash"></i> Delete
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    function confirmDelete(url) {
        if (confirm("Are you sure you want to delete this laptop?")) {
            window.location.href = url;
        }
    }
</script>

