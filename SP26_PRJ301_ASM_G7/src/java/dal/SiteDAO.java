package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.ParkingSite;
import model.Vehicle;

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
        String sql
                = """
                UPDATE ParkingSites
                SET site_name = ?, address = ?, region = ?, status = ?, manager_id = ? 
                WHERE site_id = ?
                """;
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
        String sql
                = """
                SELECT s.site_id, s.site_name,s.address, s.region, s.manager_id, s.status,SUM(a.totalSlots) AS total_slots
                    FROM ParkingSites s
                    JOIN ParkingAreas a ON s.site_id = a.site_id 
                    GROUP BY 
                        s.site_id,
                        s.site_name,
                        s.address,
                        s.region,
                        s.manager_id,
                        s.status;
                """;

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

    public ParkingSite getById(int id) {
        String sql
                = """
                SELECT s.site_id, s.site_name,s.address, s.region, s.manager_id, s.operating_state,SUM(a.totalSlots) AS total_slots
                    FROM ParkingSites s
                    JOIN ParkingAreas a ON s.site_id = a.site_id 
                    WHERE s.site_id = ?
                    GROUP BY 
                        s.site_id,
                        s.site_name,
                        s.address,
                        s.region,
                        s.manager_id,
                        s.operating_state;
                """;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapRowToSite(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getById: " + e.getMessage());
        }
        return null;
    }

    public List<ParkingSite> searchByName(String keyword) {
        List<ParkingSite> list = new ArrayList<>();

        String sql
                = """
                SELECT s.site_id, s.site_name,s.address, s.region, s.manager_id, s.status,SUM(a.totalSlots) AS total_slots
                    FROM ParkingSites s
                    JOIN ParkingAreas a ON s.site_id = a.site_id 
                    WHERE s.site_name LIKE ?
                    GROUP BY 
                        s.site_id,
                        s.site_name,
                        s.address,
                        s.region,
                        s.manager_id,
                        s.status;
                """;

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

    public List<ParkingSite> getSpecificSites(String siteRegion, String querySite) {
        String sql
                = """
                SELECT s.site_id, s.site_name,s.address, s.region, s.manager_id, s.status,SUM(a.totalSlots) AS total_slots
                    FROM ParkingSites s
                    JOIN ParkingAreas a ON s.site_id = a.site_id 
                    WHERE (? = '' OR s.region = ?) AND (
                        ? = '' 
                        OR s.site_name COLLATE Latin1_General_CI_AI LIKE ?
                        OR s.address COLLATE Latin1_General_CI_AI LIKE ?
                    )
                    GROUP BY 
                        s.site_id,
                        s.site_name,
                        s.address,
                        s.region,
                        s.manager_id,
                        s.status;
                """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, siteRegion);
            ps.setString(2, siteRegion);

            ps.setString(3, querySite);
            ps.setString(4, "%" + querySite + "%");
            ps.setString(5, "%" + querySite + "%");

            ResultSet rs = ps.executeQuery();
            List<ParkingSite> listSites = new ArrayList<>();

            while (rs.next()) {
                listSites.add(mapRowToSite(rs));
            }
            return listSites;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Lỗi lấy dữ liệu sites cụ thể");
            return null;
        }
    }

    public List<ParkingSite> getAllSitesWithAvailableSlots() {
        List<ParkingSite> list = new ArrayList<>();

        String sql = """
                    SELECT 
                        ps.site_id, 
                        ps.site_name, 
                        ps.address, 
                        ps.region,
                        ps.operating_state,
                        (SELECT ISNULL(SUM(pa.totalSlots), 0) 
                         FROM ParkingAreas pa 
                         WHERE pa.site_id = ps.site_id AND pa.status = 'active') 
                        - 
                        (SELECT COUNT(sess.session_id) 
                        FROM ParkingSessions sess
                        JOIN ParkingCards pc ON sess.card_id = pc.card_id
                        WHERE pc.site_id = ps.site_id 
                        AND sess.status = 'active' 
                        AND sess.session_state = 'parked'
                        AND sess.entry_time <= GETDATE()
                        AND (sess.exit_time IS NULL OR sess.exit_time > GETDATE())) 
                        AS availableSlots
                        FROM ParkingSites ps
                        WHERE ps.status = 'active'
                    """;

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ParkingSite site = new ParkingSite();
                site.setSiteId(rs.getInt("site_id"));
                site.setSiteName(rs.getString("site_name"));
                site.setAddress(rs.getString("address"));
                site.setRegion(ParkingSite.Region.valueOf(rs.getString("region").toUpperCase()));
                site.setSiteStatus(ParkingSite.State.valueOf(rs.getString("operating_state").toUpperCase()));
                site.setTotalSlots(rs.getInt("availableSlots"));

                list.add(site);
            }

        } catch (Exception e) {
            System.out.println("Lỗi lấy Sites với available slots");
            e.printStackTrace();
        }

        return list;
    }

    public List<ParkingSite> filterSites(String address, String region, String status, String vehicleTypeId) {
        String sql
                = """
                SELECT  ps.site_id,ps.site_name,ps.address,ps.region,ps.operating_state,
                    ISNULL((
                        SELECT SUM(pa.totalSlots)
                        FROM ParkingAreas pa 
                        WHERE pa.site_id = ps.site_id 
                        AND pa.status = 'active'
                        AND (? = '' OR pa.vehicle_type_id = ?)
                    ), 0)

                    -

                    ISNULL((
                        SELECT COUNT(sess.session_id)
                        FROM ParkingSessions sess
                        JOIN ParkingCards pc ON sess.card_id = pc.card_id
                        WHERE pc.site_id = ps.site_id 
                        AND sess.status = 'active'
                        AND sess.session_state = 'parked'
                        AND sess.entry_time <= GETDATE()
                        AND (sess.exit_time IS NULL OR sess.exit_time > GETDATE())
                        AND (? = '' OR sess.vehicle_type_id = ?)
                    ), 0)

                    AS availableSlots

                FROM ParkingSites ps
                WHERE 
                    ps.status = 'active'

                    AND (? = '' OR ps.region = ?)

                    AND (
                        ? = '' 
                        OR ps.site_name COLLATE Latin1_General_CI_AI LIKE ?
                        OR ps.address COLLATE Latin1_General_CI_AI LIKE ?
                    )
                    AND (? = '' OR ps.operating_state = ?)
                    AND (
                        ? = ''
                        OR EXISTS (
                            SELECT 1
                            FROM ParkingAreas pa
                            WHERE pa.site_id = ps.site_id
                            AND pa.status = 'active'
                            AND pa.vehicle_type_id = ?
                        )
                    )    
                """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, vehicleTypeId);
            ps.setString(2, vehicleTypeId);
            ps.setString(3, vehicleTypeId);
            ps.setString(4, vehicleTypeId);

            ps.setString(5, region);
            ps.setString(6, region);

            ps.setString(7, address);
            ps.setString(8, "%" + address + "%");
            ps.setString(9, "%" + address + "%");

            ps.setString(10, status);
            ps.setString(11, status);

            ps.setString(12, vehicleTypeId);
            ps.setString(13, vehicleTypeId);

            List<ParkingSite> list = new ArrayList<>();

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ParkingSite site = new ParkingSite();
                site.setSiteId(rs.getInt("site_id"));
                site.setSiteName(rs.getString("site_name"));
                site.setAddress(rs.getString("address"));
                site.setRegion(ParkingSite.Region.valueOf(rs.getString("region").toUpperCase()));
                site.setSiteStatus(ParkingSite.State.valueOf(rs.getString("operating_state").toUpperCase()));
                site.setTotalSlots(rs.getInt("availableSlots"));
                
                list.add(site);
            }
            
            return list;
        } catch (Exception e) {
            System.out.println("Lỗi lấy ra chi tiết site đã filter");
            return null;
        }
    }

    private ParkingSite mapRowToSite(ResultSet rs) throws SQLException {
        int id = rs.getInt("site_id");
        String name = rs.getString("site_name");
        String address = rs.getString("address");
        String regionStr = rs.getString("region");
        String statusStr = rs.getString("operating_state");
        int managerId = rs.getInt("manager_id");
        int totalSlots = rs.getInt("total_slots");
        ParkingSite.Region region = ParkingSite.Region.NORTH; // Default
        try {
            if (regionStr != null) {
                region = ParkingSite.Region.valueOf(regionStr.toUpperCase());
            }
        } catch (IllegalArgumentException e) {
            System.out.println("Lỗi convert Region: " + regionStr);
        }

        ParkingSite.State status = ParkingSite.State.CLOSED;
        try {
            if (statusStr != null) {
                status = ParkingSite.State.valueOf(statusStr.toUpperCase());
            }
        } catch (IllegalArgumentException e) {
            System.out.println("Lỗi convert Status: " + statusStr);
        }

        return new ParkingSite(id, name, address, region, status, managerId, totalSlots);
    }

}
