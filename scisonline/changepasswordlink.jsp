<%-- 
    Document   : changepasswordlink
    Created on : Jan 17, 2013, 2:13:50 PM
    Author     : root
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8" 
        import="java.util.*,javax.naming.*,javax.naming.directory.*,javax.naming.ldap.*, java.sql.*" %>
<%@include file="conf.jsp" %>
<%@page import="java.io.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
         DirContext ldapContext;
        String msg="";
           String user =(String)session.getAttribute("user");
           //System.out.println(user);
        String password = request.getParameter("oldpassword");
        String newpassword=request.getParameter("newpassword");
        String repassword=request.getParameter("repassword");
           String filter = "(|(uid=" + user + ")" + "(mail=" + user + "@*))";
        String cliEquiv = "<tt>ldapsearch -x -h " + server + " -p " +
                port + " -b " + basedn + " \"" + filter + "\"</tt></p>";
        %>
    <!--    <p>Equivalent command line:<br /><%= cliEquiv%><hr />-->
        <%
        // Connect to the LDAP server.
        Hashtable env = new Hashtable(11);
        env.put(Context.INITIAL_CONTEXT_FACTORY,"com.sun.jndi.ldap.LdapCtxFactory");
        env.put(Context.PROVIDER_URL, "ldap://" + server + ":" + port + "/");

        // Search and retrieve DN.
        try {
            LdapContext ldap = new InitialLdapContext(env, null);
            NamingEnumeration results = ldap.search(basedn, filter, null);
            String binddn = "None";
            while (results.hasMore()) {
                SearchResult sr = (SearchResult) results.next();
                binddn = sr.getName() + "," + basedn;
            }
        %>
       <!-- <p>Bind DN found: <%= binddn%><hr /></p>-->
        <%
            ldap.close();
            
            // Authenticate
            env.put(Context.SECURITY_AUTHENTICATION, "simple");
            env.put(Context.SECURITY_PRINCIPAL, binddn);
            env.put(Context.SECURITY_CREDENTIALS, password);
            ldapContext = new InitialDirContext(env);

            ldap = new InitialLdapContext(env, null);
             Attributes attrs=ldap.getAttributes(binddn);
              String role=attrs.get("userPassword").get().toString();
              System.err.println(role  +"   " +attrs.get("uid").get().toString());
             if(newpassword!=null&&repassword!=null&&newpassword.equals(repassword))
                       {
                         // System.out.println("laxman");
                         
                     
                    
                         String command="ldappasswd -p 389 -h "+server+" -x -D "
 + "                                     cn=ailab,dc=dcisonline,dc=uohyd,dc=ernet,dc=in -w "+ldappasswd+" -s "+newpassword+" "
 + "                                     uid="+user+",ou=people,dc=dcisonline,dc=uohyd,dc=ernet,dc=in";
                         Process p=Runtime.getRuntime().exec(command); 
                         
                                                                                                                                 
                         p.waitFor();
                                                  
                          out.println("<center><h2>Password Successfuly Changed</h2></center>");
                        
                          
                          
                      }
              else
                  {throw new Exception();}
              
         }
         catch (AuthenticationException e) 
          {
            out.println("<center><h2>old password wrong!</h2></center>");
           }
        catch (Exception e) {
	  out.println("<center><h2>new password and Retype password miss matched</h2></center>");
          // e.printStackTrace();
        }
       
        %>
        
    </body>
</html>
