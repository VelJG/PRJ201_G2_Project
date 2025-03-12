<%-- 
    Document   : index
    Created on : Feb 13, 2025, 11:17:02 AM
    Author     : AN KHUONG
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="row">

    <div class="col-sm-12 " style="margin-bottom:10px; border-bottom: double 2px black; padding: 10px;"> 
        <c:if test="${search==null}">
            <div class="float-end pagenav">
                Page: ${page}/${totalPage}
                <a href="<c:url value="/?page=1&sort=${param.sort}"/>" class="btn btn-sm btn-primary ${page==1?"disabled":""}" ><i class="bi bi-arrow-90deg-left"></i></a>
                <a href="<c:url value="/?page=${page - 1}&sort=${param.sort}"/>"  class="btn btn-sm btn-primary ${page==1?"disabled":""}"><i class="bi bi-arrow-left"></i></a>  
                <a href="<c:url value="/?page=${page + 1}&sort=${param.sort} "/>" class="btn btn-sm btn-primary  ${page==totalPage?"disabled":""}"><i class="bi bi-arrow-right"></i></a>
                <a href="<c:url value="/?page=${totalPage}&sort=${param.sort}"/>" class="btn btn-sm btn-primary ${page==totalPage?"disabled":""}"><i class="bi bi-arrow-90deg-right"></i></a>
            </div>
        </c:if>
        <form action="<c:url value="/laptop/index.do"/>" class="mb-3">
            <input type="text" name="search" placeholder="Search..." value="${param.search}">
            <button type="submit" class="btn btn-primary">Search</button>
        </form>

        <form action="<c:url value='/laptop/index.do'/>" id="sortForm">
            <div class="form-group col-sm-3">
                <label for="sort">Sort by Price</label>
                <select name="sort" class="form-control" onchange="document.getElementById('sortForm').submit();">
                    <option value="" ${param.sort == '' ? 'selected' : ''}>Select Sorting</option>
                    <option value="asc" ${param.sort == 'asc' ? 'selected' : ''}>Price Ascending</option>
                    <option value="desc" ${param.sort== 'desc' ? 'selected' : ''}>Price Descending</option>
                </select>
            </div>
        </form>

    </div>
</div>
<c:if test="${account.role=='ADMIN'}">
    <a href="<c:url value="/laptop/create.do"/>" class="btn btn-primary">Create</a>
</c:if>
<div class="row" >
    <c:if test="${empty list}">
        <span style="color:red; text-align: center;">No item was found</span>
    </c:if>
    <c:forEach var="laptop" items="${list}"> 
        <div class="col-sm-3 laptopContainer"> 
            <div class="laptop">
                <img class="laptopImg"src="<c:url value="/laptops/${laptop.id}.png"/>" alt=" nuhuh"/>
                <div class="laptopInfo">
                    <span style="color:red; font-weight: 600; font-size: larger"><fmt:formatNumber value="${laptop.price}" type="currency"/></span><br>
                    <div style="margin-top: 20px;">
                        <a href="<c:url value="/laptop/detail.do?id=${laptop.id}" />" class="btn " style="background-color: blue; color:white ">View detail</a>  
                    </div>
                </div>
            </div>


        </div>

    </c:forEach>


</div>
