package controller.service;

import dal.PaymentTransactionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Employee;
import model.PaymentTransaction;
import utils.ValidationUtils;

@WebServlet(name = "PaymentTransactionApiController", urlPatterns = {"/api/payment/save"})
public class PaymentTransactionAPI extends HttpServlet {

    // =========================================================================
    // HÀM CHÍNH (MAIN FLOW)
    // =========================================================================
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Employee emp = (Employee) request.getSession().getAttribute("staff");

        if (emp == null) {
            response.sendRedirect(request.getSession().getAttribute("ctx") + "/login");
            return;
        }   
        
        String targetIdStr = request.getParameter("target_id");
        String targetTypeStr = request.getParameter("target_type");
        String totalAmountStr = request.getParameter("total_amount");
        String paymentStatusStr = request.getParameter("payment_status");
        
        try {
            
            int targetId = ValidationUtils.requireValidInt(targetIdStr, "Lỗi nhập liệu target");
            PaymentTransaction.TransactionType transactionType = ValidationUtils.requireValidEnum(PaymentTransaction.TransactionType.class, targetTypeStr, "Lỗi parse sang transaction type");
            long totalAmount = ValidationUtils.requireLongGreaterThan(totalAmountStr, 0, 1000000000, "Lỗi nhập liệu Total amount");
            String paymentStatus = ValidationUtils.requireNonEmpty(paymentStatusStr, "Lỗi Payment status");
            
            PaymentTransaction txn = extractTransactionFromRequest(targetId, transactionType, totalAmount, paymentStatus);
            // 3. Gọi DAO lưu xuống Database
            PaymentTransactionDAO transactionDAO = new PaymentTransactionDAO();
            boolean isSaved = transactionDAO.add(txn);

            // 4. Trả về kết quả
            if (isSaved) {
                sendJsonResponse(response, true, "Lưu giao dịch thành công!");
            } else {
                sendJsonResponse(response, false, "Lỗi CSDL: Không thể lưu giao dịch!");
            }

        } catch (IllegalArgumentException e) {
            // Lỗi do client gửi sai dữ liệu
            sendJsonResponse(response, false, e.getMessage());
        } catch (Exception e) {
            // Lỗi hệ thống bất ngờ
            e.printStackTrace();
            sendJsonResponse(response, false, "Lỗi hệ thống: " + e.getMessage());
        }
    }

    // =========================================================================
    // CÁC HÀM PHỤ TRỢ (HELPER METHODS)
    // =========================================================================
    // Helper 3: Trả về JSON gọn gàng
    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        String json = String.format("{\"success\": %b, \"message\": \"%s\"}", success, message.replace("\"", "\\\""));
        response.getWriter().write(json);
    }

    // Helper 4: Đóng gói và Validate toàn bộ dữ liệu đầu vào
    private PaymentTransaction extractTransactionFromRequest (int targetId, PaymentTransaction.TransactionType targetType, long totalAmount, String paymentStatus) {

        PaymentTransaction txn = new PaymentTransaction();

        txn.setTargetId(targetId);
        txn.setTransactionType(targetType);
        txn.setTotalAmount(totalAmount);
        txn.setPaymentStatus(paymentStatus);
        return txn;
    }

}
