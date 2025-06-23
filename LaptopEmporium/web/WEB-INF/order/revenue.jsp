<%-- 
    Document   : revenue
    Created on : Mar 19, 2025, 1:56:17 PM
    Author     : QUAN KHUU
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<div class="laptop-manage-container d-flex justify-content-center">
    <div class="form-wrapper" style="max-width: 500px; width: 100%;">
        <div class="header-bar d-flex justify-content-center">
            <h2 class="text-white text-center">Select a Date</h2>
        </div>

        <form action="<c:url value='/order/revenue_handler.do'/>" method="post" class="text-center">
            <!-- Date Input -->
            <div class="mb-3">
                <label for="date" class="form-label text-white">Select Date:</label>
                <input type="date" id="date" name="selectedDate" required value="${param.selectedDate}" class="form-control">
            </div>

            <!-- View Option Dropdown -->
            <div class="mb-3">
                <label for="option" class="form-label text-white">View By:</label>
                <select id="option" name="opDate" class="form-control">
                    <option value="daily" <c:if test="${param.opDate == 'daily'}">selected</c:if>>Daily</option>
                    <option value="monthly" <c:if test="${param.opDate == 'monthly'}">selected</c:if>>Monthly</option>
                    <option value="yearly" <c:if test="${param.opDate == 'yearly'}">selected</c:if>>Yearly</option>
                    </select>
                </div>

                <!-- Buttons -->
                <div class="d-flex justify-content-between">
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-search"></i> View Revenue
                    </button>
                <c:if test="${param.opDate == 'yearly'}"> 
                    <button type="button" id="loadChartBtn" class="btn btn-primary">
                        <i class="fas fa-chart-bar"></i> View Chart
                    </button>
                </c:if>
               
            </div>
        </form>

        <!-- Revenue Display -->
        <div class="result custom-table">
            <h2>Revenue: <span style="color:red;"><fmt:formatNumber value="${totalRevenue}" type="number" pattern="#,##0"/>đ</span></h2>
        </div> 
        <canvas id="monthlyChart"></canvas>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </div>

</div>

<script>
    function loadChart(selectedDate) {
        console.log("Date is loading:", selectedDate);

        fetch("<c:url value='/order/revenue_chart.do'/>?selectedDate=" + selectedDate)
                .then(response => response.json())
                .then(data => {
                    console.log("Date is received:", data);

                    if (!data.months || !data.monthlyRevenues) {
                        console.error("Invalid data!");
                        return;
                    }

                    if (window.monthlyChart && typeof window.monthlyChart.destroy === 'function') {
                        window.monthlyChart.destroy();
                    }

                    const monthlyCtx = document.getElementById('monthlyChart').getContext('2d');
                    window.monthlyChart = new Chart(monthlyCtx, {
                        type: 'bar',
                        data: {
                            labels: data.months,
                            datasets: [{
                                    label: 'Monthly revenue',
                                    data: data.monthlyRevenues,
                                    backgroundColor: 'green'
                                }]
                        }
                    });
                })
                .catch(error => console.error("Error when loading data:", error));
    }

    document.getElementById("loadChartBtn").addEventListener("click", function (event) {
        event.preventDefault();
        const selectedDate = document.getElementById("date").value;
        if (selectedDate) {
            loadChart(selectedDate);
        } else {
            alert("Please enter date!");
        }
    });
</script>