package com.Reports.model;

import java.sql.Date;

public class Report {
    private int reportId;
    private String reportType;
    private String reportTitle;
    private String description;
    private Date generatedDate;
    private String generatedBy;
    private Date dateFrom;
    private Date dateTo;
    private int totalRecords;
    private String summary;
    private String status;

    // Getters
    public int getReportId() {
        return reportId;
    }

    public String getReportType() {
        return reportType;
    }

    public String getReportTitle() {
        return reportTitle;
    }

    public String getDescription() {
        return description;
    }

    public Date getGeneratedDate() {
        return generatedDate;
    }

    public String getGeneratedBy() {
        return generatedBy;
    }

    public Date getDateFrom() {
        return dateFrom;
    }

    public Date getDateTo() {
        return dateTo;
    }

    public int getTotalRecords() {
        return totalRecords;
    }

    public String getSummary() {
        return summary;
    }

    public String getStatus() {
        return status;
    }

    // Setters
    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public void setReportType(String reportType) {
        this.reportType = reportType;
    }

    public void setReportTitle(String reportTitle) {
        this.reportTitle = reportTitle;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setGeneratedDate(Date generatedDate) {
        this.generatedDate = generatedDate;
    }

    public void setGeneratedBy(String generatedBy) {
        this.generatedBy = generatedBy;
    }

    public void setDateFrom(Date dateFrom) {
        this.dateFrom = dateFrom;
    }

    public void setDateTo(Date dateTo) {
        this.dateTo = dateTo;
    }

    public void setTotalRecords(int totalRecords) {
        this.totalRecords = totalRecords;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    // Helper method to get report type color
    public String getReportTypeColor() {
        if (reportType == null) return "#6c757d";
        
        if (reportType.contains("Crime")) {
            return "#dc3545"; // Red for crime reports
        } else if (reportType.contains("Officer")) {
            return "#007bff"; // Blue for officer reports
        } else if (reportType.contains("Law")) {
            return "#6f42c1"; // Purple for law reports
        } else if (reportType.contains("Criminal")) {
            return "#fd7e14"; // Orange for criminal analysis
        } else if (reportType.contains("Case")) {
            return "#20c997"; // Teal for case analysis
        } else {
            return "#6c757d"; // Gray for others
        }
    }
    
    // Helper method to get status color
    public String getStatusColor() {
        if ("Active".equals(status)) {
            return "#28a745"; // Green
        } else if ("Archived".equals(status)) {
            return "#6c757d"; // Gray
        } else {
            return "#ffc107"; // Yellow
        }
    }
}
