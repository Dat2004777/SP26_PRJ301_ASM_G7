package controller.dashboard;

import dal.EmployeeDAO;
import dal.SessionDAO;
import model.dto.RecentActivityDTO;
import model.dto.DashboardStatsDTO;
import model.ParkingSession;
import dal.SiteDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.format.DateTimeFormatter; // IMPORT BỘ FORMAT MỚI
import java.util.ArrayList;
import java.util.List;
import model.Employee;

import utils.UrlConstants;

@WebServlet(name = "StaffDashboardController", urlPatterns = {UrlConstants.URL_STAFF + "/dashboard"})
public class StaffDashboardController extends HttpServlet {

    private SiteDAO siteDAO = new SiteDAO();
    private SessionDAO sessionDAO = new SessionDAO();
    private EmployeeDAO empDAO = new EmployeeDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Employee emp = empDAO.getById(2);
        
        try {
            // Tạm thời gán cứng ID bãi xe theo employee để test giao diện
            int currentSiteId = emp.getSiteId(); 
            
            // 1. GỌI CÁC HÀM NỘI BỘ (PRIVATE) ĐỂ LẤY DỮ LIỆU DTO
            request.setAttribute("stats", getDashboardStats(currentSiteId));
            request.setAttribute("recentLogs", getRecentActivities(currentSiteId, 10));
            
            // 2. FORWARD TỚI JSP
            request.getRequestDispatcher("/WEB-INF/views/dashboard/staff.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tải Dashboard");
        }
    }

    // =========================================================
    // CÁC HÀM NỘI BỘ (PRIVATE METHODS) XỬ LÝ LOGIC
    // =========================================================

    /**
     * Hàm tính toán và đóng gói Thống kê bãi xe
     */
    private DashboardStatsDTO getDashboardStats(int siteId) {
        String siteName = siteDAO.getById(siteId).getSiteName();
        String empName = empDAO.getById(2).getFullName();
        int total = siteDAO.getById(siteId).getTotalSlots();
        
        // Gọi thẳng SessionDAO để đếm số lượng ACTIVE hiện tại
        int occupied = sessionDAO.countActiveSessions(siteId); 
        int available = Math.max(0, total - occupied);
        
        return new DashboardStatsDTO(siteName, empName, total, occupied, available);
    }

    /**
     * Hàm lấy nhật ký từ Database và biến đổi thành DTO hiển thị
     */
    private List<RecentActivityDTO> getRecentActivities(int siteId, int limit) {
        List<ParkingSession> rawLogs = sessionDAO.getRecentLogs(siteId, limit);
        List<RecentActivityDTO> dtoList = new ArrayList<>();
        
        // SỬ DỤNG DATETIMEFORMATTER CHO LOCALDATETIME
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a");

        for (ParkingSession session : rawLogs) {
            // Khởi tạo rỗng cho formattedTime để tránh lỗi compile nếu biến chưa được gán
            String actionName, formattedTime = "--:--", iconClass, badgeClass, badgeText, textClass;
            
            if ("completed".equalsIgnoreCase(session.getSessionState())) {
                actionName = "Xe ra bãi";
                if (session.getExitTime() != null) {
                    formattedTime = session.getExitTime().format(timeFormatter);
                }
                iconClass = "bi-arrow-up-circle";
                badgeClass = "bg-success-subtle text-success";
                badgeText = "Hoàn thành";
                textClass = "text-success";
            } else {
                actionName = "Xe vào bãi";
                if (session.getEntryTime() != null) {
                    formattedTime = session.getEntryTime().format(timeFormatter);
                }
                iconClass = "bi-arrow-down-circle";
                badgeClass = "bg-primary-subtle text-primary";
                badgeText = "Đang đỗ";
                textClass = "text-primary";
            }

            dtoList.add(new RecentActivityDTO(
                session.getLicensePlate(), actionName, formattedTime, "Hôm nay", 
                iconClass, badgeClass, badgeText, textClass
            ));
        }
        return dtoList;
    }
}