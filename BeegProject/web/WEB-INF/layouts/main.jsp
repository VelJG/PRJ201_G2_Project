<%-- 
    Document   : main
    Created on : Feb 10, 2025, 10:43:50 AM
    Author     : AN KHUONG
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi-VN" scope="session"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<c:url value="/css/site.css"/>" rel="stylesheet" type="text/css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script> 
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-sm-12 header">
                    <a href="<c:url value="/"/>" ><img src="<c:url value="/laptops/logo.png"/>" class="logo"></a></h1> 
                <div>
                        <c:if test="${account==null}">
                             <a href="" class="btn " data-bs-toggle="modal" data-bs-target="#loginModal">Login</a> 
                        </c:if>
                              <c:if test="${account!=null}">
                                  <span class="btn"> Welcome ${account.fullName}</span> |
                                  <a href="<c:url value="/account/logout.do"/>" class="btn ">Logout</a> 
                        </c:if>
                        |
                        <a href="<c:url value="/cart/index.do"/> " class="btn">
                            <c:if test="${cart.total==0}">
                                <i class="bi bi-cart"></i> 
                            </c:if>

                            <c:if test="${cart.total!=0}">
                                <i class="bi bi-cart-fill"></i>
                            </c:if>
                            <fmt:formatNumber value="${cart.total}" type="currency"/>
                        </a>
                    </div>
                </div>

                <div class="col-sm-12">
                    <!--Content-->
                    <jsp:include page="/WEB-INF/${controller}/${action}.jsp"></jsp:include>
                </div>


                <div class="col-sm-12 footer">

                    <p style="text-align:center">Copyrights &copy; by Group 2 <i class="bi bi-emoji-sunglasses"></i><p/>
                </div>
            </div>     
        </div>

        <!--Footer-->

    </body>
</html>
<div class="modal" id="loginModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="<c:url value="/account/login.do"/>">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Login</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <div class="mb-3 mt-3">
                        <label for="email" class="form-label">Email:</label>
                        <input type="email" class="form-control" id="email" placeholder="Enter email" name="email">
                    </div>
                    <div class="mb-3">
                        <label for="pwd" class="form-label">Password:</label>
                        <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="password">
                    </div>
                    <div class="form-check mb-3">
                        <label class="form-check-label">
                            <input class="form-check-input" type="checkbox" name="remember"> Remember me
                        </label>
                    </div>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary" data-bs-dismiss="modal">Login</button>
                    <button type="submit" class="btn btn-danger" data-bs-dismiss="modal">Cancel</button>
                </div>
            </form>
        </div>
    </div>
</div>