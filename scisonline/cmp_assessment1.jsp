<%-- 
    Document   : cmp_assessment1
    Created on : Jun 11, 2013, 11:28:10 AM
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
        <script language="javascript">
            function display1()
            {
      
                var x=document.getElementById("mySelect1").selectedIndex;
     
                document.getElementById("mySelect2").selectedIndex=x;
               
                document.form1.submit();
  

            }
        </script>
    </head>
    <body onload="document.forms.form1.submit();">
        <%
            Calendar now = Calendar.getInstance();
            System.out.println("Current date : " + (now.get(Calendar.MONTH)+ 1)
                    + "-"
                    + now.get(Calendar.DATE)
                    + "-"
                    + now.get(Calendar.YEAR));
            int month = now.get(Calendar.MONTH) + 1;
            int cyear = now.get(Calendar.YEAR);
            if (month >= 1 && month <= 6) {
                cyear = cyear - 1;
            }
            Statement st1 = con2.createStatement();
            Statement st2 = con2.createStatement();
            Statement st3 = con2.createStatement();
            Statement st6 = con2.createStatement();
            /*
             *code for taking latest curriculum
             */

            int curriculumYear = 0, latestYear = 0;//here latestYear output of this code, that is the latest curriculum year
            Statement st10_cur = (Statement) con2.createStatement();

            ResultSet rs10_cur = st10_cur.executeQuery("select * from  PhD_curriculumversions order by Year desc");
            while (rs10_cur.next()) {
                curriculumYear = rs10_cur.getInt(1);

                if (curriculumYear <= cyear) {

                    latestYear = curriculumYear;
                    System.out.println(latestYear);
                    break;
                }
            }
            // done   code for taking latest curriculum


            // get the new curriculum.
            ResultSet rs3 = st3.executeQuery("select * from PhD_" + latestYear + "_currrefer ");
            //ResultSet rs3=st3.executeQuery("select * from PhD_curriculum offset limit 1");


            rs3.next();
            int noofelectives = Integer.parseInt(rs3.getString(2));
            int noofcores = Integer.parseInt(rs3.getString(1));
            ResultSet rs1 = st1.executeQuery("select * from PhD_electives");
            ResultSet rs2 = st2.executeQuery("select * from PhD_" + latestYear + "_curriculum");


        %>  <form name="form1" id="form1" action="cmp_assessment2.jsp" target="staffaction" method="POST">
            <select align="left" style="width:175px" name="subid" id="mySelect1" onchange="display1()"> 
                                    <option value="Select"><%="Select"%></option>

                <%
                    while (rs2.next()) {
                %><option value="<%=rs2.getString(1)%>"><%=rs2.getString(2)%></option><%
                    }
                    
                   
                    while (rs1.next()) {
                %><option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option><%
                    }

                %>
            </select>
            <select align="left"  name="subname" style="display:none;" id="mySelect2"> 
                <%
                    rs2.beforeFirst();
                    rs1.beforeFirst();
                    while (rs2.next()) {
                %><option value="<%=rs2.getString(2)%>"><%=rs2.getString(2)%></option><%
                    }
                    while (rs1.next()) {
                %><option value="<%=rs1.getString(2)%>"><%=rs1.getString(2)%></option><%
                    }
                    try{
                        st1.close();
                        st2.close();
                        st3.close();
                        st10_cur.close();
                        st6.close();
                        rs1.close();
                        rs2.close();
                        rs3.close();
                        rs10_cur.close();
                    }
                    catch(Exception e){
                        System.out.println(e);
                    }
                    finally{
                        con.close();
                        con2.close();
                    }
                %>
            </select>
           <!--  <input type="Submit" value="Go" onclick=""> -->
        </form>     
    </body>
</html>
