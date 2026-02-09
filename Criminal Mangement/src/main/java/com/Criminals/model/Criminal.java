package com.Criminals.model;

public class Criminal {
    private String caseId;
    private String criminalNo;
    private String criminalName;
    private String nickName;
    private String arrestDate;
    private String dateOfCrime;
    private String address;
    private String age;
    private String occupation;
    private String birthMark;
    private String crimeType;
    private String fatherName;
    private String gender;
    private String wanted;

    // Getters
    public String getCaseId() { return caseId; }
    public String getCriminalNo() { return criminalNo; }
    public String getCriminalName() { return criminalName; }
    public String getNickName() { return nickName; }
    public String getArrestDate() { return arrestDate; }
    public String getDateOfCrime() { return dateOfCrime; }
    public String getAddress() { return address; }
    public String getAge() { return age; }
    public String getOccupation() { return occupation; }
    public String getBirthMark() { return birthMark; }
    public String getCrimeType() { return crimeType; }
    public String getFatherName() { return fatherName; }
    public String getGender() { return gender; }
    public String getWanted() { return wanted; }

    // Setters
    public void setCaseId(String caseId) { this.caseId = caseId; }
    public void setCriminalNo(String criminalNo) { this.criminalNo = criminalNo; }
    public void setCriminalName(String criminalName) { this.criminalName = criminalName; }
    public void setNickName(String nickName) { this.nickName = nickName; }
    public void setArrestDate(String arrestDate) { this.arrestDate = arrestDate; }
    public void setDateOfCrime(String dateOfCrime) { this.dateOfCrime = dateOfCrime; }
    public void setAddress(String address) { this.address = address; }
    public void setAge(String age) { this.age = age; }
    public void setOccupation(String occupation) { this.occupation = occupation; }
    public void setBirthMark(String birthMark) { this.birthMark = birthMark; }
    public void setCrimeType(String crimeType) { this.crimeType = crimeType; }
    public void setFatherName(String fatherName) { this.fatherName = fatherName; }
    public void setGender(String gender) { this.gender = gender; }
    public void setWanted(String wanted) { this.wanted = wanted; }
}