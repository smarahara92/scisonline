<%-- 
    Document   : assessmentcheckboxes
    Created on : May 6, 2013, 4:07:07 PM
    Author     : root
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
          <script type="text/javascript">
            
            
            function checked1(temp,a,b)
              {
               //alert(a);
               if(temp==1)
                {
                   window.document.forms["frm"].action="SubjectwiseMarks.jsp?subjectname="+a+"&subjectid="+b+"";
                   window.document.forms["frm"].submit();
                }
                else if(temp==2)
                {
                    window.document.forms["frm"].action="SubjectwiseMarks1.jsp?subjectname="+a+"&subjectid="+b+"";
                     window.document.forms["frm"].submit();
                }
                else if(temp==3)
                {
                    window.document.forms["frm"].action="SubjectwiseMarks3.jsp?subjectname="+a+"&subjectid="+b+"";
                     window.document.forms["frm"].submit();
                }
              }
        </script>
    </head>
    <body onload="document.forms.frm.submit();">
      
      <%   String sname=request.getParameter("subjectname");
        String subjectid=request.getParameter("subjectid");
        System.out.println(sname+subjectid);
     %>
      <form name="frm" action="SubjectwiseMarks.jsp?subjectname=<%=sname%>&subjectid=<%=subjectid%>" target="facultyaction1" method="POST">
           <center>
   <input type="radio" name="selectstream" value="MTech_CS" checked onClick="checked1(1,'<%=sname%>','<%=subjectid%>');"><b>All&nbsp&nbsp
   <input type="radio" name="selectstream" value="MTech_AI" onClick="checked1(2,'<%=sname%>','<%=subjectid%>');">Internal only&nbsp&nbsp
   <input type="radio" name="selectstream" value="MTech_IT" onClick="checked1(3,'<%=sname%>','<%=subjectid%>');">Grade&nbsp&nbsp
   </center>
       </form>
    </body>
   
</html>
