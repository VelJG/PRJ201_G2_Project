<%-- 
    Document   : index
    Created on : Feb 13, 2025, 11:17:02 AM
    Author     : AN KHUONG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="row">
    <div class="col-sm-12 " style="margin-bottom:10px;">
        <div class="float-end pagenav">
            Page: ${page}/${totalPage}
            <a href="<c:url value="/?page=1"/>" class="btn btn-sm btn-primary ${page==1?"disabled":""}" ><i class="bi bi-arrow-90deg-left"></i></a>
            <a href="<c:url value="/?page=${page - 1}"/>"  class="btn btn-sm btn-primary ${page==1?"disabled":""}"><i class="bi bi-arrow-left"></i></a>  
            <a href="<c:url value="/?page=${page + 1} "/>" class="btn btn-sm btn-primary  ${page==totalPage?"disabled":""}"><i class="bi bi-arrow-right"></i></a>
            <a href="<c:url value="/?page=${totalPage}"/>" class="btn btn-sm btn-primary ${page==totalPage?"disabled":""}"><i class="bi bi-arrow-90deg-right"></i></a>

        </div>
    </div>
</div>
<div class="row" >
    <c:forEach var="laptop" items="${list}"> 
        <div class="col-sm-3 laptopContainer"> 
            <div class="laptop">
                <img class="laptopImg"src="<c:url value="/laptops/${laptop.id}.png"/>" alt=" nuhuh"/>
                <div class="laptopInfo">
                   

                   
                    <span style="color:red; font-weight: 600; font-size: larger"><fmt:formatNumber value="${laptop.price}" type="currency"/></span><br>
                    <div style="margin-top: 20px;">
                        <a href="<c:url value="/laptop/detail.do?id=${laptop.id}" />" class="btn " style="background-color: blue; color:white ">View detail</a>  
                    </div>
                    <!--<a href="<c:url value="/laptop/edit.do?id=${laptop.id}"/>">Edit</a>-->
                </div>
            </div>


        </div>

    </c:forEach>


</div>
