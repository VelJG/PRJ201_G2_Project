<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container">
    <div class="row my-3 d-flex justify-content-between align-items-center">
        <div class="col-auto">
            <form action="<c:url value='/laptop/index.do'/>" id="sortForm">
                <label for="sort" class="form-label">Sort by Price</label>
                <select name="sort" class="form-select" onchange="document.getElementById('sortForm').submit();">
                    <option value="" ${param.sort == '' ? 'selected' : ''}>None</option>
                    <option value="asc" ${param.sort == 'asc' ? 'selected' : ''}>Price Ascending</option>
                    <option value="desc" ${param.sort == 'desc' ? 'selected' : ''}>Price Descending</option>
                </select>
            </form>
        </div>
    </div>

    <c:if test="${account.role=='ADMIN'}">
        <a href="<c:url value='/laptop/create.do'/>" class="btn btn-success my-3">Add New Laptop</a>
    </c:if>
    <c:if test="${not empty account}">
        <a href="<c:url value='/order/index.do?id=${account.id}'/>" class="btn btn-outline-dark">
                View order
            </a>
    </c:if>
    <div class="row">
        <c:if test="${empty list}">
            <div class="text-center text-danger fs-5">No laptops found.</div>
        </c:if>
        <c:forEach var="laptop" items="${list}"> 
            <div class="col-md-4 col-lg-3 mb-4">
                <div class="card h-100 shadow-sm">
                    <img src="<c:url value='/laptops/${laptop.id}.png'/>" class="card-img-top" alt="Laptop Image">
                    <div class="card-body text-center">
                        <h5 class="fw-bold">${laptop.name}</h5>
                        <h5 class="text-danger fw-bold">
                            <fmt:formatNumber value="${laptop.price}" type="currency"/>
                        </h5>
                        <a href="<c:url value='/laptop/detail.do?id=${laptop.id}'/>" class="btn btn-primary w-100 mt-2">View Details</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div >
    <div class="row my-3 d-flex justify-content-between align-items-center">
        <c:if test="${search == null}">
            <ul class="pagination justify-content-center">
                <li class="page-item ${page == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/?page=1&sort=${param.sort}'/>"><<</a>
                </li>
                <li class="page-item ${page == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/?page=${page - 1}&sort=${param.sort}'/>"> < </a>
                </li>
                <c:forEach var="i" begin="1" end="${totalPage}">
                    <li class="page-item ${page == i ? 'active' : ''}">
                        <a class="page-link" href="<c:url value='/?page=${i}&sort=${param.sort}'/>">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${page == totalPage ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/?page=${page + 1}&sort=${param.sort}'/>">></a>
                </li>
                <li class="page-item ${page == totalPage ? 'disabled' : ''}">
                    <a class="page-link" href="<c:url value='/?page=${totalPage}&sort=${param.sort}'/>">>></a>
                </li>
            </ul>
        </c:if>
    </div>

</div>

