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
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
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
            List<Laptop> list = null;
            String search = request.getParameter("search");

            if (search == null || search.trim().isEmpty()) {
                String sort = request.getParameter("sort");

                if (sort != null) {
                    switch (sort) {
                        case "desc":
                            list = lf.priceDesc(page, pageSize);
                            break;
                        case "asc":
                            list = lf.priceAsc(page, pageSize);
                            break;
                    }
                } else {
                    list = lf.select(page, pageSize);
                }
            } else {
                list = lf.search(search);
                request.setAttribute("search", search);
            }
            request.setAttribute("list", list);

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
                    laptop.setId(id);
                    laptop.setBrand(brand);
                    laptop.setDescription(description);
                    laptop.setPrice(price);
                    laptop.setModel(model);
                    lf.edit(laptop);
                case "cancel":
                    request.getRequestDispatcher("/laptop/index.do").forward(request, response);
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
            lf.delete(id);
            response.sendRedirect(request.getContextPath() + "/laptop/index.do");

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
                    laptop.setBrand(brand);
                    laptop.setDescription(description);
                    laptop.setPrice(price);
                    laptop.setModel(model);
                    lf.create(laptop);
                case "cancel":
                    request.getRequestDispatcher("/laptop/index.do").forward(request, response);
                    break;
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

//    private void upload_image(HttpServletRequest request, HttpServletResponse response)
//        throws ServletException, IOException {
//        
//    try {
//        Part filePart = request.getPart("file");
//        if (filePart == null || filePart.getSize() <= 0) {
//            throw new IllegalArgumentException("No file uploaded.");
//        }
//
//        String uploadPath = getServletContext().getRealPath("/laptops");
//        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
//        File file = new File(uploadPath, fileName);
//
//        try (InputStream fileContent = filePart.getInputStream();
//             FileOutputStream outputStream = new FileOutputStream(file)) {
//            byte[] buffer = new byte[1024];
//            int bytesRead;
//            while ((bytesRead = fileContent.read(buffer)) != -1) {
//                outputStream.write(buffer, 0, bytesRead);
//            }
//        }
//
//        // Prevent infinite loop by redirecting instead of forwarding
//        response.sendRedirect("/success.jsp");
//
//    } catch (Exception ex) {
//        ex.printStackTrace();
//        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "File upload failed.");
//    }
//}
//   
//   
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
