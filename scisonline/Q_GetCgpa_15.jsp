<%@include file="checkValidity.jsp"%>
<%@ include file="connectionBean.jsp" %>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<jsp:useBean id="cgpa" class="com.hcu.scis.automation.GetCgpa" scope="session"></jsp:useBean>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/query_display_style.css">
    </head>
    <body>
        <center><h3 style="color:red">List of CGPA of students in descending order of a particular stream & batch <h3></center>
        
        
        <%  Connection con = conn.getConnectionObj();
            try{
           
                String StreamName = request.getParameter("pname");
                String BatchYearStr = request.getParameter("pyear");
                int BatchYear = Integer.parseInt(BatchYearStr);
                int curriculumYear = scis.latestCurriculumYear(StreamName, BatchYear);
                
                String stream = StreamName.replace("-","_");
                stream =stream+"_"+BatchYear;
                Statement st1 = con.createStatement();
        String curriculum =StreamName.replace('-', '_')+"_"+curriculumYear+"_"+"curriculum" ;%>
              <center><h3 style="color: red">Stream: <font style="color: blue"><%= StreamName%></font>  Batch: <font style="color: blue"><%= BatchYear%></font></h3></center>
        <%
      //  out.println(stream+""+curriculum);
           int k = cgpa.getCgpa(stream, curriculum);
            ResultSet rs_student = null;
            int sno=1;
            rs_student  = (ResultSet) st1.executeQuery("select * from " + stream +"_temp ORDER by cgpa DESC");%>
             <table  align="center" border="1" class = "maintable">
                                        <col width="10%">
                                    <col width="15%">
                                    <col width="50%">  
                                     <col width="25%">  
                                   <tr>
                                    <th class="heading" align="center">SNo</th>
                                    <th class="heading" align="center">Student ID</th>
                                    <th class="heading" align="center">Student Name</th>
                                    <th class="heading" align="center">CGPA</th>
                                </tr>
                                <%
                                    while(rs_student.next()){
                                                String student_id = rs_student.getString(1);
                                                String student_name = rs_student.getString(2);
                                                float cgpa1 = rs_student.getFloat(4);
                                                System.out.println(student_id +"\t\t\t"+student_name+"\t\t\t"+cgpa1);%>
                                        <tr>
                            <td class = "cellpad"><%=sno++%></td>
                             <td class = "cellpad"><%=student_id%></td>
                             <td class = "cellpad"><%=student_name%></td>
                             <td class = "cellpad"> <%=cgpa1%></td>
                   </tr>
                             
                                    <%}
        }catch(Exception e){
            
        }finally{
            conn.closeConnection();
        }
        %>
        </body>
        </html>