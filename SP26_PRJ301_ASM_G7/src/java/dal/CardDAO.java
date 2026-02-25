package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.ParkingCard;

public class CardDAO extends DBContext {

    // 1. Lấy tất cả thẻ (Get All)
    public List<ParkingCard> getAll() {
        List<ParkingCard> list = new ArrayList<>();
        String sql = "SELECT * FROM ParkingCards";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRowToCard(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Tìm thẻ theo ID
    public ParkingCard getById(String id) {
        String sql = "SELECT * FROM ParkingCards WHERE card_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapRowToCard(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 3. Thêm thẻ mới (Nhập kho thẻ)
    public void add(ParkingCard card) {
        String sql = "INSERT INTO ParkingCards (card_id, site_id, status) VALUES (?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, card.getCardId());
            ps.setString(2, card.getSiteId());
            ps.setString(3, card.getStatus().name()); // Lưu Enum dạng String "AVAILABLE"
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error Add Card: " + e.getMessage());
        }
    }

    // 4. Cập nhật thông tin thẻ
    public void update(ParkingCard card) {
        String sql = "UPDATE ParkingCards SET site_id = ?, status = ? WHERE card_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, card.getSiteId());
            ps.setString(2, card.getStatus().name());
            ps.setString(3, card.getCardId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 5. Xóa thẻ (Hủy thẻ hỏng)
    public void delete(String id) {
        String sql = "DELETE FROM ParkingCards WHERE card_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // --- CÁC METHOD NGHIỆP VỤ QUAN TRỌNG ---

    // 6. Lấy danh sách thẻ của một bãi xe cụ thể
    // Dùng để quản lý kho thẻ của từng bãi
    public List<ParkingCard> getBySite(String siteId) {
        List<ParkingCard> list = new ArrayList<>();
        String sql = "SELECT * FROM ParkingCards WHERE site_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, siteId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRowToCard(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // 7. [QUAN TRỌNG] Lấy 1 thẻ trống bất kỳ tại bãi xe để cấp cho khách vào
    // Logic: Khi khách nhấn nút lấy thẻ, hệ thống gọi hàm này để nhả ra 1 thẻ AVAILABLE
    public ParkingCard getAvailableCardAtSite(String siteId) {
        // SQL Server dùng TOP 1, MySQL dùng LIMIT 1
        String sql = "SELECT TOP 1 * FROM ParkingCards WHERE site_id = ? AND status = 'AVAILABLE'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, siteId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapRowToCard(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Hết thẻ
    }

    // 8. Đếm số lượng thẻ trống tại bãi (Để hiển thị Dashboard: "Còn 50 slot")
    public int countAvailableCards(String siteId) {
        String sql = "SELECT COUNT(*) FROM ParkingCards WHERE site_id = ? AND status = 'AVAILABLE'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, siteId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 9. Cập nhật nhanh trạng thái thẻ (Dùng khi Check-in/Check-out)
    // Ví dụ: updateStatus("CARD001", Status.IN_USE)
    public void updateStatus(String cardId, ParkingCard.Status newStatus) {
        String sql = "UPDATE ParkingCards SET status = ? WHERE card_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, newStatus.name());
            ps.setString(2, cardId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // --- Helper Mapping ---
    private ParkingCard mapRowToCard(ResultSet rs) throws SQLException {
        String statusStr = rs.getString("status");
        ParkingCard.Status status = ParkingCard.Status.AVAILABLE; // Default
        try {
            if (statusStr != null) {
                status = ParkingCard.Status.valueOf(statusStr.toUpperCase());
            }
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        }
        
        return new ParkingCard(
            rs.getString("card_id"),
            rs.getString("site_id"),
            status
        );
    }
}