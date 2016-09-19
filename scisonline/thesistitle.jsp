<%-- 
    Document   : thesistitle
    Created on : Jun 6, 2013, 11:32:05 AM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .style30{width:150px;color:#000000}
            .style31 {color: white}
        </style>
        <script type="text/javascript">
            
            function disableEnterKey(e)
            {
                var key;
	 
                if(window.event)
	          key = window.event.keyCode;     //IE
                else
                  key = e.which;     //firefox
	 	
		//alert("helloi");
                if(key === 13)
	          return false;
                else
	          return true;
            }
    
    
            function find(a)
            {
                var i=1,j=0;
                for(i=1;i<=a;i++)
                {
                    var x=document.getElementById("area"+i).value;
                    x=x.replace(/^\s+|\s+$/g,'');
                    document.getElementById("area"+i).value=x;
                    if(x=="")
                    {
                        j++;
                    }
                    else
                    {
                
                    }
                }
                if(j==a)
                {
                    alert("enter atleast one student datails");
                    return false;
                }
            }
        </script>  
    </head>
    <body>
        <table align="center" border="1">
            <tr  bgcolor="#c2000d">
                <td align="center" class="style31"><font size="6">Ph.D. Thesis Titles</font></td>
            </tr>
        </table>
        </br>
        </br>


        <%
        try {
            Calendar now = Calendar.getInstance();
            System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                    + "-"
                    + now.get(Calendar.DATE)
                    + "-"
                    + now.get(Calendar.YEAR));
            int month = now.get(Calendar.MONTH) + 1;
            int cyear = now.get(Calendar.YEAR);
            if (month >= 1 && month <= 6) {
                cyear--;
            }

            Statement st1 = con2.createStatement();
            Statement st3 = con2.createStatement();
            Statement st_snam = con2.createStatement();

            Statement st2 = con.createStatement();



            String user = (String) session.getAttribute("user");
            // out.println(user);
            ResultSet rs1 = null;
            ResultSet rs3 = null;
            if (user.equals("staff")) {
                rs1 = st1.executeQuery("select * from PhD_" + cyear + "");
                rs3 = st3.executeQuery("select count(*) from PhD_" + cyear + "");
            } else {
                rs1 = st1.executeQuery("select * from PhD_" + cyear + " where supervisor1='" + user + "' or supervisor2='" + user + "' or supervisor3='" + user + "'");
                rs3 = st3.executeQuery("select count(*) from PhD_" + cyear + " where supervisor1='" + user + "' or supervisor2='" + user + "' or supervisor3='" + user + "'");
            }
            int totalstudents = 0;
            if (rs3.next() == true) {
                totalstudents = Integer.parseInt(rs3.getString(1));
            }

        %>
        <form name="frm" action="thesistitle1.jsp"  method="POST" onsubmit="return find('<%=totalstudents%>')">
            <input type="hidden" name="totalstudents" value="<%=totalstudents%>">
            <table border="1" cellspacing="2" cellpadding="1" align="center">

                <tr>
                    <th>Student ID</th>
                    <th>Student Name</th>
                    <th>Thesis Title</th>

                </tr>  


                <%
                    int i = 1;
                    while (rs1.next()) {
                        ResultSet rs_sname = st_snam.executeQuery("select * from  PhD_Student_info_" + cyear + " where StudentId='" + rs1.getString(1) + "'");
                        rs_sname.next();

                %>
                <tr>
                    <td><input type="text" id="id<%=i%>" name="id" style="width:100px"value="<%=rs1.getString(1)%>" readonly onKeyPress="return disableEnterKey(event)"></td>
                    <td align="center"><input type="text"  id="name<%=i%>" name="name" style="width:200px"value="<%=rs_sname.getString(2)%>" readonly  onKeyPress="return disableEnterKey(event)"></td>
                    <%if (rs1.getString("thesistitle") != null) {%><td align="center"><input type="text"  id="area<%=i%>" name="area" style="width:300px" value="<%=rs1.getString("thesistitle")%>"onKeyPress="return disableEnterKey(event)"></td><%} else {%><td align="center"><input type="text"  id="area<%=i%>" name="area" style="width:300px" value="" onKeyPress="return disableEnterKey(event)"></td><%}

                    %>
                </tr>
                <%
                        i++;
                        rs_sname = null;
                    }
                    st1 = null;
                    st2 = null;
                    st3 = null;
                    st_snam = null;
                    rs1 = null;
                    rs3 = null;
            }
            catch(Exception e){
                System.out.println(e);
            }
            finally{
                con.close();
             //   con1.close();
                con2.close();
            }

                %>
            </table>
            </br>

            <center> <input type="submit" name="submit" value="submit"></center>
        </form>


    </body>
</html>
