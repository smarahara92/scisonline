<%-- 
    Document   : status_array
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.*"%>

<% 
Map<String, String> map = new HashMap<String, String>();

map.put("NR", "New");
map.put("A", "Allocated");

map.put("R", "Registered");
map.put("C", "Cancellation");
map.put("L", "Left");
map.put("ER", "Extension");
map.put("RR", "Re-Registered");
map.put("DR", "De-Registered");
map.put("S", "Synopsis Submitted");
map.put("T", "Thesis Submitted");
map.put("V", "Viva Over");
map.put("G", "Degree Awarded");


%>