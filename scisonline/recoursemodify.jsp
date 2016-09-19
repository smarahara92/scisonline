<%-- 
    Document   : recourse
    Created on : Mar 14, 2012, 12:30:17 PM
    Author     : admin
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.text.SimpleDateFormat.*"%>
<%@page import="java.io.*"%>
<%@page import="java.text.ParseException.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%--<%@include file="dbconnection.jsp"%>--%>
<%@include file ="connectionBean.jsp" %>
<!DOCTYPE html>
<html>
    <head>
            <style>
.style30 {color: red}
.style31 {color: white}
.style32 {color: green}
</style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
                                                      
        function make_blank(sid)
        {
            var stu = "s"+sid;
           
            if(document.getElementById(stu).value != "---Enter Student Id---") 
            {
                    
             } 
            else 
            { 
                document.getElementById(stu).value =""; 
            }
            var i=0;
                for(i=1; i<=10; i++)
               {
                   var stu1 = "s"+i;
                   if(i == sid)
                       ;
                   else 
                   {
                       if(document.getElementById(stu1).value =="")
                        {
                            document.getElementById(stu1).value ="---Enter Student Id---";
                        }
                   }
               }
           
            
        }
            
            function display(temp)
            {
                var x=document.getElementById("selecta"+temp).selectedIndex;
     
      
                if(document.getElementById("s"+temp).value==""||document.getElementById("s"+temp).value=="---Enter Student Id---")
                    {
                    alert("Student Id is empty");
                    document.getElementById("s"+temp).focus();
                    document.getElementById("selecta"+temp).value="none"
                }
                
                else
                  document.getElementById("selectb"+temp).removeAttribute("disabled","disabled");
        
            }
            function validId(temp)
            {
                var id=document.getElementById("s"+temp).value;
                //alert(id);
                var emailRegEx= /[0-9][0-9]+(MC|mc)+(MT|mt|MB|mb|MI|mi|MC|mc)+[0-9][0-9]/;
                
                if (id.search(emailRegEx) == -1||id.length>8) 
                   {
                   
                     alert("please enter valid StudentId");
                     var stu1 = "s"+temp;
                      document.getElementById(stu1).value ="---Enter Student Id---";
                     document.getElementById(stu1).focus();
                     
                    }
                 
            }
            function display1(temp)
            {
        var x=document.getElementById("selectb"+temp).selectedIndex;
     
                if(document.getElementById("s"+temp).value==""||document.getElementById("s"+temp).value=="---Enter Student Id---")
                    {
                    alert("Student Id is empty");
                    document.getElementById("s"+temp).focus();
                    document.getElementById("selectb"+temp).value="none"
                }
                else if(document.getElementById("selecta"+temp).value=="none")
                    {
                alert("Old Subject is not selected");
                document.getElementById("selecta"+temp).focus();
                document.getElementById("selectb"+temp).value="none";
                    }
        
        
            }
            function check()
            {
                var i=1;
                var c=10;
                while(i<=10)
                    {
                        if(document.getElementById("s"+i).value==""||document.getElementById("s"+i).value=="---Enter Student Id---")
                            c--;
                        i++;
                    }
                    if(c==0)
                        {
                            alert("Atleast one Student Id is not given");
                        
                        return false;
                        }
                    else return true;
                
            }
        </script>
    </head>
    <body bgcolor="#CCFFFF">
        <%
        
        %>
        <form action="recoursemodifylink.jsp" method="get" name="form1" onsubmit="return check();">
            <table align="center">
                <tr  bgcolor="#c2000d">
                    <td align="center" class="style31"><font size="6">Re-Course Registration</font></td>
                </tr>
            </table>
        <table align="center">
            
            <tr>
                <th>Student Id</th>
                
            </tr>
            <%int i=1;
            while(i<=10)
           {%>
            <tr>
                <td><input type="text" id="s<%=i%>" name="sid" value="---Enter Student Id---"  onclick="make_blank(<%=i%>);" onchange="validId(<%=i%>);"></td>
                
                
            </tr>
            <%
             i++;
            }
          
                       
%>
            <tr ><td colspan="3" align="center"><input type="submit" name="submit" value="submit"></td></tr>
            
        </table>
            <input type="hidden" id="studentid" name="studentid" value="gggg">
        </form>
            
    
   
</body>
</html>
