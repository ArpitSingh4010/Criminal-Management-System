package com.Criminals.dao;

import com.login.dao.DbConnectionLog;

import java.sql.*;
import java.util.*;

import com.Criminals.model.Criminal;


public class CriminalsDao{
 
    private Connection getConnection() throws SQLException{
        DbConnectionLog.logConnectionLifecycleOnce();
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/management?useSSL=false&serverTimezone=UTC","root","Ayush@25");
        return con;
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
         * Filter criminals by name and/or age
         * Updated: Queries consolidated criminal_profile table
         * Note: crimeType filter removed (moved to case_criminal table)
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
         * Updated: Maps from criminal_profile fields after consolidation
         */
        private Criminal mapResultSetToCriminal(ResultSet rs) throws SQLException {
            Criminal criminal = new Criminal();
            
            // Note: Case_id is not in criminal_profile - join with case_criminal if needed
            try {
                criminal.setCaseId(rs.getString("Case_id"));
            } catch (SQLException e) {
                // Field doesn't exist in consolidated schema, set to null
                criminal.setCaseId(null);
            }
            
            criminal.setCriminalNo(rs.getString("Criminal_no"));
            criminal.setCriminalName(rs.getString("Criminal_name"));
            criminal.setNickName(rs.getString("Nick_name"));
            criminal.setArrestDate(rs.getString("arrest_date"));
            
            // Note: dateOfcrime is not in criminal_profile
            try {
                criminal.setDateOfCrime(rs.getString("dateOfcrime"));
            } catch (SQLException e) {
                // Field doesn't exist, set to null
                criminal.setDateOfCrime(null);
            }
            
            criminal.setAddress(rs.getString("address"));
            
            // FIXED: Changed from "age" to "criminal_age" (field name after consolidation)
            criminal.setAge(rs.getString("criminal_age"));
            
            // Note: occupation field needs JOIN with occupation table if ID is stored
            try {
                criminal.setOccupation(rs.getString("occupation"));
            } catch (SQLException e) {
                // Field doesn't exist directly, set to null
                criminal.setOccupation(null);
            }
            
            criminal.setBirthMark(rs.getString("BirthMark"));
            
            // Note: crimeType is not in criminal_profile after consolidation
            try {
                criminal.setCrimeType(rs.getString("crimeType"));
            } catch (SQLException e) {
                // Field doesn't exist, set to null
                criminal.setCrimeType(null);
            }
            
            criminal.setFatherName(rs.getString("fatherName"));
            criminal.setGender(rs.getString("gender"));
            criminal.setWanted(rs.getString("wanted"));
            
            return criminal;
        }

}

