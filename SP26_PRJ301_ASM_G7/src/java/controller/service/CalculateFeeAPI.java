package controller.service;

import dal.SessionDAO; // Thay bằng DAO quản lý phiên đỗ xe của bạn
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.NumberFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import model.Employee;
import model.ParkingSession; // Model chứa thông tin lượt đỗ xe

@WebServlet(name = "CalculateFeeApiController", urlPatterns = {"/api/parking/calculate-fee"})
public class CalculateFeeAPI extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Cấu hình trả về JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        // 2. Kiểm tra đăng nhập (Bảo mật)
        Employee emp = (Employee) request.getSession().getAttribute("staff");
        if (emp == null) {
            // LƯU Ý: Với API (fetch/AJAX), ta phải trả về JSON lỗi chứ không dùng sendRedirect
            out.write("{\"success\": false, \"message\": \"Phiên đăng nhập đã hết hạn!\"}");
            return;
        }
        
        // 3. Lấy tham số từ Frontend gửi lên
        String cardId = request.getParameter("cardId");
        String plateNumber = request.getParameter("plateNumber");
        
        try {
            // 4. Gọi DAO lấy thông tin lượt đỗ xe đang TRONG BÃI (Status = 'parked' / 'in')
            SessionDAO sessionDAO = new SessionDAO();
            
            // Giả sử bạn có hàm tìm phiên đỗ xe bằng Card ID hoặc Biển số
            ParkingSession pSession = sessionDAO.getActiveSession(cardId);
            
            if (pSession != null) {
                // --- BẮT ĐẦU XỬ LÝ LOGIC TÍNH TIỀN ---
                
                // Lấy giờ vào từ DB (Giả sử là kiểu LocalDateTime)
                LocalDateTime timeIn = pSession.getEntryTime(); 
                LocalDateTime timeOut = LocalDateTime.now(); // Giờ ra là hiện tại
                
                // Tính thời gian đỗ (Duration)
                Duration duration = Duration.between(timeIn, timeOut);
                long hours = duration.toHours();
                long minutes = duration.toMinutesPart();
                String durationStr = hours + " giờ " + minutes + " phút";
                if (hours == 0) {
                    durationStr = minutes + " phút"; // Tránh hiện "0 giờ 15 phút"
                }

                // Tính tiền (Ví dụ: Mặc định 15.000đ/lượt. Ở đây bạn gọi PricingService hoặc logic DB)
                // long fee = feeCalculationService.calculate(pSession.getVehicleTypeId(), duration);
                long fee = 15000; 
                
                // Định dạng tiền tệ (VNĐ) và Thời gian (dd/MM/yyyy HH:mm)
                NumberFormat currencyFormat = NumberFormat.getInstance(new Locale("vi", "VN"));
                String feeFormatted = currencyFormat.format(fee) + " đ";
                
                DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
                String timeInStr = timeIn.format(timeFormatter);
                
                // --- TRẢ VỀ JSON CHO FRONTEND ---
                // Dùng String.format để build JSON an toàn và dễ đọc
                String jsonResponse = String.format(
                    "{\"success\": true, \"sessionId\": %d, \"cardId\": \"%s\", \"plateNumber\": \"%s\", \"timeIn\": \"%s\", \"duration\": \"%s\", \"fee\": %d, \"feeFormatted\": \"%s\"}",
                    pSession.getSessionId(),
                    pSession.getCardId(), // Trả về cardId thực tế trong DB
                    pSession.getLicensePlate(), // Trả về biển số thực tế trong DB
                    timeInStr,
                    durationStr,
                    fee,
                    feeFormatted
                );
                
                out.write(jsonResponse);
                
            } else {
                // Không tìm thấy xe đang đỗ tương ứng với mã thẻ/biển số này
                out.write("{\"success\": false, \"message\": \"Thẻ chưa Check-in hoặc sai biển số!\"}");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"success\": false, \"message\": \"Lỗi máy chủ: " + e.getMessage() + "\"}");
        }
    }
}