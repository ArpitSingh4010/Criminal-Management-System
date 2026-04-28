package com.Complaint.dao;

import com.Complaint.model.Complaint;
import com.login.dao.DbConnectionLog;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO for all complaint-related database operations
 */
public class ComplaintDao {

    // Use the same DB as the rest of the project
    private static final String DB_URL      = "jdbc:mysql://localhost:3306/management";
    private static final String DB_USER     = "root";
    private static final String DB_PASSWORD = "Ayush@25";

    private Connection getConnection() throws ClassNotFoundException, SQLException {
        DbConnectionLog.logConnectionLifecycleOnce();
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        return conn;
    }

    /**
     * Insert a new complaint into the database.
     * @return true if insert succeeded
     */
    public boolean fileComplaint(Complaint c) {
        String sql = "INSERT INTO complaints (username, crime_type, description, " +
                     "incident_date, incident_location, status) VALUES (?, ?, ?, ?, ?, 'Pending')";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, c.getUsername());
            ps.setString(2, c.getCrimeType());
            ps.setString(3, c.getDescription());

            if (c.getIncidentDate() != null && !c.getIncidentDate().isEmpty()) {
                ps.setDate(4, java.sql.Date.valueOf(c.getIncidentDate()));
            } else {
                ps.setNull(4, Types.DATE);
            }

            ps.setString(5, c.getIncidentLocation());

            return ps.executeUpdate() > 0;

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get all complaints filed by a given username.
     */
    public List<Complaint> getComplaintsByUser(String username) {
        List<Complaint> list = new ArrayList<>();
        String sql = "SELECT * FROM complaints WHERE username = ? ORDER BY filed_at DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Complaint c = mapRow(rs);
                list.add(c);
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Get a single complaint by ID (only if filed by the given user).
     */
    public Complaint getComplaintById(int id, String username) {
        String sql = "SELECT * FROM complaints WHERE complaint_id = ? AND username = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.setString(2, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) return mapRow(rs);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Helper: map a ResultSet row to a Complaint object
    private Complaint mapRow(ResultSet rs) throws SQLException {
        Complaint c = new Complaint();
        c.setComplaintId(rs.getInt("complaint_id"));
        c.setUsername(rs.getString("username"));
        c.setCrimeType(rs.getString("crime_type"));
        c.setDescription(rs.getString("description"));
        Date incDate = rs.getDate("incident_date");
        c.setIncidentDate(incDate != null ? incDate.toString() : null);
        c.setIncidentLocation(rs.getString("incident_location"));
        c.setStatus(rs.getString("status"));
        Timestamp filed = rs.getTimestamp("filed_at");
        c.setFiledAt(filed != null ? filed.toString() : "");
        return c;
    }
}
