<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<h2 style="text-align: center; color:red;">Create Laptop</h2>
<div  class="row" style="display:block; text-align: center;"> 
    <div style="display:block;  margin:0; padding:10px">
        <form action="<c:url value="/laptop/create_handler.do"/>">
            Name: <br>
            <input type="text" name="name" value="${param.name!=null?param.name:laptop.name}" required=""><br>
            Brand: <br>
            <input type="text" name="brand" value="${param.brand!=null?param.brand:laptop.brand}" required=""><br>
            Model: <br>
            <input type="text" name="model" value="${param.model!=null?param.model:laptop.model}" required=""><br>
            Description:<br>
            <input type="text" name="description" value="${param.description!=null?param.description:laptop.description}" required=""><br>
            Price:<br>
            <input type="number" name="price" value="${param.price!=null?param.price:laptop.formattedPrice}" min="0" required=""> đ<br>
            <button type="submit" value="create" name="op">Create</button>
            <button type="submit" value="cancel" name="op" formnovalidate>Cancel</button>
        </form>
    </div>
</div>

