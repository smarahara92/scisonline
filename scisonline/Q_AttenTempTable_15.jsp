<%-- 
    Document   : Q_AttenTempTable_15
    Created on : Mar 13, 2015, 11:44:50 AM
    Author     : richa
--%>
<%@page import ="java.sql.*" %>
<%@ include file="connectionBean.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% Connection con = conn.getConnectionObj();
           try{
               
                Statement stmt1 = null;
                 Statement stmt2 = null;
                ResultSet rs = null;
                 ResultSet rs1 = null;
                  ResultSet rs2 = null;
                String CourseTable ="subject_attendance_Winter_2015";
                String sql ="select * from "+  CourseTable ;
                rs1 = stmt1.executeQuery(sql);
                String sqlU = null;
                 int i = 1 ;
                 int j = 0;
               while( rs.next() ){
                String CourseId = rs.getString(1);
                
                  System.out.println(" "+CourseId);
                 String sm = CourseId.substring(0,2);
                  String sm1 ="select type from subjecttable where  Code ='"+ CourseId +"'";
                  rs1 = stmt1.executeQuery(sm1);
                  rs1.next();
                  System.out.println("####"+rs1.getString(1)+"###");
                   String sql1 ="select StudentId,StudentName,cumatten,percentage from "+CourseId +"_Attendance_"+"Winter_2015" ;
                  rs2 = stmt2.executeQuery(sql1);
                  while(rs2.next()){
                        
                         String id  = rs2.getString("StudentId");
                         String name = rs2.getString("StudentName");
                         int c = rs2.getInt("cumatten");
                         int p = rs2.getInt("percentage");
                         if( i == 1){
                             System.out.println("In insertion");
                            sqlU = "insert into TempTable(student_id,student_name,c1,p1) VALUES('"+id+"', '"+name+"' ,'"+CourseId+"', '"+p+"')";
                         stmt1.executeUpdate(sqlU); 
                         System.out.println("insertion executed!!");
                         }
                         else if(i<11){
                             System.out.println("In update");
                             sqlU ="update TempTable SET c"+i+" = '"+CourseId+"' , p"+i+"='"+p+"' where student_id = '"+id+"'" ;  
                              System.out.println("update executed!!");
                         }
                         //System.out.println("QUERY Excecuted!!");
          

         //Display values
                System.out.print("ID: " + id);
                System.out.print(", name: " + name);
           
                System.out.print(", cumatten: " + c);
                System.out.println(", percentage: " + p);
                    }
                   i++;
                   j++;
                  System.out.println(i);
                  }
           
           }catch( Exception e){
               e.printStackTrace();
           }finally{
             con.close();
           }
            
            %>
    </body>
</html>
