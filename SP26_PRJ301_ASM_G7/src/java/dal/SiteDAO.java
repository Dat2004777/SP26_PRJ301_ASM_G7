package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.ParkingSite;

/**
 *
 * @author ADMIN
 */
public class SiteDAO extends DBContext {

    public void add(ParkingSite site) {
        String sql = "INSERT INTO ParkingSites (site_name, address, region,manager_id, status) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, site.getSiteName());
            ps.setString(2, site.getAddress());

            ps.setString(3, site.getRegion().name());

            ps.setInt(4, site.getManagerId());
            ps.setString(5, site.getSiteStatus().name());

            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error add: " + e.getMessage());
        }
    }

    public void update(ParkingSite newSiteData) {
        String sql = "UPDATE ParkingSites SET site_name = ?, address = ?, region = ?, status = ?, manager_id = ? WHERE site_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, newSiteData.getSiteName());
            ps.setString(2, newSiteData.getAddress());

            ps.setString(3, newSiteData.getRegion().name());
            ps.setString(4, newSiteData.getSiteStatus().name());
            ps.setInt(5, newSiteData.getManagerId());

            ps.setInt(6, newSiteData.getSiteId());

            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error update: " + e.getMessage());
        }
    }

    // 5. Xóa (Delete)
    public void delete(int id) {
        String sql = "DELETE FROM ParkingSites WHERE site_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error delete: " + e.getMessage());
        }
    }
    
    public List<ParkingSite> getAll() {
        List<ParkingSite> list = new ArrayList<>();
        String sql = "SELECT * FROM ParkingSites";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                ParkingSite site = mapRowToSite(rs);
                list.add(site);
            }
        } catch (SQLException e) {
            System.out.println("Error getAll: " + e.getMessage());
        }
        return list;
    }

    public List<ParkingSite> searchByName(String keyword) {
        List<ParkingSite> list = new ArrayList<>();
        String sql = "SELECT * FROM ParkingSites WHERE site_name LIKE ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRowToSite(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error searchByName: " + e.getMessage());
        }
        return list;
    }

    private ParkingSite mapRowToSite(ResultSet rs) throws SQLException {
        int id = rs.getInt("site_id");
        String name = rs.getString("site_name");
        String address = rs.getString("address");
        String regionStr = rs.getString("region");
        String statusStr = rs.getString("status");
        int managerId = rs.getInt("manager_id");

        ParkingSite.Region region = ParkingSite.Region.NORTH; // Default
        try {
            if (regionStr != null) {
                region = ParkingSite.Region.valueOf(regionStr.toUpperCase());
            }
        } catch (IllegalArgumentException e) {
            System.out.println("Lỗi convert Region: " + regionStr);
        }

        ParkingSite.Status status = ParkingSite.Status.CLOSED;
        try {
            if (statusStr != null) {
                status = ParkingSite.Status.valueOf(statusStr.toUpperCase());
            }
        } catch (IllegalArgumentException e) {
            System.out.println("Lỗi convert Status: " + statusStr);
        }

        return new ParkingSite(id, name, address, region, status, managerId);
    }
}
