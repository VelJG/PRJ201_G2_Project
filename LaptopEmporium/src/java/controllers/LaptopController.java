/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import db.Laptop;
import db.LaptopFacade;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.servlet.annotation.MultipartConfig;

/**
 *
 * @author AN KHUONG
 */
@WebServlet(name = "LaptopController", urlPatterns = {"/laptop"})
@MultipartConfig
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
            case "create":
                create(request, response);
                break;
            case "create_handler":
                create_handler(request, response);
                break;
            case "edit":
                edit(request, response);
                break;
            case "edit_handler":
                edit_handler(request, response);
                break;
            case "delete":
                delete(request, response);
                break;
            case "detail":
                detail(request, response);
                break;
            case "uploadImage":
                uploadImage(request, response);
                break;
            case "manage":
                manage(request, response);
                break;
        }
    }

    protected void index(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int pageSize = 8;
            HttpSession session = request.getSession();
            Integer page = (Integer) session.getAttribute("page");
            if (page == null) {
                page = 1;
            }
            String spage = request.getParameter("page");
            if (spage != null) {
                page = Integer.parseInt(spage);
            }
            session.setAttribute("page", page);

            String search = request.getParameter("search");
            String sort = request.getParameter("sort");

            List<Laptop> list;
            if (search != null && !search.trim().isEmpty()) {
                list = lf.search(search);
                request.setAttribute("search", search);
            } else {
                if ("desc".equals(sort)) {
                    list = lf.priceDesc(page, pageSize);
                } else if ("asc".equals(sort)) {
                    list = lf.priceAsc(page, pageSize);
                } else {
                    list = lf.select(page, pageSize);
                }
            }

            request.setAttribute("list", list);
            request.setAttribute("sort", sort); 


            int row_count = lf.count();
            int totalPage = (int) Math.ceil((double) row_count / pageSize);
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
                    String brand = request.getParameter("brand");
                    String model = request.getParameter("model");
                    String name = request.getParameter("name");
                    laptop.setId(id);
                    laptop.setBrand(brand);
                    laptop.setDescription(description);
                    laptop.setPrice(price);
                    laptop.setModel(model);
                    laptop.setName(name);
                    lf.edit(laptop);
                case "cancel":
                    request.getRequestDispatcher("/laptop/manage.do").forward(request, response);
                    break;
            }

        } catch (Exception ex) {
            ex.printStackTrace();

        }
    }

    protected void create(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

    }

    protected void delete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String uploadPath = getServletContext().getRealPath("/laptops").replace("\\build", "");
            lf.delete(id,uploadPath);
            response.sendRedirect(request.getContextPath() + "/laptop/manage.do");

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    protected void create_handler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String op = request.getParameter("op");
            switch (op) {
                case "create":
                    Laptop laptop = new Laptop();
                    String description = request.getParameter("description");
                    double price = Double.parseDouble(request.getParameter("price"));
                    String brand = request.getParameter("brand");
                    String model = request.getParameter("model");
                    String name = request.getParameter("name");
                    laptop.setBrand(brand);
                    laptop.setDescription(description);
                    laptop.setPrice(price);
                    laptop.setModel(model);
                    laptop.setName(name);
                    lf.create(laptop);
                    request.getRequestDispatcher("/laptop/uploadImage.do")
                            .forward(request, response);
                    break;

                case "cancel":
                    request.getRequestDispatcher("/laptop/manage.do").forward(request, response);

                    break;
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    protected void uploadImage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(Config.LAYOUT).forward(request, response);

    }

    protected void manage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Laptop> list = lf.select();
            request.setAttribute("list", list);
            request.getRequestDispatcher(Config.LAYOUT).forward(request, response);
        } catch (SQLException ex) {
            ex.printStackTrace();
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
        String uploadPath = getServletContext().getRealPath("/laptops").replace("\\build", "");
        try {
            Part filePart = request.getPart("file"); // Get the uploaded file part
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths
                        .get(filePart.getSubmittedFileName()).getFileName().toString();
                if (!fileName.isEmpty()) {
                    String filePath = uploadPath + File.separator + lf.getNextId() + ".png";
                    filePart.write(filePath);
                    request.setAttribute("message", "File uploaded successfully to " + filePath);
                } else {
                    request.setAttribute("message", "Invalid file name.");
                }
            } else {
                request.setAttribute("message", "No file selected or empty file.");
            }
        } catch (Exception ex) {
            request.setAttribute("message", "File upload failed: " + ex.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/laptop/index.do");

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
