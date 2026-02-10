package com.SignUp.model;

/**
 * User model class for registration
 */
public class User {
    private int id;
    private String username;
    private int age;
    private String email;
    private String password;
    private String phone;
    private String role;
    
    // Constructors
    public User() {
    }
    
    public User(String username, int age, String email, String password, String phone) {
        this.username = username;
        this.age = age;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.role = "user"; // Default role
    }

    public User(String username, int age, String email, String password, String phone, String role) {
        this.username = username;
        this.age = age;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.role = role;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public int getAge() {
        return age;
    }
    
    public void setAge(int age) {
        this.age = age;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
    
    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", age=" + age +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", role='" + role + '\'' +
                '}';
    }
}
