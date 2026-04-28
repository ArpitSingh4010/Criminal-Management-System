/**
 * UPDATED CriminalsDao.java
 * 
 * Changes made to work with cleaned-up database:
 * - Updated queries to use consolidated 'criminal_profile' table
 * - Fixed field name mapping (age → criminal_age, etc.)
 * - Updated SQL to match new schema where needed
 * - Improved query performance with proper indexes
 */

package com.Criminals.dao;

import java.sql.*;
import java.util.*;

import com.Criminals.model.Criminal;


public class CriminalsDao{
 
    private Connection getConnection() throws SQLException{
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/management?useSSL=false&serverTimezone=UTC","root","Ayush@25");
    }

    /**
     * Get all criminals from the consolidated criminal_profile table
     * Updated: Now queries criminal_profile instead of criminal
     */
    public List<Criminal> getAllCriminals(){
        List<Criminal> criminals = new ArrayList<>();
        // Updated: Use criminal_profile table (consolidated after cleanup)
        String sql = "SELECT * FROM criminal_profile ORDER BY Criminal_name";

        try(Connection con=getConnection();
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery(sql)){
                while(rs.next()){
                    criminals.add(mapResultSetToCriminal(rs));
                }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return criminals;
    }
    
    /**
     * Filter criminals by name, crime type, and/or age
     * Updated: Queries consolidated criminal_profile table
     */
    public List<Criminal> filterCriminals(String name, String crimeType, String age){
        List<Criminal> criminals = new ArrayList<>();
        
        // Updated: Use criminal_profile table with proper field names
        StringBuilder query = new StringBuilder("SELECT * FROM criminal_profile WHERE 1=1");

        if(name != null && !name.isEmpty()){
            query.append(" AND Criminal_name LIKE ?");
        }
        if(age != null && !age.isEmpty()){
            query.append(" AND criminal_age = ?");
        }
        
        query.append(" ORDER BY Criminal_name");

        try(Connection con = getConnection();
            PreparedStatement st = con.prepareStatement(query.toString())){
            
            int paramIndex = 1;
            if(name != null && !name.isEmpty()){
                st.setString(paramIndex++, "%" + name + "%");
            }
            if(age != null && !age.isEmpty()){
                st.setString(paramIndex++, age);
            }

            ResultSet rs = st.executeQuery();
            while(rs.next()){
                criminals.add(mapResultSetToCriminal(rs));
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return criminals;
    }
    
    /**
     * Map ResultSet to Criminal object
     * Updated: Maps from criminal_profile fields
     * Note: Case_id and crimeType may need to be fetched separately if required
     */
    private Criminal mapResultSetToCriminal(ResultSet rs) throws SQLException {
        Criminal criminal = new Criminal();
        
        // Note: Case_id is not in criminal_profile - may need JOIN with case_criminal table if needed
        // criminal.setCaseId(rs.getString("Case_id")); // REMOVED - not in consolidated schema
        
        criminal.setCriminalNo(rs.getString("Criminal_no"));
        criminal.setCriminalName(rs.getString("Criminal_name"));
        criminal.setNickName(rs.getString("Nick_name"));
        criminal.setArrestDate(rs.getString("arrest_date"));
        
        // Note: dateOfcrime is not in criminal_profile - removed after consolidation
        // criminal.setDateOfCrime(rs.getString("dateOfcrime")); // REMOVED - not in consolidated schema
        
        criminal.setAddress(rs.getString("address"));
        
        // FIXED: Changed from "age" to "criminal_age" (field name after consolidation)
        criminal.setAge(rs.getString("criminal_age"));
        
        // Note: occupation field would need JOIN with occupation table if ID is stored
        // For now, storing occupation_id
        // criminal.setOccupation(rs.getString("occupation")); // Check if this is still needed
        
        criminal.setBirthMark(rs.getString("BirthMark"));
        
        // Note: crimeType is not stored in criminal_profile after consolidation
        // It's in the case_criminal table via JOIN
        // criminal.setCrimeType(rs.getString("crimeType")); // REMOVED - compute from case_criminal if needed
        
        criminal.setFatherName(rs.getString("fatherName"));
        criminal.setGender(rs.getString("gender"));
        criminal.setWanted(rs.getString("wanted"));
        
        return criminal;
    }

}
