<%-- 
    Document   : streamwise
    Created on : Aug 30, 2011, 5:55:38 AM
    Author     : admin
--%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="java.util.Calendar"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            document.getElementById('a1').innerHTML='abc';
        </script>
    </head>
    <body>
        <%
         Calendar now = Calendar.getInstance();
   
    System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
    int month=now.get(Calendar.MONTH)+1;
    int year=now.get(Calendar.YEAR);
    System.out.println("Current Month:"+month);
    System.out.println("Current Year:"+year);
            String year2=request.getParameter("year");
            System.out.println("Year2 value is:"+year2);
            String stream=request.getParameter("streamname");
            System.out.println("stream name is:"+stream);
            String stream1="M.Tech-CS";
            String stream2="M.Tech-AI";
            String stream3="M.Tech-IT";
            String stream4="MCA";
            int Sem1=0;
            int Sem2=0;
            int Sem3=0;
            int Sem4=0;
            int Sem5=0;
            int Sem6=0;
            int i=0;
            String cstream="";
            String cyear="";
        %>
        
        
        
        
        <%
       
    
            try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    System.out.println("driver connected");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
    System.out.println("database connected");
    //String qry="create table temp(fid varchar(20))";
    String qry="select * from MTech_CS_2011";
   // String qry6="alter table mtechcs_2011 drop core0,drop core1,drop core2,drop core3,drop core4,drop core5,drop core6,drop core7,drop core8,drop core9,drop core10,drop core11,drop core12,drop core13,drop core14";
    
    Statement st1=con.createStatement();
    Statement st2=con.createStatement();
    Statement st4=con.createStatement();
    Statement st10=con.createStatement();
    //st2.executeUpdate(qry6);
   // ResultSet rs=st1.executeQuery(qry);
    
    
        %>
        <%
        //Monsoon
        //month==7 || month==8 || month==9 || month==10 || month==11 || month==12
        //month==1 || month==2 || month==3 || month==4 || month==5 || month==6
        if(month==1 || month==2 || month==3 || month==4 || month==5 || month==6)
                       {
            String semester="Winter";
            //semester 2,4,6
            if(stream.equals(stream4+"-"+year2))
                               {
                cstream=stream4;
                cyear=year2;
                               
            }else if(stream.equals(stream4+"-"+(Integer.parseInt(year2)-1)))
                               {
                
                cstream=stream4;
                cyear=Integer.toString(Integer.parseInt(year2)-1);
                System.out.println("cyear is:------->"+cyear);
                               
            }else 
                 if(stream.equals(stream1+"-"+year2))
                                                     {
                           cstream="MTech_CS";
                cyear=year2;
                           
                       }
            else if(stream.equals(stream2+"-"+year2))
                                                     {
                           cstream="MTech_AI";
                cyear=year2;
                           
                       }
            else if(stream.equals(stream3+"-"+year2))
                                                     {
                           cstream="MTech_IT";
                cyear=year2;
                           
                       }
               System.out.println("cstream is:-----------------_>"+cstream);
               System.out.println("cyear is:-----------------_>"+cyear);
                String qry2="select Semester,core+lab+elective+project as total from "+cstream+"_currrefer";
                ResultSet rs2=st2.executeQuery(qry2);
                 while(rs2.next())
                {
                    if(rs2.getString(1).equals("Sem1"))
                                               {
                    Sem1=rs2.getInt(2);
                    }
                    if(rs2.getString(1).equals("Sem2"))
                                               {
                    Sem2=rs2.getInt(2);
                    }
                    if(rs2.getString(1).equals("Sem3"))
                                               {
                    Sem3=rs2.getInt(2);
                    }
                    if(rs2.getString(1).equals("Sem4"))
                                               {
                    Sem4=rs2.getInt(2);
                    }
                    if(rs2.getString(1).equals("Sem5"))
                                               {
                    Sem5=rs2.getInt(2);
                    }
                    if(rs2.getString(1).equals("Sem6"))
                                               {
                    Sem6=rs2.getInt(2);
                    }
                                       }
    //semester2
                if((year-Integer.parseInt(cyear))==1)
                                       {
                    int cyear1=Integer.parseInt(cyear);
                  cyear=Integer.toString(cyear1);
                     String qry1="select * from "+cstream+"_"+cyear+"";
                ResultSet rs1=st4.executeQuery(qry1);
               
                %>
                <center>University of Hyderabad</center>
        <center>Department of Computer and Information Sciences</center>
        <center> <%=cstream%>-<%=cyear%>-II semester  Attendance in percentage </center>
                <table border="1" cellspacing="3" cellpadding="3" style="color:blue;background-color:#CCFFFF;">
    <tr>
        <th>StudentID</th>
        <th>StudentName</th>
       <%
       int k=Sem1+1;
       int temp=Sem2;
       while(temp>0)
                     {
           %>
           <!--subjectid-->
        <th colspan="2">Subject<%=k%></th>
        <%
        k++;
        temp--;
               }
        %>
        <th>Overall Percentage</th>
        <th>Remarks</th>
    </tr>
    <% 
   
    while(rs1.next())
    { 
    String remarks="";
    %>
    <tr>
        <td><%=rs1.getString(1)%></td> <!--studentid-->
        <td><%=rs1.getString(2)%></td> <!--student name-->
        
       <%
//System.out.println(rs1.getString(2));       
i=2+2*Sem1; 
      // System.out.println("value of i:"+i);
       temp=Sem2;
       System.out.println(temp);
       int cummatten=0;
       int total=0;
       while(temp>0)
        {
           int m=i+1;
           %>
        <td><%=rs1.getString(m)%></td> <!--subjectid-->
        <%
            String qry10="select cumatten from subject_attendance where subjectId='"+rs1.getString(m)+"'";
            ResultSet rs10=st10.executeQuery(qry10);
            while(rs10.next())
                               {
                               total=total+rs10.getInt(1);
            }
            String qry9="select cumatten,percentage from "+semester+"_"+year+"_"+rs1.getString(m)+" where StudentId='"+rs1.getString(1)+"'";
            System.out.println(rs1.getString(1));
            ResultSet rs3=st2.executeQuery(qry9);
          while(rs3.next())
          {   System.out.println(rs1.getString(m)+"-"+rs3.getInt(2));   
              cummatten=cummatten+rs3.getInt(1);  
              if(rs3.getInt(2) < 75)
                  remarks=remarks+" "+rs1.getString(m)+" "+rs3.getInt(2)+"% ";
         %>
        <td bgcolor="white"><%=rs3.getInt(2)%></td> <!--Attedance-->
        <%}%>
        <%
        i=i+2;
        temp--;
               }
        %>
        <%System.out.println("cumulative="+cummatten);
        System.out.println("total"+total);
        float percentage=(cummatten*100/total);%>
        <td><%=percentage%></td>
        <td><%=remarks%></td>
    </tr>
    <%
       }
    %>
        </table>
                    <%
                                                  }
                %>
                
                <%
  //semester4
                 if((year-Integer.parseInt(cyear))==2)
                                       {
                      int cyear1=Integer.parseInt(cyear);
                  cyear=Integer.toString(cyear1);
                  
                      String qry1="select * from "+cstream+"_"+cyear+"";
                ResultSet rs1=st4.executeQuery(qry1);
                
                %>
                <center>University of Hyderabad</center>
        <center>Department of Computer and Information Sciences</center>
        <center> <%=cstream%>_<%=cyear%>-IV semester  Attendance in percentage </center>
                <table border="1" cellspacing="3" cellpadding="3" style="color:blue;background-color:#CCFFFF;">
    <tr>
        <th>StudentID</th>
        <th>StudentName</th>
       <%
       int k=Sem1+Sem2+Sem3+1;
       int temp=Sem4;
       while(temp>0)
                     {
           %>
        <th colspan="2">Subject<%=k%></th>
        <%
        k++;
        temp--;
               }
        %>
        <th>Overall Percentage</th>
        <th>Remarks</th>
    </tr>
    <% 
    while(rs1.next())
    { %>
    <tr>
        <td><%=rs1.getString(1)%></td>
        <td><%=rs1.getString(2)%></td>
       <%
System.out.println(rs1.getString(2));       
i=2+2*Sem1+2*Sem2+2*Sem3; 
       System.out.println("value of i:"+i);
       temp=Sem4;
       int cummatten=0;
       int total=0;
       while(temp>0)
        {
           int m=i+1;
           %>
        <td><%=rs1.getString(m)%></td> <!--subjectid-->
        <%
            String qry10="select cumatten from subject_attendance where subjectId='"+rs1.getString(m)+"'";
            ResultSet rs10=st10.executeQuery(qry10);
            while(rs10.next())
                               {
                               total=total+rs10.getInt(1);
            }
            String qry9="select cumatten,percentage from "+semester+"_"+year+"_"+rs1.getString(m)+" where StudentId='"+rs1.getString(1)+"'";
            ResultSet rs3=st2.executeQuery(qry9);
          while(rs3.next())
          {      cummatten=cummatten+rs3.getInt(1);         
         %>
        <td bgcolor="white"><%=rs3.getInt(2)%></td> <!--Attedance-->
        <%}%>
        <%
        i=i+2;
        temp--;
               }
        %>
        <%System.out.println("cumulative="+cummatten);
        System.out.println("total"+total);
        float percentage=(cummatten*100/total);%>
        <td><%=percentage%></td>
        <td></td>
        
    </tr>
    
    <%
       }
    %>
        </table>
                    <%
                                                  }
                %>
                
                <%
  //semester6
                 if((year-Integer.parseInt(cyear))==3)
                                       {
                  int cyear1=Integer.parseInt(cyear);
                  cyear=Integer.toString(cyear1);
                      String qry1="select * from "+cstream+"_"+cyear+"";
                ResultSet rs1=st4.executeQuery(qry1);
                
                %>
                <center>University of Hyderabad</center>
        <center>Department of Computer and Information Sciences</center>
        <center> <%=cstream%>_<%=cyear%>-II semester  Attendance in percentage </center>
                <table border="1" cellspacing="3" cellpadding="3" style="color:blue;background-color:#CCFFFF;">
    <tr>
        <th>StudentID</th>
        <th>StudentName</th>
       <%
       int k=Sem1+Sem2+Sem3+Sem4+Sem5+1;
       int temp=Sem6;
       while(temp>0)
                     {
           %>
        <th colspan="2">Subject<%=k%></th>
        <%
        k++;
        temp--;
               }
        %>
        <th>Overall Percentage</th>
        <th>Remarks</th>
    </tr>
    <% 
    while(rs1.next())
    { %>
    <tr>
        <td><%=rs1.getString(1)%></td>
        <td><%=rs1.getString(2)%></td>
       <% i=2+2*Sem1+2*Sem2+2*Sem3+2*Sem4+2*Sem5; 
       System.out.println("value of i:"+i);
       temp=2*Sem6;
       while(temp>0)
        {
           %>
        <td><%=rs1.getString(i+1)%></td>
        <%
        i++;
        temp--;
               }
        %>
        <td>0</td>
        <td>Remarks</td>
    
    <%
       }
    %>
        </table>
                    <%
                                                  }
                %>
                <%
            
            
      } %>
        <%
        //Winter
        //month==1 || month==2 || month==3 || month==4 || month==5 || month==6
        //month==7 || month==8 || month==9 || month==10 || month==11 || month==12
        if(month==7 || month==8 || month==9 || month==10 || month==11 || month==12)
                       {
            String semester="Monsoon";
            //semester 1,3,5
            if(stream.equals(stream4+"_"+year2))
                               {
                cstream=stream4;
                cyear=year2;
                               
            }
                       else if(stream.equals(stream1+"_"+year2))
                                                     {
                           cstream=stream1;
                cyear=year2;
                           
                       }
            else if(stream.equals(stream2+"_"+year2))
                                                     {
                           cstream=stream2;
                cyear=year2;
                           
                       }
            else if(stream.equals(stream3+"_"+year2))
                                                     {
                           cstream=stream3;
                cyear=year2;
                           
                       }
            
    
              
                String qry2="select Semester,core+lab+elective+project as total from "+cstream+"_currrefer";
                ResultSet rs2=st2.executeQuery(qry2);
                 while(rs2.next())
                {
                    if(rs2.getString(1).equals("Sem1"))
                                               {
                    Sem1=rs2.getInt(2);
                    }
                    if(rs2.getString(1).equals("Sem2"))
                                               {
                    Sem2=rs2.getInt(2);
                    }
                    if(rs2.getString(1).equals("Sem3"))
                                               {
                    Sem3=rs2.getInt(2);
                    }
                    if(rs2.getString(1).equals("Sem4"))
                                               {
                    Sem4=rs2.getInt(2);
                    }
                    if(rs2.getString(1).equals("Sem5"))
                                               {
                    Sem5=rs2.getInt(2);
                    }
                    if(rs2.getString(1).equals("Sem6"))
                                               {
                    Sem6=rs2.getInt(2);
                    }
                                       }
    //semester1
                if((year-Integer.parseInt(cyear))==0)
                                       {
                    int cyear1=Integer.parseInt(cyear);
                  cyear=Integer.toString(cyear1);
                     String qry1="select * from "+cstream+"_"+cyear+"";
                ResultSet rs1=st4.executeQuery(qry1);
               
                %>
                <table border="1" cellspacing="3" cellpadding="3" style="color:blue;background-color:#CCFFFF;">
    <tr>
        <th>StudentID</th>
        <th>StudentName</th>
       <%
       int k=1;
       int temp=Sem1;
       while(temp>0)
                     {
           %>
        <th colspan="2">Subject<%=k%></th>
        <%
        k++;
        temp--;
               }
        %>
        <th>Overall Percentage</th>
        <th>Remarks</th>
    </tr>
    <% 
    while(rs1.next())
    { %>
    <tr>
        <td><%=rs1.getString(1)%></td>
        <td><%=rs1.getString(2)%></td>
       <% i=2; 
       System.out.println("value of i:"+i);
       temp=2*Sem1;
       while(temp>0)
        {
           %>
        <td><%=rs1.getString(i+1)%></td>
        <%
        i++;
        temp--;
               }
        %>
        <td>0</td>
        <td></td>
    
    <%
       }
    %>
        </table>
                    <%
                                                  }
                %>
                
                <%
  //semester3
                 if((year-Integer.parseInt(cyear))==1)
                                       {
                      int cyear1=Integer.parseInt(cyear);
                  cyear=Integer.toString(cyear1);
                     String qry1="select * from "+cstream+"_"+cyear+"";
                ResultSet rs1=st4.executeQuery(qry1);
                
                %>
                <table border="1" cellspacing="3" cellpadding="3" style="color:blue;background-color:#CCFFFF;">
    <tr>
        <th>StudentID</th>
        <th>StudentName</th>
       <%
       int k=Sem1+Sem2+1;
       int temp=Sem3;
       while(temp>0)
                     {
           %>
        <th colspan="2">Subject<%=k%></th>
        <%
        k++;
        temp--;
               }
        %>
        <th>Overall Percentage</th>
        <th>Remarks</th>
    </tr>
    <% 
    while(rs1.next())
    { %>
    <tr>
        <td><%=rs1.getString(1)%></td>
        <td><%=rs1.getString(2)%></td>
       <% i=2+2*Sem1+2*Sem2; 
      // System.out.println("value of i:"+i);
       temp=2*Sem3;
       while(temp>0)
        {
           %>
        <td><%=rs1.getString(i+1)%></td>
        <%
        i++;
        temp--;
               }
        %>
        <td>0</td>
        <td></td>
    
    <%
       }
    %>
        </table>
                    <%
                                                  }
                %>
                
                <%
  //semester5
                 if((year-Integer.parseInt(cyear))==2)
                                       {
                      int cyear1=Integer.parseInt(cyear);
                  cyear=Integer.toString(cyear1);
                     String qry1="select * from "+cstream+"_"+cyear+"";
                ResultSet rs1=st4.executeQuery(qry1);
                
                %>
                <table border="1" cellspacing="3" cellpadding="3" style="color:blue;background-color:#CCFFFF;">
    <tr>
        <th>StudentID</th>
        <th>StudentName</th>
       <%
       int k=Sem1+Sem2+Sem3+Sem4+1;
       int temp=Sem5;
       while(temp>0)
                     {
           %>
        <th colspan="2">Subject<%=k%></th>
        <%
        k++;
        temp--;
               }
        %>
        <th>Overall Percentage</th>
        <th>Remarks</th>
    </tr>
    <% 
    while(rs1.next())
    { %>
    <tr>
        <td><%=rs1.getString(1)%></td>
        <td><%=rs1.getString(2)%></td>
       <% i=2+2*Sem1+2*Sem2+2*Sem3+2*Sem4; 
      // System.out.println("value of i:"+i);
       temp=2*Sem5;
       while(temp>0)
        {
           %>
        <td><%=rs1.getString(i+1)%></td>
        <%
        i++;
        temp--;
               }
        %>
        <td>0</td>
        <td></td>
    
    <%
       }
    %>
        </table>
                    <%
                                                  
                %>
                <%
            }
            
      } %>
        
    <%
         }
       catch(Exception e)
           {
       e.printStackTrace();
   }
    %>
    <%
    Statement st=ConnectionDemo1.getStatementObj().createStatement();
        String qry="select a.subjectid,b.Subject_Name,c.Faculty_Name from subject_faculty a,subject_database b,faculty_data c where a.subjectid=b.Code && a.facultyid=c.ID order by a.subjectid";
    ResultSet rs=st.executeQuery(qry);
    %>
    <table align="center" border="1">
        <tr>
            <td>Subject ID</td>
            <td>Subject Name</td>
            <td>Faculty Name</td>
        </tr>
       <% while(rs.next())
        {%>
        <tr>
            <td><%=rs.getString(1)%></td>
            <td><%=rs.getString(2)%></td>
            <td><%=rs.getString(3)%></td>
        </tr>
        <%}%>
    </table>
    <div align="center">
		<input type="button" value="Print" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" onclick="window.print();" />
</div>
    </body>
</html>
