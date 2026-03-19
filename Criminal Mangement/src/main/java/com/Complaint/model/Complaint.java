package com.Complaint.model;

/**
 * Model class representing a filed complaint (victim report)
 */
public class Complaint {

    private int complaintId;
    private String username;       // References user who filed it
    private String crimeType;
    private String description;
    private String incidentDate;
    private String incidentLocation;
    private String status;
    private String filedAt;

    public Complaint() {}

    public Complaint(String username, String crimeType, String description,
                     String incidentDate, String incidentLocation) {
        this.username         = username;
        this.crimeType        = crimeType;
        this.description      = description;
        this.incidentDate     = incidentDate;
        this.incidentLocation = incidentLocation;
        this.status           = "Pending";
    }

    // Getters & Setters
    public int    getComplaintId()       { return complaintId; }
    public void   setComplaintId(int id) { this.complaintId = id; }

    public String getUsername()              { return username; }
    public void   setUsername(String u)      { this.username = u; }

    public String getCrimeType()             { return crimeType; }
    public void   setCrimeType(String ct)    { this.crimeType = ct; }

    public String getDescription()           { return description; }
    public void   setDescription(String d)   { this.description = d; }

    public String getIncidentDate()          { return incidentDate; }
    public void   setIncidentDate(String id) { this.incidentDate = id; }

    public String getIncidentLocation()      { return incidentLocation; }
    public void   setIncidentLocation(String l) { this.incidentLocation = l; }

    public String getStatus()              { return status; }
    public void   setStatus(String s)     { this.status = s; }

    public String getFiledAt()             { return filedAt; }
    public void   setFiledAt(String f)    { this.filedAt = f; }
}
