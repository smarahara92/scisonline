 /* <%-- 
    Document   : atten2015.jsp
    Created on : Jan 22, 2015, 10:38:43 AM
    Author     : richa
--%> */

import java.sql.*;
public class Atten2015{
    static final String JDBC_DRIVER= "com.mysql.jdbc.Drivers";
    static final String DB_URL ="jdbc:mysql://localhost/JDBC_EXERCISE";
    static final String USER ="root";
    static final String PASS= "";
    public static void main(String[] args){
        Connection con = null;
        Statement stmt = null;
        try{
            Class.forName(JDBC_DRIVER);
            System.out.println("Connecting to database...................");
            con = DriverManager.getConnection(DB_URL,USER,PASS);
            System.out.println("Connected successfully to database...................");
            String sql ="select * from ATTEN where percentage >='75'";
            stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while(rs.next()){
                int id  = rs.getInt("student_id");
                String name = rs.getString("student_name");
                int m1 = rs.getInt("month1");
                 int m2 = rs.getInt("month2");
                  int m3 = rs.getInt("month3");
                   int m4 = rs.getInt("month4");
                    int c = rs.getInt("cumatten");
                     int p = rs.getInt("percentage");
         

         //Display values
                System.out.print("ID: " + id);
                System.out.print(", name: " + name);
                System.out.print(", month1: " + m1);
                System.out.print(", month2: " + m2);
                System.out.print(", month3: " + m3);
                System.out.print(", month4: " + m4);
                System.out.print(", cumatten: " + c);
                System.out.println(", percentage: " + p);
            }
        }catch(SQLException se){
        se.printStackTrace();
    }catch(Exception e){
        e.printStackTrace();
    }finally{
            try{
                if(stmt != null)
                    con.close();
            }catch(SQLException se){
            }  
            try{
                if(con != null)
                    con.close();
            }catch(SQLException se){
        }
    }
}
}