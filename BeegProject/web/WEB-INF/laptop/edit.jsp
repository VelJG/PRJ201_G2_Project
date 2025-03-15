<%-- 
    Document   : edit
    Created on : Feb 16, 2025, 8:53:53 PM
    Author     : AN KHUONG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<h2 style="text-align: center; color:red;">Edit Laptop</h2>
<div  class="row" style="display:block; text-align: center;"> 
    <div >
        <img style=" height: 100% " src="<c:url value="/laptops/${laptop.id}.png"/>" alt=" nuhuh"/>

    </div>
    <div style="display:block;  margin:0; padding:10px">
        <form action="<c:url value="/laptop/edit_handler.do"/>">
            Id:<br>
            <input type="text" disabled="" name="id" value="${laptop.id}"><br>
            <input type="hidden" name="id" value="${laptop.id}">
           Name: <br>
            <input type="text" name="name" value="${param.name!=null?param.name:laptop.name}"><br>
            Brand: <br>
            <input type="text" name="brand" value="${param.brand!=null?param.brand:laptop.brand}"><br>
           Model: <br>
            <input type="text" name="model" value="${param.model!=null?param.model:laptop.model}"><br>
            Description:<br>
            <input type="text" name="description" value="${param.description!=null?param.description:laptop.description}"><br>
            Price:<br>
            <input type="number" name="price" value="${param.price!=null?param.price:laptop.formattedPrice}" min="0"> đ<br>
            <button type="submit" value="edit" name="op">Confirm</button>
            <button type="submit" value="cancel" name="op">Cancel</button>
        </form>
    </div>
   
</div>