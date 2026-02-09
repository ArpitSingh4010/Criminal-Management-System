package com.CaseType.model;

public class CaseType {
    private int typeId;
    private String caseType;
    private String description;
    private String ipcSection;

    // Getters
    public int getTypeId() { 
        return typeId; 
    }
    
    public String getCaseType() { 
        return caseType; 
    }
    
    public String getDescription() { 
        return description; 
    }
    
    public String getIpcSection() { 
        return ipcSection; 
    }

    // Setters
    public void setTypeId(int typeId) { 
        this.typeId = typeId; 
    }
    
    public void setCaseType(String caseType) { 
        this.caseType = caseType; 
    }
    
    public void setDescription(String description) { 
        this.description = description; 
    }
    
    public void setIpcSection(String ipcSection) { 
        this.ipcSection = ipcSection; 
    }
    
    // Helper method to get image filename based on case type
    public String getImageName() {
        return caseType.toLowerCase().replace(" ", "-") + ".png";
    }
}
