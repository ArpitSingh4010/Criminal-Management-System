package com.AdminCaseType.dao;

import java.sql.*;
import java.util.*;
import com.CaseType.model.CaseType;

public class AdminCaseDao {

    private Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/management?useSSL=false&serverTimezone=UTC",
            "root",
            "Ayush@25");
        return con;
    }

    // Get all case types
    public List<CaseType> getAllCaseTypes() {
        List<CaseType> caseTypes = new ArrayList<>();
        String sql = "SELECT * FROM case_types ORDER BY case_type";

        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            
            while (rs.next()) {
                caseTypes.add(mapResultSetToCaseType(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return caseTypes;
    }

    // Search case types
    public List<CaseType> searchCaseTypes(String keyword) {
        List<CaseType> caseTypes = new ArrayList<>();
        String sql = "SELECT * FROM case_types WHERE case_type LIKE ? OR description LIKE ? OR ipc_section LIKE ? ORDER BY case_type";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            st.setString(1, searchPattern);
            st.setString(2, searchPattern);
            st.setString(3, searchPattern);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                caseTypes.add(mapResultSetToCaseType(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return caseTypes;
    }

    // Get case type by ID
    public CaseType getCaseTypeById(int typeId) {
        String sql = "SELECT * FROM case_types WHERE type_id = ?";
        
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setInt(1, typeId);
            ResultSet rs = st.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToCaseType(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Add new case type
    public boolean addCaseType(CaseType caseType) {
        String sql = "INSERT INTO case_types (case_type, description, ipc_section) VALUES (?, ?, ?)";
        
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, caseType.getCaseType());
            st.setString(2, caseType.getDescription());
            st.setString(3, caseType.getIpcSection());
            
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update existing case type
    public boolean updateCaseType(CaseType caseType) {
        String sql = "UPDATE case_types SET case_type=?, description=?, ipc_section=? WHERE type_id=?";
        
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, caseType.getCaseType());
            st.setString(2, caseType.getDescription());
            st.setString(3, caseType.getIpcSection());
            st.setInt(4, caseType.getTypeId());
            
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete case type
    public boolean deleteCaseType(int typeId) {
        String sql = "DELETE FROM case_types WHERE type_id=?";
        
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setInt(1, typeId);
            
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper method to map ResultSet to CaseType object
    private CaseType mapResultSetToCaseType(ResultSet rs) throws SQLException {
        CaseType caseType = new CaseType();
        caseType.setTypeId(rs.getInt("type_id"));
        caseType.setCaseType(rs.getString("case_type"));
        caseType.setDescription(rs.getString("description"));
        caseType.setIpcSection(rs.getString("ipc_section"));
        return caseType;
    }
}
