package com.Officer.Dao;

import java.sql.*;
import java.util.*;
import com.Officer.model.Officers;

public class OfficerDao {
    
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/management?useSSL=false&serverTimezone=UTC", 
            "root", 
            "Ayush@25");
    }

    public List<Officers> getAllOfficers() {
        List<Officers> officers = new ArrayList<>();
        String sql = "SELECT * FROM officers ORDER BY name";

        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            
            while (rs.next()) {
                officers.add(mapResultSetToOfficer(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return officers;
    }

    public List<Officers> searchOfficers(String keyword) {
        List<Officers> officers = new ArrayList<>();
        String sql = "SELECT * FROM officers WHERE name LIKE ? OR designation LIKE ? OR department LIKE ? OR state LIKE ? ORDER BY name";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            st.setString(1, searchPattern);
            st.setString(2, searchPattern);
            st.setString(3, searchPattern);
            st.setString(4, searchPattern);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                officers.add(mapResultSetToOfficer(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return officers;
    }

    public List<Officers> filterOfficers(String designation, String state, Integer minAge, Integer maxAge) {
        List<Officers> officers = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM officers WHERE 1=1");
        
        if (designation != null && !designation.isEmpty()) {
            sql.append(" AND designation LIKE ?");
        }
        if (state != null && !state.isEmpty()) {
            sql.append(" AND state LIKE ?");
        }
        if (minAge != null) {
            sql.append(" AND age >= ?");
        }
        if (maxAge != null) {
            sql.append(" AND age <= ?");
        }
        sql.append(" ORDER BY name");

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (designation != null && !designation.isEmpty()) {
                st.setString(paramIndex++, "%" + designation + "%");
            }
            if (state != null && !state.isEmpty()) {
                st.setString(paramIndex++, "%" + state + "%");
            }
            if (minAge != null) {
                st.setInt(paramIndex++, minAge);
            }
            if (maxAge != null) {
                st.setInt(paramIndex++, maxAge);
            }

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                officers.add(mapResultSetToOfficer(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return officers;
    }

    public Officers getOfficerById(int officerId) {
        String sql = "SELECT * FROM officers WHERE officer_id = ?";
        
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setInt(1, officerId);
            ResultSet rs = st.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToOfficer(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Officers mapResultSetToOfficer(ResultSet rs) throws SQLException {
        Officers officer = new Officers();
        officer.setOfficerId(rs.getInt("officer_id"));
        officer.setName(rs.getString("name"));
        officer.setAge(rs.getInt("age"));
        officer.setDesignation(rs.getString("designation"));
        officer.setBadgeNumber(rs.getString("badge_number"));
        officer.setDepartment(rs.getString("department"));
        officer.setState(rs.getString("state"));
        officer.setYearsOfService(rs.getInt("years_of_service"));
        return officer;
    }
}
