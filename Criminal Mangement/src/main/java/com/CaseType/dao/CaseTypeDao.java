package com.CaseType.dao;

import java.sql.*;
import java.util.*;
import com.CaseType.model.CaseType;

public class CaseTypeDao {
    
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/management?useSSL=false&serverTimezone=UTC", 
            "root", 
            "Ayush@25");
    }

    public List<CaseType> getAllCaseTypes() {
        List<CaseType> caseTypes = new ArrayList<>();
        String sql = "SELECT * FROM case_types ORDER BY case_type";

        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            
            while (rs.next()) {
                caseTypes.add(mapResultSetToCaseType(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return caseTypes;
    }

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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return caseTypes;
    }

    public CaseType getCaseTypeById(int typeId) {
        String sql = "SELECT * FROM case_types WHERE type_id = ?";
        
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setInt(1, typeId);
            ResultSet rs = st.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToCaseType(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private CaseType mapResultSetToCaseType(ResultSet rs) throws SQLException {
        CaseType caseType = new CaseType();
        caseType.setTypeId(rs.getInt("type_id"));
        caseType.setCaseType(rs.getString("case_type"));
        caseType.setDescription(rs.getString("description"));
        caseType.setIpcSection(rs.getString("ipc_section"));
        return caseType;
    }
}
