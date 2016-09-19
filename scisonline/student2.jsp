<%-- 
    Document   : student2
    Created on : Feb 9, 2012, 9:38:33 AM
    Author     : jagan
--%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="checkValidity.jsp" %>
<%@include file="dbconnection.jsp"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body onload="checkvalidity()">
        
         <% Calendar now = Calendar.getInstance();
   
    System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
    int month=now.get(Calendar.MONTH)+1;
    int cyear=now.get(Calendar.YEAR);
    System.out.println("Current Month:"+month);
    System.out.println("Current Year:"+cyear);
    String year1="";
    String id="";
    String num="";
    String name="";
    String curriculum="";
    try{
             //name=(String)session.getAttribute("user");
               name="mc13mi28";
             year1=name.substring(2,4);
             id=name.substring(5,6);
             num=name.substring(6,8);
            name=year1+"mcm"+id+num;
            System.out.println(name);
                       }
    catch(Exception e)
                       {}
           int Sem1=0;
            int Sem2=0;
            int Sem3=0;
            int Sem4=0;
            int Sem5=0;
            int Sem6=0;
            int i=0;
            String stream="";
            String year="20"+year1;
            if(id.equalsIgnoreCase("t"))
            {
                stream="MTech_CS";
               curriculum="MTech_CS_curriculum"; 
            }
                       else if(id.equalsIgnoreCase("b"))
                                                     {
                           stream="MTech_IT";
                           curriculum="MTech_IT_curriculum";
                       }
                       else if(id.equalsIgnoreCase("i"))
                                                     {
                           stream="MTech_AI";
                           curriculum="MTech_AI_curriculum";
                       }
                      else  if(id.equalsIgnoreCase("c"))
                                                   {
                          stream="MCA";
                          curriculum="MCA_curriculum";
                      }
            
             System.out.println(year);
             System.out.println(stream);
             String batch=stream+"_"+year;
             System.out.println(batch);
             
             try
                                 {
                 Class.forName("com.mysql.jdbc.Driver").newInstance();
  //  System.out.println("driver connected");
    //Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
    Statement st1=con.createStatement();
    Statement st2=con.createStatement();
    
    Statement st3=con1.createStatement();
    
    Statement st4=con.createStatement();
    Statement st9=con.createStatement();
    Statement st10=con.createStatement();
    Statement st_cur=con.createStatement();
    
    String qry="select StudentName from "+stream+"_"+year+" where StudentId='"+name+"' ";
    String qry1="select * from "+stream+"_"+year+" where StudentId='"+name+"' ";
    
     ResultSet rs1=st1.executeQuery(qry);
     ResultSet rs2=st2.executeQuery(qry1);  
     ResultSetMetaData rsmd = rs2.getMetaData();
                int noOfColumns = rsmd.getColumnCount();
               int count=noOfColumns;
      String day="";
    String qry9="select start from session";
    ResultSet rs10=st9.executeQuery(qry9);
    while(rs10.next())
               {
        day=rs10.getString(1);
               }

              String semester="";
                                
        %>
        
        <center>University of Hyderabad</center>
        <center>Department of Computer and Information Sciences</center>
        <center>Attendance of the Student:<%=name%></center>
        <table border="0" align="center">
            <tr><td>
        <%    
        while(rs1.next())
        { %>
        <b>Name of the Student:</b><%=rs1.getString(1)%> 
  <%
  } %></td>
                <td></td>
                
                <td><b>Stream:</b><%=stream%></td>
                <td></td>
                <td><b>Batch:</b><%=year%></td> </tr>
        </table>
        <%if(month==1 || month==2 || month==3 || month==4 || month==5 || month==6)
                       {
     semester="Winter";
          }else
              semester="Monsoon";
                
                %>
                
                <table border="1" cellspacing="10" cellpadding="10" style="color:blue;background-color:#CCFFFF;" align="center">
    <%if(semester.equals("Monsoon"))
                           {%>
                           <tr>
        <th>SubjectName</th>
        <th>July15-Aug14</th>
        <th>Aug15-Sep14</th>
        <th>Sep15-Oct14</th>
        <th>Oct15-Nov14</th>
        <th>Overall Percentage</th>
      
    </tr>
                           <%}
         else if(semester.equals("Winter"))
           {      
    %>
    <tr>
        <th>SubjectName</th>
        <th>Jan<%=day%>-Jan31</th>
        <th>Feb1-Feb29</th>
        <th>Mar1-Mar31</th>
        <th>Apr1-Apr30</th>
        <th>Overall Percentage</th>
      
    </tr><%}%>
                <%
                
%>
            

   <%

   while(rs2.next())
             {
       int temp=(noOfColumns-4)/2; //need to mention number of columns in table
       int cummatten=0;
       int total=0;
      i=0;
        while(temp>0)
        {
           int m=i+3;
           if((rs2.getString(m+1).equals("R")))
                       {
           %>
        <%//=rs2.getString(m)%> <!--subjectid-->
    <tr>
        <%
        String subcode=rs2.getString(m);
        //if(subcode.equalsIgnoreCase("cs721")){subcode="AI800";}
       
        ResultSet rs_cur=st_cur.executeQuery("select Alias from "+curriculum+" where subjId='"+subcode+"'");
        
        if(rs_cur.next()){
        String col=rs_cur.getString(1);
        System.out.println("col value"+col);
        if(col!=null){
       System.out.println("col value"+col+"changed");
            subcode=col;
       }
       }
        
        String subj3="select Subject_Name from subjecttable where Code='"+subcode+"'";
        //System.out.println("second semester");
        ResultSet s3=st10.executeQuery(subj3);
        while(s3.next())
       {   if(!(s3.getString(1).contains("Project"))){
    %>
        <td><%=s3.getString(1)%></td>
        <%%>
        <%
       
        String qry3="select * from "+subcode+"_Assessment_"+semester+"_"+cyear+" where StudentId='"+name+"'";
        ResultSet rs3=st3.executeQuery(qry3);
        while(rs3.next())
       {%>
        <td><%=rs3.getInt(3)%></td>
        <td><%=rs3.getInt(4)%></td>
        <td><%=rs3.getInt(5)%></td>
        <td><%=rs3.getInt(6)%></td>
        <td><%=rs3.getFloat(8)%></td>
        <%}}}%>
   
    <%}
   i=i+2;
   temp--;
     }
    %>
    </tr>
    <%
       }
       %>
    
</table>

       <div align="center">
		<input type="button" value="Print"
			style="width: 50px; color: white; background-color: #6d77d9; border-color: red;"
                    onclick="window.print();" /> 

        
                <%
                 }
            catch(Exception e)
                                       {
                               e.printStackTrace();
            }
                %>
    </body>
</html>


       
      
        