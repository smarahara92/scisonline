<%-- 
    Document   : Q_allF3_15
    Created on : Mar 2, 2015, 9:46:37 PM
    Author     : richa
--%>


<%@page import="java.util.ArrayList"%>
<%@page import="com.sun.org.apache.xalan.internal.xsltc.runtime.Hashtable"%>
<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="java.util.Calendar"%>
<%@page import ="javax.sql.*" %>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@page import="java.util.Collections"%>
<%@page import ="java.sql.*" %>
<jsp:useBean id="prog" class="com.hcu.scis.automation.GetProgramme" scope="session">
</jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/query_display_style.css">
        <%
             Calendar now = Calendar.getInstance();
            ArrayList<String> result=new ArrayList<String>();
            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);
            String semester = "";
            String sem = "";
            int current_year = year;
            int sno =1;
             String StreamName = request.getParameter("pname");
            String BatchYear = request.getParameter("pyear");
             System.out.println(StreamName);
              String sname ="";
             String stream1 = StreamName;
                StreamName = StreamName.replace('-', '_');
                int byear =Integer.parseInt( BatchYear );
                    
               

            %>
        
     </head>
    <body>
        
        <%
            
           
           // System.out.println("name"+subjectname);
             Connection con=null;
             int i, flag  ;
             String s = null;
             String r = "";
             String id = null;
             String name = null;
             int n = 1;
           try{  
                    con = conn.getConnectionObj();
                    ResultSet rs=null;
                    ResultSet rs3=null;
                    Statement stmt =con.createStatement();
                    Statement stmt1 =con.createStatement();
                    Statement stmt4 =con.createStatement();
            //Hashtable ht= new Hashtable();
          
                int year1 = prog.latestCurriculumYear(StreamName, Integer.parseInt(BatchYear));
                ResultSet rs1 = stmt1.executeQuery("select Cores,Labs, Electives,OptionalCore from "+StreamName+"_"+year1+"_currrefer");
                int count = 0;
                System.out.println("Hello in final q");
                while( rs1.next())
                {
                    int count1 = rs1.getInt(1)+rs1.getInt(2)+rs1.getInt(3)+rs1.getInt(4);
                    count += count1;
                }
                System.out.println("here : "+ count);
                 String sql1 ="select * from  "+StreamName+"_"+BatchYear;
                 
                 rs = stmt.executeQuery(sql1);
                  while(rs.next()){
                      r = "";
                       id = rs.getString(1);
                       name = rs.getString(2);
                       flag = 0;
                       i =4;
                        while(i<= (count*2+2) ){
                            s =rs.getString(i);
                            if("F".equals(s) || "RR".equalsIgnoreCase(s)){
                              //  if(ht.contains())
                                if(n == 1){%>
                                
     <center><h3 style="color:red"> List of all students who have backlog in at least one subject </h3></center>
      <center><h3 style="color: red">Stream: <font style="color: blue"><%= stream1%></font>  Batch: <font style="color: blue"><%= BatchYear%></font></h3></center>
                                     <table align ='center' border="1" class = "maintable">
                                          <col width="10%">
                                          <col width="15%">
                                          <col width="25%">
                                          <col width="50%">   
                            <tr> 
                                    <th class="heading" align="center">SNo</th>
                                    <th class="heading" align="center">Student ID</th>
                                    <th class="heading" align="center">Student Name</th>
                                    <th class="heading" align="center">Subject</th>
                                </tr>
                                                             <% n++;}
                              if(!result.contains(rs.getString(i-1)))
                              {
                                  result.add(rs.getString(i-1));
                              }
                              sname =scis.subjectName(rs.getString(i-1),StreamName,byear);
                             // out.println(rs.getString(i-1)+""+sname);
                                r = r +rs.getString(i-1)+ ":  "+sname+"<br />" ;
                                flag = 1;
                      
                //    System.out.print(id);
                //    System.out.print("\t"+name);
                    
                 //   System.out.println("\t\t"+r);
                    
                  }
                     i = i+2;
                    }  if(flag == 1 ) { %>
                        <tr>
                            <td class = "cellpad"><%=sno++%></td>
                             <td class = "cellpad"><%=id%></td>
                             <td class = "cellpad"><%=name%></td>
                             <td class = "cellpad"><%=r%></td>
                   </tr>
                   <% }
                  }       
          
            if(n != 1){
            
           }
                               
           }catch(Exception e){
               System.out.println();
           }finally{
               conn.closeConnection();
               con = null;
           }
                
                %>
            </table>
             <% if(n != 1){
%>                
         <%}else {%>
                  <center><h3 style="color: red">There are no students, who have F in at least one subject, in <font style="color: blue"><%=stream1%> <%=BatchYear%></font> Batch</h3></center>
           <% }%>
                     </body>
                </html>
            