<%-- 
    Document   : projectStaffNewInternshipMCA1
    Created on : 22 May, 2013, 12:05:25 PM
    Author     : varun
--%>

<%-- 
    Document   : projectStaffNewInternship1
    Created on : 28 Mar, 2013, 4:59:51 AM
    Author     : varun
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.*"%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body bgcolor="E0FFFF">
       
           <%
            Connection con = conn.getConnectionObj();
           
            Statement st1=con.createStatement();
            Statement st2=con.createStatement();
            Statement st3=con.createStatement();
            Statement st4=con.createStatement();
            Statement st5=con.createStatement();
            
            Integer pidInternProj =0,p_id=0;
            String stid = request.getParameter("stid"); 
         
            String sname = request.getParameter("sname");
            String orgName = request.getParameter("orgname");
            String projTitle = request.getParameter("projtitle");
            String intSup = request.getParameter("sel3");
            String orgSup = request.getParameter("orgsup"); 
            
            System.out.println(stid+"  "+sname+ " "+orgName+" "+projTitle+" "+intSup+" "+orgSup);
            int pyear = scis.studentBatchYear(stid);
                 
                String id=stid.substring(5,6);
                String table="";
                System.out.println(stid);
                ResultSet rs1=null;
                
                if(id.equalsIgnoreCase("c")) {
                    table="MCA_Project_Student_"+pyear;
                         rs1=(ResultSet)st1.executeQuery("select * from  MCA_Project_Student_"+pyear+" as a where a.StudentId='"+stid+"' ");
                }
            
                int projectId=0;
              
                while(rs1.next())
                {
                    projectId=Integer.parseInt(rs1.getString(2));  //Contains the old project of student(Universtiy Project ID.)
                }  
                if(projectId!=0)
                {
                  try {
                    st3.executeUpdate("insert into  MCA_Project"+"_"+pyear+" (ProjectTitle,SupervisorId1,SupervisorId2,Organization,Allocated) values('"+projTitle+"', '"+orgSup+"', '"+intSup+"','"+orgName+"','yes')");  
                    ResultSet rs4=(ResultSet)st4.executeQuery("select * from MCA_Project"+"_"+pyear+" where ProjectTitle='"+projTitle+"'");
                    while(rs4.next())
                       p_id=Integer.parseInt(rs4.getString(1));            // Contains the new Project Title ID.
                    
                    st4.executeUpdate("update  "+table+" set ProjectId='"+p_id+"' where StudentId='"+stid+"' ");  
                    rs4.close();
                   } catch(Exception ex)
                     {
                        ex.printStackTrace();
                     }
                    
                %>  <h2>Project Successfully Modified.</h2>
           <% }
                st1.close();
                st2.close();
                st3.close();
                st4.close();
                st5.close();
                rs1.close();
                conn.closeConnection();
                con = null;
                scis.close();
           %>
    </body>
</html>
