<%-- 
    Document   : query_sub_taught_by_a_faculty
    Created on : 18 Feb, 2015, 12:58:58 PM
    Author     : nwlab
--%>

<%@page  import="java.sql.ResultSet"%>
<%@page  import="java.util.Hashtable"%>
<%@include file="programmeRetrieveBeans.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/query_display_style.css">
    </head>
    <body>
<%
        String facId = request.getParameter("fac_id");
        String year1str = request.getParameter("year1");
        String year2str = request.getParameter("year2");
        //out.println(facId + " " + year1str + " " + year2str);
        
        if(facId.equals("")) {
            return;
        }
        
        int year1, year2;
        try {
            year1 = Integer.parseInt(year1str);
            year2 = Integer.parseInt(year2str);
        } catch (NumberFormatException nfe) {
            System.out.println(nfe);
            return;
        }
        
        String title = "List of courses taught by "+"<span style=\"color:blue;\">"+scis.facultyName(facId)+"</span>"+" during "+"<span style=\"color:blue;\">"+year1+" - "+year2+"</span>";
        String msg_emp = "";
        if(year1 != year2) {
            msg_emp = "No courses are allocated during "+"<span style=\"color:blue;\">"+year1+" - "+year2+"</span>";
        } else {
            msg_emp = "No courses are allocated in "+"<span style=\"color:blue;\">"+year1+"</span>";
        }
        
        Hashtable sem = new Hashtable();
        Hashtable sub1 = new Hashtable();
        Hashtable sub2 = new Hashtable();
        Hashtable sub3 = new Hashtable();
        int i = 0;
        //*********************************************
        
        
        
        String sess = null;
        int k = 1; //serial number
        for(int year = year1; year <= year2; year++) {
            int sessionStatus = 0;
            while(sessionStatus < 2) {
                if(sessionStatus == 0) {
                    sess = "Winter";
                } else if(sessionStatus == 1) {
                    sess = "Monsoon";
                }
                int j = 0;
                String[] sub = new String[3];
                try {
                    ResultSet rs = scis.executeQuery("SELECT subjectid FROM subject_faculty_" + sess + "_" + year + " WHERE facultyid1 = '" + facId + "' OR facultyid2='" + facId + "'");
                    
                    sub[0] = null;
                    sub[1] = null;
                    sub[2] = null;
                
                    j = 0;
                    while(rs.next()) {
                        sub[j++] = rs.getString(1);
                        out.println();
                    }
                } catch(Exception e) {

                }
                if(j > 0) {
                    sem.put(i, sess + "-" + year);
                    sub1.put(i, scis.subjectName(sub[0]));
                    if(sub[1] == null)  {
                        sub2.put(i,"");
                    } else {
                        sub2.put(i,scis.subjectName(sub[1]));
                    }
                    if(sub[2] == null)  {
                        sub3.put(i++,"");
                    } else {
                        sub3.put(i++,scis.subjectName(sub[2]));
                    }
                }
                ++sessionStatus;
            }
        }
     // **************************************
        if(i > 0) {
%>
            <h3 style="color:#c2000d" align="center"><%=title%></h3>
            <table align="center" border="1" class = "maintable" width="100%">
                <col width="10%">
                <col width="15%">
                <col width="25%">
                <col width="25%">
                <col width="25%">
                <tr>
                    <th class="heading" align="center">S.no</th>
                    <th class="heading" align="center">Session</th>
                    <th class="heading" align="center">Sub 1</th>
                    <th class="heading" align="center">Sub 2</th>
                    <th class="heading" align="center">Sub 3</th>
                </tr>
<%          
                for(int z = 0; z < i; z++) {
%>
                    <tr>
                        <th class="style30" ><%=k++%></th>
                        <td class = "cellpad"><%=sem.get(z)%></td>
                        <td class = "cellpad"><%=sub1.get(z)%></td>
                        <td class = "cellpad"><%=sub2.get(z)%></td>
                        <td class = "cellpad"><%=sub3.get(z)%></td>
                    </tr>
<%                        
                }
%>
            </table>&nbsp;&nbsp;
<%  
        } else {
%>
            <h3 style="color:#c2000d" align="center"><%=msg_emp%></h3>
<%
        }
        scis.close();
%>        
    </body>
</html>
