package controller.api;

import dal.CardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Employee;
import model.ParkingCard;

@WebServlet(name = "RandomCardApiController", urlPatterns = {"/api/parking/random-card"})
public class RandomCardAPI extends HttpServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Lấy thông tin nhân viên từ Session để biết đang trực ở Bãi nào
//        Employee emp = (Employee) request.getSession().getAttribute("employee"); // Thay tên attribute của bạn
//        if (emp == null) {
//            response.getWriter().write("{\"success\": false, \"message\": \"Vui lòng đăng nhập lại\"}");
//            return;
//        }

        CardDAO cardDAO = new CardDAO();
        ParkingCard card = cardDAO.getAvailableCardAtSite(1);
        
        if (card != null) {
            // Trả về JSON chứa mã thẻ
            String cardId = card.getCardId();
            response.getWriter().write("{\"success\": true, \"cardId\": \"" + cardId + "\"}");
        } else {
            response.getWriter().write("{\"success\": false, \"message\": \"Đã hết thẻ trống tại bãi này!\"}");
        }
    }
}