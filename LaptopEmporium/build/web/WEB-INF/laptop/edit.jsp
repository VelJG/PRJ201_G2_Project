<%-- 
    Document   : edit
    Created on : Feb 16, 2025, 8:53:53 PM
    Author     : AN KHUONG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div class="laptop-manage-container d-flex justify-content-center">
    <div class="form-wrapper" style="max-width: 500px; width: 100%;">
        <div class="header-bar d-flex justify-content-center">
            <h1 class="text-white text-center">Edit Laptop</h1>
        </div>
        <div class="text-center mb-3">
            <img style="max-width: 100%; height: auto; border: 3px solid white; border-radius: 10px; padding: 5px" src="<c:url value='/laptops/${laptop.id}.png'/>" alt="Laptop Image">
        </div>
        <form action="<c:url value='/laptop/edit_handler.do'/>">
            <div class="mb-3">
                <label class="form-label text-white">Id:</label>
                <input type="text" class="form-control" disabled value="${laptop.id}">
                <input type="hidden" name="id" value="${laptop.id}">
            </div>

            <div class="mb-3">
                <label class="form-label text-white">Name:</label>
                <input type="text" name="name" class="form-control"
                       value="${param.name!=null?param.name:laptop.name}" required>
            </div>

            <div class="mb-3">
                <label class="form-label text-white">Brand:</label>
                <input type="text" name="brand" class="form-control"
                       value="${param.brand!=null?param.brand:laptop.brand}" required>
            </div>

            <div class="mb-3">
                <label class="form-label text-white">Model:</label>
                <input type="text" name="model" class="form-control"
                       value="${param.model!=null?param.model:laptop.model}" required>
            </div>

            <div class="mb-3">
                <label class="form-label text-white">Description:</label>
                <input type="text" name="description" class="form-control"
                       value="${param.description!=null?param.description:laptop.description}" required>
            </div>

            <div class="mb-3">
                <label class="form-label text-white">Price:</label>
                <div class="input-group">
                    <input type="number" name="price" class="form-control"
                           value="${param.price!=null?param.price:laptop.formattedPrice}" min="0" required>
                    <span class="input-group-text">đ</span>
                </div>
            </div>

            <div class="d-flex justify-content-between">
                <button type="submit" value="edit" name="op" class="btn btn-success">
                    <i class="fas fa-check"></i> Confirm
                </button>
                <button type="submit" value="cancel" name="op" formnovalidate class="btn btn-secondary">
                    <i class="fas fa-times"></i> Cancel
                </button>
            </div>
        </form>
    </div>
</div>
