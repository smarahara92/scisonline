<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page import="com.mysql.jdbc.ResultSet"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Assign Electives to Streams</title>
        <style>
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
        </style>
        <style type="text/css">
            .pos_fixed
            {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
            .head_pos
            {
                position:fixed;
                top:0px;
                background-color: #CCFFFF;
            }
            .menu_pos
            {
                position:fixed;
                top:105px;
                background-color: #CCFFFF;
            }
            .table_pos
            {
                top:200px;
            }
            .border
            {
                background-color: #c2000d;
            }
            .fix
            {
                position:fixed;
                background-color: #c2000d;
            }
        </style>
    </head>
    <body bgcolor="#CCFFFF">
        <%
            Calendar cal = Calendar.getInstance();
            //int year = cal.get(Calendar.YEAR);
            //int month = cal.get(Calendar.MONTH);
            //   month=month+1;              // month has to be removed, since we have session, year.
            // System.out.println(month);
            int k = 1;
            String given_session = request.getParameter("given_session");
            String given_year = request.getParameter("given_year");
            String count_courses = request.getParameter("count_courses");
            int count_courses_i = Integer.parseInt(count_courses);
            int a[] = new int[count_courses_i];
            String[] courses = (String[]) session.getAttribute("courses");
            //String[] x = 
            String[] input = new String[9];
            String query1 = "select course_name from " + given_year + "_" + given_session + "_elective";
            ResultSet rs = (ResultSet) ConnectionDemo.getStatementObj().executeQuery(query1);
            while (rs.next()) {
                System.out.println("ele :" + rs.getString(1));
                System.out.println("count :" + count_courses_i);
            
                    //System.out.println(month);
                    for (int j = 0; j < count_courses_i; j++) {
                        System.out.println( j +" df " + k + " "+ "input"+ j + Integer.toString(k)+ "   " +  request.getParameter("input" + j + Integer.toString(k)));
                        
                        String limi = request.getParameter("input" + j + Integer.toString(k));
                        if(limi== null || limi.contains("null") || limi.equalsIgnoreCase("") )   
                                                  { limi="0";}
                        System.out.println(courses[j] + "limit :" + a[j] + " "+ limi);
                       a[j] = Integer.parseInt(limi);
                        
                        ConnectionDemo.getStatementObj().executeUpdate("update " + given_year + "_" + given_session + "_elective set " + courses[j] + "=" + a[j] + " where course_name='" + rs.getString(1) + "'");

                    }


                    //System.out.println("laxman"+request.getParameter("input1"+Integer.toString(k)));
                    //int a1=Integer.parseInt(request.getParameter("input1"+Integer.toString(k)));
                    //int a2=Integer.parseInt(request.getParameter("input2"+Integer.toString(k)));	
                    //int a3=Integer.parseInt(request.getParameter("input3"+Integer.toString(k)));	
                    //int a4=Integer.parseInt(request.getParameter("input4"+Integer.toString(k)));	
                    //int a5=Integer.parseInt(request.getParameter("input5"+Integer.toString(k)));	
                    int preq = count_courses_i*100;
                    String a6 = (String) request.getParameter("input" + preq + Integer.toString(k));
                    preq++;
                    String a7 = (String) request.getParameter("input" + preq + Integer.toString(k));
                    preq++;
                    String a8 = (String) request.getParameter("input" + preq + Integer.toString(k));
                    preq++;
                    String a9 = (String) request.getParameter("input" + preq + Integer.toString(k));
                   ConnectionDemo.getStatementObj().executeUpdate("update " + given_year + "_" + given_session + "_elective set  pre_req_1='" + a6 + "', pre_req_grade1='" + a7 + "', pre_req_2='" + a8 + "', pre_req_grade2='" + a9 + "' where course_name='" + rs.getString(1) + "'");
                   
                    
                    System.out.println("preq here :"+a6+"gde "+a7+", "+ a8+"gde " +a9);

                    //if(given_session.equalsIgnoreCase("Winter"))
                    //	ConnectionDemo.getStatementObj().executeUpdate("update "+ given_year+"_"+given_session +"_elective set MTech_AI_II="+a1+", MTech_CS_II="+a2+", MTech_IT_II="+a3+", MCA_II="+a4+", MCA_IV="+a5+", pre_req_1='"+a6+"', pre_req_grade1='"+a7+"', pre_req_2='"+a8+"', pre_req_grade2='"+a9+"' where course_name='"+rs.getString(1)+"'");
                    //  			else if(given_session.equalsIgnoreCase("Monsoon"))
                    //	ConnectionDemo.getStatementObj().executeUpdate("update "+ given_year+"_"+given_session +"_elective set MTech_AI_I="+a1+", MTech_CS_I="+a2+", MTech_IT_I="+a3+", MCA_III="+a4+", MCA_V="+a5+", pre_req_1='"+a6+"', pre_req_grade1='"+a7+"', pre_req_2='"+a8+"', pre_req_grade2='"+a9+"' where course_name='"+rs.getString(1)+"'");
                    k++;
                                   }

                    // mark for this session, year electives are given
                 try {              
 ConnectionDemo.getStatementObj().executeUpdate("insert into  session_course_registration (session , year, limits) values('" +given_session + "','" + given_year + "' , 'yes'  )");

                } catch (Exception e) {

                    System.out.println(e);
                }
            
            


        %>
        <table>
            <tr>
                <td class="style30"><center><h2>Elective to Streams registration done.</h2></center></td>
            </tr>
        </table>
    </body>
</html>