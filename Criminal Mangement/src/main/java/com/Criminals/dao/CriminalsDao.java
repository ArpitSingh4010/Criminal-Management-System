package com.Criminals.dao;

import java.sql.*;
import java.util.*;

import com.Criminals.model.Criminal;


public class CriminalsDao{
 
    private Connection getConnection() throws SQLException{
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/management?useSSL=false&serverTimezone=UTC","root","Ayush@25");
    }

    public List<Criminal> getAllCriminals(){
            List<Criminal> criminals = new ArrayList<>();
            String sql = "select * from criminal";

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
        
        public List<Criminal> filterCriminals(String name, String crimeType, String age){
            List<Criminal> criminals = new ArrayList<>();
            StringBuilder query = new StringBuilder("select * from criminal where 1=1");

            if(name != null && !name.isEmpty()){
                query.append(" and Criminal_name like ?");
            }
            if(crimeType != null && !crimeType.isEmpty()){
                query.append(" and crimeType like ?");
            }
            if(age != null && !age.isEmpty()){
                query.append(" and age = ?");
            }
            
            try(Connection con = getConnection();
                PreparedStatement st = con.prepareStatement(query.toString())){
                
                int paramIndex = 1;
                if(name != null && !name.isEmpty()){
                    st.setString(paramIndex++, "%" + name + "%");
                }
                if(crimeType != null && !crimeType.isEmpty()){
                    st.setString(paramIndex++, "%" + crimeType + "%");
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
        private Criminal mapResultSetToCriminal(ResultSet rs) throws SQLException {
        Criminal criminal = new Criminal();
        criminal.setCaseId(rs.getString("Case_id"));
        criminal.setCriminalNo(rs.getString("Criminal_no"));
        criminal.setCriminalName(rs.getString("Criminal_name"));
        criminal.setNickName(rs.getString("Nick_name"));
        criminal.setArrestDate(rs.getString("arrest_date"));
        criminal.setDateOfCrime(rs.getString("dateOfcrime"));
        criminal.setAddress(rs.getString("address"));
        criminal.setAge(rs.getString("age"));
        criminal.setOccupation(rs.getString("occupation"));
        criminal.setBirthMark(rs.getString("BirthMark"));
        criminal.setCrimeType(rs.getString("crimeType"));
        criminal.setFatherName(rs.getString("fatherName"));
        criminal.setGender(rs.getString("gender"));
        criminal.setWanted(rs.getString("wanted"));
        return criminal;
    }

}

