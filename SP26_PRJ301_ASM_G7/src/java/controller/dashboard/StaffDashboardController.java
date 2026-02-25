package controller.dashboard;

import dal.AreaDAO;
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
import model.ParkingArea;
import model.ParkingSite;
import model.dto.AreaDetailDTO;
import model.dto.SiteOverviewDTO;

import utils.UrlConstants;

@WebServlet(name = "StaffDashboardController", urlPatterns = {UrlConstants.URL_STAFF + "/dashboard"})
public class StaffDashboardController extends HttpServlet {

    private SiteDAO siteDAO = new SiteDAO();
    private SessionDAO sessionDAO = new SessionDAO();
    private EmployeeDAO empDAO = new EmployeeDAO();
    private AreaDAO areaDAO = new AreaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getSession().setAttribute("ctx", request.getContextPath() + UrlConstants.URL_STAFF);
        request.getSession().setAttribute("role", "STAFF");
        Employee emp = empDAO.getById(2);

        try {
            // Tạm thời gán cứng ID bãi xe theo employee để test giao diện
            int currentSiteId = emp.getSiteId();
            SiteOverviewDTO overviewData = buildSiteOverview(currentSiteId);
            request.setAttribute("overview", overviewData);

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
     * Hàm lấy nhật ký từ Database và biến đổi thành DTO hiển thị (Chuẩn Clean
     * Architecture)
     */
    private List<RecentActivityDTO> getRecentActivities(int siteId, int limit) {
        List<ParkingSession> rawLogs = sessionDAO.getRecentLogs(siteId, limit);
        List<RecentActivityDTO> dtoList = new ArrayList<>();

        // CẬP NHẬT: Thêm định dạng Ngày/Tháng/Năm (dd/MM/yyyy)
        // Dùng HH:mm (24h) thường chuyên nghiệp hơn cho bãi xe, nếu thích AM/PM thì dùng hh:mm a
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

        for (ParkingSession session : rawLogs) {
            String formattedTime = "--/--/---- --:--";

            // Lấy thời gian tùy thuộc vào việc xe đang đỗ hay đã ra
            if ("parked".equalsIgnoreCase(session.getSessionState()) && session.getEntryTime() != null) {
                formattedTime = session.getEntryTime().format(timeFormatter);
            } else if ("completed".equalsIgnoreCase(session.getSessionState()) && session.getExitTime() != null) {
                formattedTime = session.getExitTime().format(timeFormatter);
            }

            // DTO giờ đây cực kỳ mỏng nhẹ, Controller không còn chứa code Giao diện (CSS) nữa
            dtoList.add(new RecentActivityDTO(
                    session.getLicensePlate(),
                    formattedTime,
                    session.getSessionState()
            ));
        }
        return dtoList;
    }

    private SiteOverviewDTO buildSiteOverview(int siteId) {
        // Lấy Entity Site
        ParkingSite site = siteDAO.getById(siteId);

        // 1. Lấy danh sách Entity Khu vực từ DAO (Đã có sẵn vehicleTypeName)
        List<ParkingArea> rawAreas = areaDAO.getAreasBySite(siteId);
        List<AreaDetailDTO> areaList = new ArrayList<>();

        // 2. Vòng lặp lắp ráp dữ liệu
        for (ParkingArea area : rawAreas) {

            // TỐI ƯU: Lấy trực tiếp tên loại xe từ Entity, không cần query thêm
            String vehicleTypeName = area.getVehicleTypeName();
            if (vehicleTypeName == null || vehicleTypeName.isEmpty()) {
                vehicleTypeName = "Chưa phân loại";
            }

            // Lấy số lượng xe đang đỗ tại khu này
            int occupiedSlots = sessionDAO.countActiveSessionsByArea(area.getAreaId());

            // Đóng gói vào DTO
            AreaDetailDTO dto = new AreaDetailDTO(
                    area.getAreaId(),
                    area.getAreaName(),
                    vehicleTypeName,
                    area.getTotalSlots(),
                    occupiedSlots
            );
            areaList.add(dto);
        }

        // 3. Trả về DTO tổng hợp
        return new SiteOverviewDTO(
                site.getSiteName(),
                site.getAddress(),
                site.getSiteStatus(),
                areaList
        );
    }

}
