/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import db.Laptop;
import db.LaptopFacade;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author AN KHUONG
 */
@WebServlet(name = "LaptopController", urlPatterns = {"/laptop"})
public class LaptopController extends HttpServlet {
    
    private final LaptopFacade lf = new LaptopFacade();

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
            case "edit":
                edit(request, response);
                break;
            case "edit_handler":
                edit_handler(request, response);
                break;
            case "detail":
                detail(request,response);
                break;
        }
    }
    
    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int pageSize = 8;
            HttpSession session=request.getSession();
            Integer page=(Integer)session.getAttribute("page");
            if(page==null){
                page=1;
            }
            String spage = request.getParameter("page");   
            if(spage!=null){
                page=Integer.parseInt(spage);
            }
            session.setAttribute("page", page);
            List<Laptop> list = lf.select(page, pageSize);
            request.setAttribute("list", list);
            int row_count=lf.count();
            int totalPage=(int)Math.ceil((double)row_count/pageSize);
            request.setAttribute("totalPage", totalPage);
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    protected void detail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Laptop laptop = new Laptop();
            laptop = lf.select(id);
            request.setAttribute("laptop", laptop);
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    protected void edit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            
            Laptop laptop = new Laptop();
            laptop = lf.select(id);
            request.setAttribute("laptop", laptop);
            List<Laptop> list = lf.select();
            request.setAttribute("list", list);
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    protected void edit_handler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String op = request.getParameter("op");
            switch (op) {
                case "edit":
                    System.out.println("Start edit");
                    Laptop laptop = new Laptop();
                    int id = Integer.parseInt(request.getParameter("id"));
                    String description = request.getParameter("description");
                    double price = Double.parseDouble(request.getParameter("price"));
                    String brand=request.getParameter("brand");
                    laptop.setId(id);
                    laptop.setBrand(brand);
                    laptop.setDescription(description);
                    laptop.setPrice(price);
                    lf.edit(laptop);
                case "cancel":
                    request.getRequestDispatcher("/laptop/index.do").forward(request, response);
                    break;
            }
            
        } catch (Exception ex) {
            ex.printStackTrace();
            
        }
    }
    
    protected void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            
            List<Laptop> list = lf.select();
            request.setAttribute("list", list);
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
    }// </editor-fold>

}
