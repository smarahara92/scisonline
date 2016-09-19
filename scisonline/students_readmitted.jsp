<%-- 
    Document   : readmin
    Created on : Mar 14, 2012, 9:58:10 AM
    Author     : admin
--%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="dbconnection.jsp" %>
<%@page import="java.util.*"%>
<%@page import="java.util.Calendar"%>
<!DOCTYPE html>
<html>
    <head>
   
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
          
    @media print {
       
        .noPrint
        {
            display:none;
        }
    }
    </style>
            <style>
.style30{width:150px;color:#000000}
.style31 {color: white}
</style>
        <script>
          
            
           
        </script>
    </head>
    <body bgcolor="#CCFFFF">
        
            <center>
                <center><b>University of Hyderabad</b></center>
        <center><b>School of Computer and Information Sciences</b></center>
        <center><b>List of students who have already taken Readmission</b></center>
                </br>
                </br>
            <%
             HashMap hm = new HashMap(); 
    HashMap hm1 = new HashMap(); 
             Calendar now = Calendar.getInstance();
           System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
    int month=now.get(Calendar.MONTH)+1;
    int cyear=now.get(Calendar.YEAR);
    String semester="";
    String year1="",year2="",year3="",syear="";
    Statement st1=con.createStatement();
    Statement st2=con.createStatement();
    Statement st3=con.createStatement();
     Statement st4=con.createStatement();
    
    if(month<=6)
          {
           semester="Winter";
           }
    else
         { 
          semester="Monsoon";
         }
    
     if(semester.equals("Moonson"))
                 {
                    year1=Integer.toString(cyear);
                    year2=Integer.toString(cyear-1);  
                    year3=Integer.toString(cyear-2);  
                 }
               else
               {
                 year1=Integer.toString(cyear-1);
                 year2=Integer.toString(cyear-2);  
                  year3=Integer.toString(cyear-3);  
               }
    %> <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
        <tr>
           
            <th>Student ID</th>
            <th>Student Name</th>
            <th>Year</th>
          </tr><%
      int j=0;
      int studentsem=0;
            while(j<3)
            {
            
            ResultSet rs1=null;
            if(j==0)
             {
             rs1=st1.executeQuery("select * from MCA_"+year1+"");
             if(semester.equals("Moonson"))
                 studentsem=2;
             else
                 studentsem=2;
             syear=year1;
             }
            else if(j==1)
             {
             rs1=st1.executeQuery("select * from MCA_"+year2+"");
             if(semester.equals("Moonson"))
                 studentsem=3;
             else
                 studentsem=4;
             syear=year2;
             }
            else if(j==2)
             {
             rs1=st1.executeQuery("select * from MCA_"+year3+"");
             if(semester.equals("Moonson"))
                 studentsem=5;
             else
                 studentsem=6;
             syear=year3;
             }
         
            while(rs1.next())
             {
               
            
            String sid=rs1.getString(1);
                 sid=sid.replace(" ","");
                 if(sid.substring(0,2).equals(syear.substring(2))!=true)
                   {
                    %>
                    <tr><th><%=rs1.getString(1)%></th>
                    <th><%=rs1.getString(2)%></th>
                    <th><%=syear%></th></tr>
                    <%
                   }
           
                 
             
             } 
          j++;}      
      
      
      
      
      //*************************************************************************************************************
         int k=0;
         String stream="";
         while(k<3)
         {  
            if(k==0)
               stream="MTech_CS";   
            else if(k==1)
               stream="MTech_AI"; 
            else if(k==2)
               stream="MTech_IT";                                                                 
            j=0;
            while(j<2)
            {
            
            ResultSet rs1=null;
            if(j==0)
             {
             rs1=st1.executeQuery("select * from "+stream+"_"+year1+"");
             if(semester.equals("Moonson"))
                 studentsem=2;
             else
                 studentsem=2;
             syear=year1;
             }
            else if(j==1)
             {
             rs1=st1.executeQuery("select * from "+stream+"_"+year2+"");
             if(semester.equals("Moonson"))
                 studentsem=3;
             else
                 studentsem=3;
             syear=year2;
             }
             
            while(rs1.next())
             {
                 String sid=rs1.getString(1);
                 sid=sid.replace(" ","");
                 if(sid.substring(0,2).equals(syear.substring(2))!=true)
                   {
                   %>
                   <tr>
                    <th><%=rs1.getString(1)%></th>
                    <th><%=rs1.getString(2)%></th>
                    <th><%=syear%></th></tr>
                    <%
                   }
             } 
          j++;}      
      
      
       k++;}
      
      
      //*************************************************************************************************************
         Set set = hm.entrySet();
// Get an iterator
Iterator i = set.iterator();
// Display elements
while(i.hasNext()) 
 {
    Map.Entry me = (Map.Entry)i.next(); 
   %> <tr>
                 <td><%=me.getKey()%></td>
            <td><%=me.getValue()%></td>
            <td><%=hm1.get(me.getKey())%></td>
              </tr><%
}     
            %>
            
    </table>
    </br>
    </br>
   <table align="center" cellspacing="20"><tr><td><div align="center">
    <input type="button" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
</div>
        </td>
   </table>
            </center>
       
    </body>
</html>
