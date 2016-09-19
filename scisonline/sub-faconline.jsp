<%-- 
    Document   : sub-faconline
    Created on : Feb 21, 2012, 11:41:04 AM
    Author     : jagan
--%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page import="com.mysql.jdbc.ResultSet"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
<script language="javaScript" type="text/javascript" src="calendar.js"></script>
<link href="calendar.css" rel="stylesheet" type="text/css">
<style>
.style30 {color: #c2000d}
.style31 {color: white}
.style32 {color: green}
.heading
{
color: white;
background-color: #c2000d;
}
.border
{
background-color: #c2000d;
}
.pos_fixed
{
position:fixed;
bottom:0px;
background-color: #CCFFFF;
border-color: red;
}
</style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            
            
            function hideDiv()
            { 
                if (document.getElementById)
                { 
                    document.getElementById('div').style.visibility = 'hidden'; 
                } 
            } 
            function showDiv() { 
                if (document.getElementById) { 
                    document.getElementById('div').style.visibility = 'visible'; 
                } 
            }
            
            
            
            function dothis(temp)
            {
                var x=parseInt(document.getElementById("select1"+temp).options.selectedIndex);
                var y=parseInt(document.getElementById("select2"+temp).options.selectedIndex);
                var z=parseInt(document.getElementById("select3"+temp).options.selectedIndex);
                var m=x+y+z;
                //alert("selection is wrong"+m);
             
                if(y == x)
      document.getElementById("select2"+temp).options.selectedIndex=(0);
            
            if(z == x || z == y)
      document.getElementById("select3"+temp).options.selectedIndex=(0);
            
           
            }
            
             function display1(temp)
             {
               var x=document.getElementById("select1"+temp).selectedIndex;
               if(document.getElementById("select1"+temp).options[x].selected)
               document.getElementById("s1"+temp).options.selectedIndex=(x);
                 var e=document.getElementById("s1"+temp);
                 var str=e.options[e.selectedIndex].text;
                 //alert("The course type is:"+str);
                        if(str=="E")
                            {
                                document.getElementById("check1"+temp).disabled=true;
                            }
                            else
                               document.getElementById("check1"+temp).disabled=false;
                           
                           
                           dothis(temp);
             }
             function display2(temp)
             {
                var x=document.getElementById("select2"+temp).selectedIndex;
               if(document.getElementById("select2"+temp).options[x].selected)
               document.getElementById("s2"+temp).options.selectedIndex=(x);
                 var e=document.getElementById("s2"+temp);
                 var str=e.options[e.selectedIndex].text;
                 //alert("The course type is:"+str);
                        if(str=="E")
                            {
                                document.getElementById("check2"+temp).disabled=true;
                            }
                            else
                               document.getElementById("check2"+temp).disabled=false;
                           
                           
                           dothis(temp); 
             }
             function display3(temp)
             {
                 var x=document.getElementById("select3"+temp).selectedIndex;
               if(document.getElementById("select3"+temp).options[x].selected)
               document.getElementById("s3"+temp).options.selectedIndex=(x);
                 var e=document.getElementById("s3"+temp);
                 var str=e.options[e.selectedIndex].text;
                 //alert("The course type is:"+str);
                        if(str=="E")
                            {
                                document.getElementById("check3"+temp).disabled=true;
                            }
                            else
                               document.getElementById("check3"+temp).disabled=false;
                           
                           
                           dothis(temp);
             }
              function fun(temp)
               {
            	   document.getElementById(temp).disabled='true';
               }
        </script>
    </head>
    <body bgcolor="#CCFFFF" >
        <%
        
         Calendar now = Calendar.getInstance();
   
    System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
    int month=now.get(Calendar.MONTH)+1;
    int year=now.get(Calendar.YEAR);
    String semester="";
    if(month<=6)
     {
       semester="Winter";
     }
     else
     {
       semester="Monsoon";
     }
        
        Statement st1 = (Statement)con.createStatement();
        Statement st2 = (Statement)con.createStatement();
        Statement st3 = (Statement)con.createStatement();
        Statement st4 = (Statement)con.createStatement();
        Statement st5 = (Statement)con.createStatement();
         Statement st15 = (Statement)con.createStatement();
        ResultSet rs = (ResultSet)st1.executeQuery("select * from faculty_data order by Faculty_Name");
        ResultSet rs1 = (ResultSet)st2.executeQuery("select * from subjecttable order by Subject_Name");
        st15.executeUpdate("create table if not exists "+semester+"_subjectfaculty(subjectid varchar(20),facultyid1 varchar(20),facultyid2 varchar(20),primary key(subjectId))");
         ResultSet rs3,rs4,rs5;
        
        %>
        <table width="100%">
        	<tr>
                <th colspan="5" class="style30" align="center"><font size="6">Subject-Faculty Registration</font></th>
            </tr>
        </table>
        <form action="subjectFaculty.jsp" method="post">
            
             <h4 align="center">Please click on the check box if the subject is also offered as an elective.</h4>
  
            
            
            
            <div id="div">    
                <h4 align="center">Please click on the check box if the subject is also offered as an elective.</h4>
        <table align="center" border="1">
            <tr>
                <td class="heading" align="center">S.no</td>
                <td class="heading" align="center">Faculty Name</td>
                <td class="heading" align="center">Subject 1</td>
                
                <td class="heading" align="center">Subject 2</td>
               
                <td class="heading" align="center">Subject 3</td>
               
                
            </tr>
            <%int i=1;
           
            while(rs.next())
       {  rs3= (ResultSet)st3.executeQuery("select Code,Subject_Name,type from subjecttable as a,"+semester+"_subjectfaculty as b where a.Code=b.subjectid and(b.facultyid1='"+rs.getString(1)+"' or b.facultyid2='"+rs.getString(1)+"')");
          rs4= (ResultSet)st4.executeQuery("select Code,Subject_Name,type from subjecttable as a,"+semester+"_subjectfaculty as b where a.Code=b.subjectid and(b.facultyid1='"+rs.getString(1)+"' or b.facultyid2='"+rs.getString(1)+"')"); 
           //st1.executeUpdate("drop table if exists elective_table");
          Statement st20=(Statement)con.createStatement();
       st20.executeUpdate("create table if not exists elective_table(course_name	varchar(50),MCA_I int(11),MCA_II int(11),MCA_III int(11),MCA_IV int(11),MCA_V int(11),MCA_VI int(11),MTech_CS_I	int(11),MTech_CS_II int(11),MTech_CS_III int(11),MTech_CS_IV int(11),MTech_AI_I	int(11),MTech_AI_II int(11),MTech_AI_III int(11),MTech_AI_IV int(11),MTech_IT_I int(11),MTech_IT_II int(11),MTech_IT_III int(11),MTech_IT_IV int(11),pre_req_1 varchar(45),pre_req_grade1 varchar(2),pre_req_2 varchar(45),pre_req_grade2 varchar(2),primary key(course_name))");
              
          rs5= (ResultSet)st5.executeQuery("select * from elective_table");
          int force=0;
            if(rs3.next())
                  force=1;
          int force1=0;
            if(rs4.next())
                  force1=1;
           %>
            
            <tr>
                <td class="style30"><b><%=i%></b></td>
                <td><b><input type="text" name="faculty" value="<%=rs.getString(2)%>" readonly="readonly"></b></td>
                <td>
                    <select name="select1<%=Integer.toString(i)%>" id="select1<%=Integer.toString(i)%>" onchange="display1(<%=Integer.toString(i)%>);" style="width:200px;">
                        <option value="none">none</option>
                        <%
                         while(rs1.next())
                                                       {
                                  if(force==1&&rs1.getString(1).equals(rs3.getString(1))==true){
                                        %> <option value="<%=rs1.getString(1)%>" selected><%=rs1.getString(2)%></option><%}
                                    else{
                                       %> 
                                       <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option><%}
                                %>
                            
                                
                        <%}%>
                    </select>
                     <% rs1.beforeFirst();
                     %>
                     <select name="s1<%=Integer.toString(i)%>" id="s1<%=Integer.toString(i)%>"   style="width:100px;display:none;">
                       <option value="none">none</option>
                        <%while(rs1.next())
                          {
                        if(force1==1&&rs1.getString(1).equals(rs4.getString(1))==true){ 
                            System.out.println(rs4.getString(1)+"  "+rs1.getString(2)+"  "+rs4.getString(3));                              
                       %> <option value="<%=rs4.getString(3)%>" selected><%=rs4.getString(3)%></option>
                      
                        <%}
                        else
                        {
                            %> 
                            <option value="<%=rs1.getString(4)%>"><%=rs1.getString(4)%></option><%}
                            %> 
                        
                        <%}
                     %>
                    </select>
                     <%
                      if(force==1&&rs4.getString(3).equals("C")==true)
                        {
                         int find=0;
                         while(rs5.next())
                              if(rs5.getString(1).equals(rs4.getString(1)))
                                    find=1;
                        if(find==1){  
                         %> <input type="checkbox" name="check1<%=Integer.toString(i)%>" id="check1<%=Integer.toString(i)%>" value="EC" checked="true"><% 
                            }
                         else
                             {  
                         %> <input type="checkbox" name="check1<%=Integer.toString(i)%>" id="check1<%=Integer.toString(i)%>" value="EC"><% 
                            }
                        }
                      else if(force==1&&rs4.getString(3).equals("E")==true)
                        {
                         %> <input type="checkbox" name="check1<%=Integer.toString(i)%>" id="check1<%=Integer.toString(i)%>" value="EC" disabled="true"><% 
                        }
                      else
                                                  {
                     %>
                        <input type="checkbox" name="check1<%=Integer.toString(i)%>" id="check1<%=Integer.toString(i)%>" value="EC">
                      <%}%>  
                </td>
               
                <% rs1.beforeFirst();
                 force=0;
                 if(rs3.next())
                  force=1;
                 force1=0;
            if(rs4.next())
                  force1=1;
                 %>
                <td>
                    <select name="select2<%=Integer.toString(i)%>" id="select2<%=Integer.toString(i)%>" onchange="display2(<%=Integer.toString(i)%>);" style="width:200px;">
                        <option value="none">none</option>
                        <%while(rs1.next())
                                                       {
                        if(force==1&&rs1.getString(1).equals(rs3.getString(1))==true){
                                        %> <option value="<%=rs1.getString(1)%>" selected><%=rs1.getString(2)%></option><%}
                                    else{
                                       %> 
                                       <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option><%}
                                %>
                        <%}%>
                    </select>
                    <% rs1.beforeFirst();%>
                     <select name="s2<%=Integer.toString(i)%>" id="s2<%=Integer.toString(i)%>"  style="width:100px;display:none;">
                        <option value="none">none</option>
                        <%while(rs1.next())
                          {
                        if(force1==1&&rs1.getString(1).equals(rs4.getString(1))==true){ 
                          System.out.println(rs4.getString(1)+"  "+rs1.getString(2)+"  "+rs4.getString(3));                              
                        %> <option value="<%=rs4.getString(3)%>" selected><%=rs4.getString(3)%></option>
                      
                        <%}
                        else
                        {
                            %> 
                             <option value="<%=rs1.getString(4)%>"><%=rs1.getString(4)%></option><%}
                            %> 
                        
                        <%}
                     %>
                    </select>
                    <%
                      rs5.beforeFirst();
                      if(force==1&&rs4.getString(3).equals("C")==true)
                        {
                         int find=0;
                         while(rs5.next())
                              if(rs5.getString(1).equals(rs4.getString(1)))
                                    find=1;
                        if(find==1){  
                         %> <input type="checkbox" name="check2<%=Integer.toString(i)%>" id="check1<%=Integer.toString(i)%>" value="EC" checked="true"><% 
                            }
                         else
                             {  
                         %> <input type="checkbox" name="check2<%=Integer.toString(i)%>" id="check1<%=Integer.toString(i)%>" value="EC"><% 
                            }
                        }
                    
                       else if(force==1&&rs4.getString(3).equals("E")==true)
                        {
                         %>
                         <input type="checkbox" name="check2<%=Integer.toString(i)%>" id="check2<%=Integer.toString(i)%>" value="EC" disabled="true"><%
                        }                       
                          else
                          {
                          %>
                         <input type="checkbox" name="check2<%=Integer.toString(i)%>" id="check2<%=Integer.toString(i)%>" value="EC"><%
                          }
                     %>
                         </td>   
               
                <% rs1.beforeFirst();
                force=0;
                 if(rs3.next())
                  force=1;
               force1=0;
            if(rs4.next())
                  force1=1;
                %>
               <td>
                   <select name="select3<%=Integer.toString(i)%>" id="select3<%=Integer.toString(i)%>" onchange="display3(<%=Integer.toString(i)%>);" style="width:200px;">
                       <option value="none">none</option>
                        <%while(rs1.next())
                                                       {
                        if(force==1&&rs1.getString(1).equals(rs3.getString(1))==true){
                                        %> <option value="<%=rs1.getString(1)%>" selected><%=rs1.getString(2)%></option><%}
                                    else{
                                       %> 
                                       <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option><%}
                                %>
                        <%}%>
                   </select>
                   <% rs1.beforeFirst();%>
                     <select name="s3<%=Integer.toString(i)%>" id="s3<%=Integer.toString(i)%>" style="width:100px;display:none;">
                      <option value="none">none</option>
                        <%while(rs1.next())
                          {
                        if(force1==1&&rs1.getString(1).equals(rs4.getString(1))==true){    
                        %> <option value="<%=rs4.getString(3)%>" selected><%=rs4.getString(3)%></option>
                      
                        <%}
                        else
                        {
                            %> 
                             <option value="<%=rs1.getString(4)%>"><%=rs1.getString(4)%></option><%}
                            %> 
                        
                        <%}
                     %>
                    </select>
                    <%
                       
                     rs5.beforeFirst();
                      if(force==1&&rs4.getString(3).equals("C")==true)
                        {
                         int find=0;
                         while(rs5.next())
                              if(rs5.getString(1).equals(rs4.getString(1)))
                                    find=1;
                        if(find==1){  
                         %> <input type="checkbox" name="check3<%=Integer.toString(i)%>" id="check1<%=Integer.toString(i)%>" value="EC" checked="true"><% 
                            }
                         else
                             {  
                         %> <input type="checkbox" name="check3<%=Integer.toString(i)%>" id="check1<%=Integer.toString(i)%>" value="EC"><% 
                            }
                        }
                     
                      else if(force==1&&rs4.getString(3).equals("E")==true)
                        {
                         %>
                         <input type="checkbox" name="check3<%=Integer.toString(i)%>" id="check3<%=Integer.toString(i)%>" value="EC" disabled="true"><%
                        }
                       else
                       {
                       %>
                         <input type="checkbox" name="check3<%=Integer.toString(i)%>" id="check3<%=Integer.toString(i)%>" value="EC"><%
                       }   %>
                         </td>
               
            </tr>
            <% rs1.beforeFirst();%>
            <%i++;
                       }
con.close();
%>
        </table>
            </div>
        
    		<table>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
			
			<table width="100%" class="pos_fixed">
				<tr>
					<td align="center" class="border"><input type="submit" name="submit" value="SUBMIT" ></td>
				</tr>
			</table>
    </form>
    </body>
</html>
