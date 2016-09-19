<%-- 
    Document   : dbconnection
    Created on : Apr 10, 2012, 10:38:51 AM
    Author     : admin
--%>
    <%@page import="java.lang.Object"%>
<%@page import="java.sql.*"%>
<%@page import="org.apache.commons.dbutils.DbUtils"%>

<%
    Connection con = null;
    Connection con1 = null;
    Connection con2 = null;
    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        //System.out.println("driver connected");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
        con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_assessment", "root", "");
        con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/PhD", "root", "");
//        DatabaseMetaData dbMetaData = con.getMetaData();
//        DatabaseMetaData dbMetaData1 = con1.getMetaData();
//        DatabaseMetaData dbMetaData2 = con2.getMetaData();
//        if (dbMetaData.supportsTransactionIsolationLevel(Connection.TRANSACTION_SERIALIZABLE)) {
//           
//            con.setTransactionIsolation(2);
//        }
//        if (dbMetaData1.supportsTransactionIsolationLevel(Connection.TRANSACTION_SERIALIZABLE)) {
//            
//            con1.setTransactionIsolation(2);
//        }
//        if (dbMetaData2.supportsTransactionIsolationLevel(Connection.TRANSACTION_SERIALIZABLE)) {
//           
//            con2.setTransactionIsolation(2);
//        }
    } catch (Exception e) {
        out.println(e);
    }

%>