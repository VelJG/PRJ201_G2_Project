/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import com.google.gson.Gson;
import db.OrderDetail;
import db.OrderHeader;
import db.OrderHeaderFacade;
import db.RevenueResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author AN KHUONG
 */
@WebServlet(name = "OrderController", urlPatterns = {"/order"})
public class OrderController extends HttpServlet {

    private final OrderHeaderFacade oh = new OrderHeaderFacade();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getAttribute("action").toString();
        switch (action) {
            case "index":
                index(request, response);
                break;
            case "detail":
                detail(request, response);
                break;
            case "delete":
                delete(request, response);
                break;
            case "changeStatus":
                changeStatus(request, response);
                break;
            case "revenue":
                revenue(request, response);
                break;
            case "revenue_handler":
                revenue_handler(request, response);
                break;
            case "revenue_chart":
                revenue_chart(request, response);
                break;
        }
    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            int accountId = Integer.parseInt(request.getParameter("id"));
            List<OrderHeader> orders = oh.getOrders(accountId);
            request.setAttribute("orders", orders);
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    protected void detail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {

            int id = Integer.parseInt(request.getParameter("id"));
            List<OrderDetail> detail = oh.getDetailById(id);
            request.setAttribute("detail", detail);
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    protected void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {

            int id = Integer.parseInt(request.getParameter("id"));
            int accountId = Integer.parseInt(request.getParameter("accountId"));
            oh.remove(id);
            List<OrderHeader> orders = oh.getOrders(accountId);
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/order/index.do?id=" + accountId)
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    protected void changeStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");
            oh.changeStatus(orderId, status);
            request.getRequestDispatcher("/order/index.do").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    protected void revenue(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
    }

    protected void revenue_handler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String opDate = request.getParameter("opDate");
            switch (opDate) {
                case "daily":
                    daily(request, response);
                    break;
                case "monthly":
                    monthly(request, response);
                    break;
                case "yearly":
                    yearly(request, response);
                    break;
            }
            request.getRequestDispatcher("/order/revenue.do").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    protected void daily(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException, SQLException {
        String selectedDate_str = request.getParameter("selectedDate");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date selectedDate = sdf.parse(selectedDate_str);
        OrderHeaderFacade ohf = new OrderHeaderFacade();
        double totalRevenue = ohf.daily(selectedDate);
        request.setAttribute("totalRevenue", totalRevenue);
        request.getRequestDispatcher("/order/revenue.do").forward(request, response);
    }

    protected void monthly(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException, SQLException {
        String selectedDate_str = request.getParameter("selectedDate");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date selectedDate = sdf.parse(selectedDate_str);
        OrderHeaderFacade ohf = new OrderHeaderFacade();
        double totalRevenue = ohf.monthly(selectedDate);
        request.setAttribute("totalRevenue", totalRevenue);
        request.getRequestDispatcher("/order/revenue.do").forward(request, response);
    }

    protected void yearly(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException, SQLException {
        String selectedDate_str = request.getParameter("selectedDate");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date selectedDate = sdf.parse(selectedDate_str);
        OrderHeaderFacade ohf = new OrderHeaderFacade();
        double totalRevenue = ohf.yearly(selectedDate);
        request.setAttribute("totalRevenue", totalRevenue);
        request.getRequestDispatcher("/order/revenue.do").forward(request, response);
    }

    protected void revenue_chart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            String selectedDate_str = request.getParameter("selectedDate");
            if (selectedDate_str == null || selectedDate_str.isEmpty()) {
                throw new IllegalArgumentException("selectedDate is missing");
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date selectedDate = sdf.parse(selectedDate_str);

            OrderHeaderFacade ohf = new OrderHeaderFacade();

            List<Double> monthlyRevenues = ohf.getMonthlyRevenues(selectedDate);
            List<String> months = Arrays.asList("Jan", "Feb", "Mar", "Apr", "May", "Jun",
                    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");

            String jsonResponse = new Gson().toJson(new RevenueResponse(months, monthlyRevenues));
            response.getWriter().write(jsonResponse);

        } catch (Exception e) {
            e.printStackTrace(); // Log lỗi trong console
            response.sendError(HttpServletResponse
                    .SC_INTERNAL_SERVER_ERROR, "Internal Server Error: " + e.getMessage());
        }
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    } // </editor-fold>

}
