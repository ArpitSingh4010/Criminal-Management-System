package com.Reports.dao;

import java.sql.*;
import java.util.*;
import com.Reports.model.Report;

public class ReportDao {
    
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/management?useSSL=false&serverTimezone=UTC", 
            "root", 
            "Ayush@25");
    }

    public List<Report> getAllReports() {
        List<Report> reports = new ArrayList<>();
        String sql = "SELECT * FROM reports ORDER BY generated_date DESC";

        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            
            while (rs.next()) {
                reports.add(mapResultSetToReport(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }

    public List<Report> searchReports(String keyword) {
        List<Report> reports = new ArrayList<>();
        String sql = "SELECT * FROM reports WHERE report_type LIKE ? OR report_title LIKE ? OR description LIKE ? OR summary LIKE ? ORDER BY generated_date DESC";

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            st.setString(1, searchPattern);
            st.setString(2, searchPattern);
            st.setString(3, searchPattern);
            st.setString(4, searchPattern);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                reports.add(mapResultSetToReport(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }

    public List<Report> filterReports(String reportType, String status, String year) {
        List<Report> reports = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM reports WHERE 1=1");
        
        if (reportType != null && !reportType.isEmpty()) {
            sql.append(" AND report_type LIKE ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
        }
        if (year != null && !year.isEmpty()) {
            sql.append(" AND YEAR(generated_date) = ?");
        }
        sql.append(" ORDER BY generated_date DESC");

        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (reportType != null && !reportType.isEmpty()) {
                st.setString(paramIndex++, "%" + reportType + "%");
            }
            if (status != null && !status.isEmpty()) {
                st.setString(paramIndex++, status);
            }
            if (year != null && !year.isEmpty()) {
                st.setInt(paramIndex++, Integer.parseInt(year));
            }

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                reports.add(mapResultSetToReport(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }

    public Report getReportById(int reportId) {
        String sql = "SELECT * FROM reports WHERE report_id = ?";
        
        try (Connection con = getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setInt(1, reportId);
            ResultSet rs = st.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToReport(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Report mapResultSetToReport(ResultSet rs) throws SQLException {
        Report report = new Report();
        report.setReportId(rs.getInt("report_id"));
        report.setReportType(rs.getString("report_type"));
        report.setReportTitle(rs.getString("report_title"));
        report.setDescription(rs.getString("description"));
        report.setGeneratedDate(rs.getDate("generated_date"));
        report.setGeneratedBy(rs.getString("generated_by"));
        report.setDateFrom(rs.getDate("date_from"));
        report.setDateTo(rs.getDate("date_to"));
        report.setTotalRecords(rs.getInt("total_records"));
        report.setSummary(rs.getString("summary"));
        report.setStatus(rs.getString("status"));
        return report;
    }
}
