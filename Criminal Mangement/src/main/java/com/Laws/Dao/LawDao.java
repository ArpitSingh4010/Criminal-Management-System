package com.Laws.Dao;

import java.sql.*;
import java.util.*;
import com.Laws.model.Law;

public class LawDao {
    
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/management?useSSL=false&serverTimezone=UTC", 
            "root", 
            "Ayush@25");
    }

    public List<Law> getAllLaws() {
        List<Law> laws = new ArrayList<>();
        String sql = "SELECT * FROM laws ORDER BY section";

        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            
            while (rs.next()) {
                laws.add(mapResultSetToLaw(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return laws;
    }

    public List<Law> searchLaws(String keyword) {
        List<Law> laws = new ArrayList<>();
        String sql = "SELECT * FROM laws WHERE section LIKE ? OR title LIKE ? OR description LIKE ? OR act_name LIKE ? OR offense_type LIKE ? ORDER BY section";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            st.setString(1, searchPattern);
            st.setString(2, searchPattern);
            st.setString(3, searchPattern);
            st.setString(4, searchPattern);
            st.setString(5, searchPattern);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                laws.add(mapResultSetToLaw(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return laws;
    }

    public List<Law> filterLaws(String actName, String offenseType, String bailable, String cognizable) {
        List<Law> laws = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM laws WHERE 1=1");
        
        if (actName != null && !actName.isEmpty()) {
            sql.append(" AND act_name LIKE ?");
        }
        if (offenseType != null && !offenseType.isEmpty()) {
            sql.append(" AND offense_type LIKE ?");
        }
        if (bailable != null && !bailable.isEmpty()) {
            sql.append(" AND bailable = ?");
        }
        if (cognizable != null && !cognizable.isEmpty()) {
            sql.append(" AND cognizable = ?");
        }
        sql.append(" ORDER BY section");

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (actName != null && !actName.isEmpty()) {
                st.setString(paramIndex++, "%" + actName + "%");
            }
            if (offenseType != null && !offenseType.isEmpty()) {
                st.setString(paramIndex++, "%" + offenseType + "%");
            }
            if (bailable != null && !bailable.isEmpty()) {
                st.setString(paramIndex++, bailable);
            }
            if (cognizable != null && !cognizable.isEmpty()) {
                st.setString(paramIndex++, cognizable);
            }

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                laws.add(mapResultSetToLaw(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return laws;
    }

    public Law getLawById(int lawId) {
        String sql = "SELECT * FROM laws WHERE law_id = ?";
        
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setInt(1, lawId);
            ResultSet rs = st.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToLaw(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Law mapResultSetToLaw(ResultSet rs) throws SQLException {
        Law law = new Law();
        law.setLawId(rs.getInt("law_id"));
        law.setSection(rs.getString("section"));
        law.setTitle(rs.getString("title"));
        law.setDescription(rs.getString("description"));
        law.setActName(rs.getString("act_name"));
        law.setOffenseType(rs.getString("offense_type"));
        law.setPunishment(rs.getString("punishment"));
        law.setBailable(rs.getString("bailable"));
        law.setCognizable(rs.getString("cognizable"));
        law.setCompoundable(rs.getString("compoundable"));
        return law;
    }
}
