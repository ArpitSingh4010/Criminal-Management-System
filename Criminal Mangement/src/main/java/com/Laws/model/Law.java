package com.Laws.model;

public class Law {
    private int lawId;
    private String section;
    private String title;
    private String description;
    private String actName;
    private String offenseType;
    private String punishment;
    private String bailable;
    private String cognizable;
    private String compoundable;

    // Getters
    public int getLawId() {
        return lawId;
    }

    public String getSection() {
        return section;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getActName() {
        return actName;
    }

    public String getOffenseType() {
        return offenseType;
    }

    public String getPunishment() {
        return punishment;
    }

    public String getBailable() {
        return bailable;
    }

    public String getCognizable() {
        return cognizable;
    }

    public String getCompoundable() {
        return compoundable;
    }

    // Setters
    public void setLawId(int lawId) {
        this.lawId = lawId;
    }

    public void setSection(String section) {
        this.section = section;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setActName(String actName) {
        this.actName = actName;
    }

    public void setOffenseType(String offenseType) {
        this.offenseType = offenseType;
    }

    public void setPunishment(String punishment) {
        this.punishment = punishment;
    }

    public void setBailable(String bailable) {
        this.bailable = bailable;
    }

    public void setCognizable(String cognizable) {
        this.cognizable = cognizable;
    }

    public void setCompoundable(String compoundable) {
        this.compoundable = compoundable;
    }
    
    // Helper method to get severity color based on offense type
    public String getSeverityColor() {
        if (offenseType == null) return "#666";
        
        if (offenseType.contains("Person") || offenseType.contains("Sexual") || offenseType.contains("Women")) {
            return "#DC143C"; // Crimson for serious crimes
        } else if (offenseType.contains("Property")) {
            return "#FF8C00"; // Dark Orange
        } else if (offenseType.contains("Corruption")) {
            return "#8B008B"; // Dark Magenta
        } else if (offenseType.contains("Drug") || offenseType.contains("Trafficking")) {
            return "#8B0000"; // Dark Red
        } else if (offenseType.contains("Cyber")) {
            return "#4169E1"; // Royal Blue
        } else {
            return "#2F4F4F"; // Dark Slate Gray
        }
    }
    
    // Helper method to get bailable status badge color
    public String getBailableColor() {
        if ("No".equals(bailable)) {
            return "#dc3545"; // Red - Non-bailable
        } else if ("Yes".equals(bailable)) {
            return "#28a745"; // Green - Bailable
        } else {
            return "#ffc107"; // Yellow - Depends
        }
    }
}
