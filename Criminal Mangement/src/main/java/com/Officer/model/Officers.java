package com.Officer.model;

public class Officers {
    private int officerId;
    private String name;
    private int age;
    private String designation;
    private String badgeNumber;
    private String department;
    private String state;
    private int yearsOfService;

    // Getters
    public int getOfficerId() {
        return officerId;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public String getDesignation() {
        return designation;
    }

    public String getBadgeNumber() {
        return badgeNumber;
    }

    public String getDepartment() {
        return department;
    }

    public String getState() {
        return state;
    }

    public int getYearsOfService() {
        return yearsOfService;
    }

    // Setters
    public void setOfficerId(int officerId) {
        this.officerId = officerId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public void setBadgeNumber(String badgeNumber) {
        this.badgeNumber = badgeNumber;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public void setState(String state) {
        this.state = state;
    }

    public void setYearsOfService(int yearsOfService) {
        this.yearsOfService = yearsOfService;
    }
    
    // Helper method to get rank badge color
    public String getRankColor() {
        if (designation.contains("Director General") || designation.contains("Additional Director")) {
            return "#8B0000"; // Dark Red
        } else if (designation.contains("Inspector General")) {
            return "#DC143C"; // Crimson
        } else if (designation.contains("Deputy Inspector General")) {
            return "#FF4500"; // Orange Red
        } else if (designation.contains("Superintendent")) {
            return "#FF8C00"; // Dark Orange
        } else if (designation.contains("Inspector")) {
            return "#4169E1"; // Royal Blue
        } else {
            return "#32CD32"; // Lime Green
        }
    }
}
