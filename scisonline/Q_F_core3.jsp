<%-- 
    Document   : Q_F_core3
    Created on : Mar 2, 2015, 2:37:29 PM
    Author     : richa
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sun.org.apache.xalan.internal.xsltc.runtime.Hashtable"%>
<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Collections"%>
<%@page import ="javax.sql.*" %>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import ="java.sql.*" %>
<%@ include file="connectionBean.jsp" %>
<jsp:useBean id="prog" class="com.hcu.scis.automation.GetProgramme" scope="session">
</jsp:useBean>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <link rel="stylesheet" href="./css/query_display_style.css">
<%
             ArrayList<String> result=new ArrayList<String>();
             int current_year = scis.getLatestYear();
             String StreamName = request.getParameter("pname");
             String BatchYear = request.getParameter("pyear");
             int CurriculumYear = 0, LatestYear = 0;
             String stream1 = StreamName;
             StreamName = StreamName.replace('-', '_');
             int byear =Integer.parseInt(BatchYear);
            // out.println(byear);
%>
     
     
   </head>
  <body>
<%            
             Connection con=conn.getConnectionObj();
             int i, flag  ;
             String s = null;
             String r = ""; // for concataning  subject names 
             String id = null;
             String name = null;
             int n = 1; //for exception handleing
             int sno =1;
           try{  
                  ResultSet rs=null;
                  ResultSet rs3=null;
                  Statement stmt =con.createStatement();
                  Statement stmt1 =con.createStatement();
                  Statement stmt4 =con.createStatement();
                  int year1 = prog.latestCurriculumYear(StreamName, Integer.parseInt(BatchYear));
                  ResultSet rs1 = stmt1.executeQuery("select Cores from "+StreamName+"_"+year1+"_currrefer");
                  int core_count = 0;
                  while( rs1.next()){
                      core_count += rs1.getInt(1);
                  }
                 System.out.println("here : "+ core_count);
                 String sql1 ="select * from  "+StreamName+"_"+BatchYear;
                 String subname ="";
                 rs = stmt.executeQuery(sql1);
                 while(rs.next()){
                       r = "";
                       id = rs.getString(1);
                       name = rs.getString(2);
                       flag = 0;
                       i =4;
                       while(i<= (core_count*2+2) ){
                            s =rs.getString(i);
                            if("F".equals(s)|| "RR".equalsIgnoreCase(s)){
                                if(n == 1){%>
                                <center><h3 style="color:red">List of all students who have backlogs in core subjects </h3></center>
                                 <center><h3 style="color: red">Stream: <font style="color: blue"><%= stream1%></font>  Batch: <font style="color: blue"><%= BatchYear%></font></h3></center>
                                     <table  align="center" border="1" class = "maintable">
                                        <col width="5%">
                                        <col width="10%">
                                        <col width="25%">  
                                        <col width="60%">   
                                <tr>
                                    <th class="heading" align="center">SNo</th>
                                    <th class="heading" align="center">Student ID</th>
                                    <th class="heading" align="center">Student Name</th>
                                    <th class="heading" align="center">Subjects</th>
                                </tr>
<%                                  n++;
                                }
                                if(!result.contains(rs.getString(i-1))){
                                  result.add(rs.getString(i-1));
                                 } 
                               String SubjectName = scis.subjectName(rs.getString(i-1), StreamName, byear);
                               // out.println(rs.getString(i-1)+""+StreamName+""+ byear+""+SubjectName);
                                r = r +rs.getString(i-1)+":   "+SubjectName+"<br />";
                                flag = 1;
                         }
                           i = i+2;
                           } 
                             if(flag == 1 ) { %>
                               <tr>
                                   <td class = "cellpad"><%=sno++%></td>
                                    <td class = "cellpad"><%=id%></td>
                                    <td class = "cellpad"><%=name%></td>
                                    <td class = "cellpad"> <%=r%></td>
                          </tr>
                   
                
<%              
                           }
                       } if(n !=1){
            
                 }
           }catch(Exception e){
               System.out.println(e);
           }finally{
               conn.closeConnection();
               con = null ;
           }
 %>
            </table>
<%                if(n != 1){
                  }else {
%>                 <center><h3 style="color: red">There are no students, who have F in core subject, in <font style="color: blue"><%=stream1%> <%=BatchYear%></font> Batch</h3></center>
<%               }
%>
    </body>
</html>
            