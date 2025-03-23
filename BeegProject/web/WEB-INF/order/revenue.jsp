<%-- 
    Document   : revenue
    Created on : Mar 19, 2025, 1:56:17 PM
    Author     : QUAN KHUU
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<div class="laptop-manage-container">
    <div class="header-bar">
        <h2>Select a Date</h2>
    </div>
    <form action="<c:url value='/order/revenue_handler.do'/>" method="post" class="laptop-manage-container">
        <label for="date" class="text-white">Select Date:</label>
        <input type="date" id="date" name="selectedDate" required value="${param.selectedDate}" class="search-bar input"><br/>
        
        <label for="option" class="text-white">View By:</label>
        <select id="option" name="opDate" class="search-bar input">
            <option value="daily" ${param.opDate == 'daily' ? 'selected' : ''}>Daily</option>
            <option value="monthly" ${param.opDate == 'monthly' ? 'selected' : ''}>Monthly</option>
            <option value="yearly" ${param.opDate == 'yearly' ? 'selected' : ''}>Yearly</option>
        </select>
        <br>
        <button type="submit" class="search-button">View Revenue</button>
    </form>
    
    <div class="result custom-table">
        <h2>Revenue: <span style="color:red;"><fmt:formatNumber value="${totalRevenue}" type="number" pattern="#,##0"/></span></h2>
    </div> 
</div>