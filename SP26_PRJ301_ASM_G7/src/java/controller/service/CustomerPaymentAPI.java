/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.service;

import dal.BookingDAO;
import dal.CardDAO;
import dal.PaymentTransactionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.ParkingCard;
import model.PaymentTransaction;
import model.dto.BookingPreviewDTO;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "BookingPreviewAPI", urlPatterns = {"/api/payment"})
public class CustomerPaymentAPI extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BookingPreviewAPI</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingPreviewAPI at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();

        String siteId = request.getParameter("siteId");
        Customer customer = (Customer) session.getAttribute("customer");
        BookingPreviewDTO bookingPreview = (BookingPreviewDTO) session.getAttribute("bookingPreview");

        if (siteId == null || customer == null || bookingPreview == null) {
            out.print("{\"success\": false, \"message\": \"Phiên làm việc hết hạn hoặc thiếu dữ liệu!\"}");
            return;
        }
        
        try {
            CardDAO cardDAO = new CardDAO();
            BookingDAO bookingDAO = new BookingDAO();
            PaymentTransactionDAO paymentDAO = new PaymentTransactionDAO();

            // 1. Lấy thẻ trống
            ParkingCard card = cardDAO.getAvailableCardAtSite(Integer.parseInt(siteId));
            if (card == null) {
                out.print("{\"success\": false, \"message\": \"Đã hết thẻ trống tại bãi này!\"}");
                return;
            }

            // 2. Tạo Booking
            int bookingId = bookingDAO.insertBooking(
                    customer.getCustomer_id(),
                    card.getCardId(),
                    bookingPreview.getVehicleTypeId(),
                    "accepted",
                    bookingPreview.getTimeIn(),
                    bookingPreview.getTimeOut(),
                    bookingPreview.getTotalPrice()
            );

            if (bookingId == -1) {
                out.print("{\"success\": false, \"message\": \"Lỗi tạo đơn đặt chỗ!\"}");
                return;
            }

            //3. Lưu giao dich thanh toán trước khi update Card State để đảm bảo giao dịch thành công trước
            PaymentTransaction txn = new PaymentTransaction();
            txn.setTransactionType(PaymentTransaction.TransactionType.BOOKING);
            txn.setTargetId(bookingId);
            txn.setTotalAmount(bookingPreview.getTotalPrice());
            txn.setPaymentStatus("completed");

            boolean isTxnSaved = paymentDAO.add(txn);

            if (isTxnSaved) {
                // 4. CUỐI CÙNG: Mới cập nhật trạng thái thẻ sang 'booked'
                cardDAO.updateCardStatus(Integer.parseInt(siteId), card.getCardId(), "booked");

                //Xóa thông tin đã lưu trên session
                session.removeAttribute("bookingPreview");

                out.print("{\"success\": true, \"message\": \"Đặt hàng thành công! Mã đơn: #" + bookingId + "\"}");
            } else {
                // Trường hợp hy hữu: Booking đã tạo nhưng Payment lỗi
                // hàm deleteBooking hoặc đánh dấu Booking là 'Cancelled' 
                bookingDAO.cancelBooking(bookingId);
                out.print("{\"success\": false, \"message\": \"Giao dịch thất bại!\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Có lỗi xảy ra: " + e.getMessage() + "\"}");
        }
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
