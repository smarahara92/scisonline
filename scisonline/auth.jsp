<%@page import="net.tanesha.recaptcha.ReCaptchaFactory"%>
<%@page import="net.tanesha.recaptcha.ReCaptcha"%>
<%@page import="java.net.NetworkInterface"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="net.tanesha.recaptcha.ReCaptchaImpl"%>
<%@ page import="net.tanesha.recaptcha.ReCaptchaResponse"%>
<%@page contentType="text/html" pageEncoding="UTF-8" 
        import="java.util.*,javax.naming.*,javax.naming.directory.*,javax.naming.ldap.*, java.sql.*" %>
<%@include file="conf.jsp" %>
<%@ include file="dbconnection.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <jsp:useBean id="scis1" class="com.hcu.scis.automation.GetProgramme1">
        </jsp:useBean>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LDAP Authentication Results</title>
        <script type="text/javascript">
            window.history.forward();

        </script>
    </head>
    <body bgcolor="#99CCFF">
        <%            String user = request.getParameter("user"); //get parameter from login.jsp
            session.setAttribute("loginuseriiiiiiiii", user); //set session to maintain last login userid in browser so we can get failedattempts of user, with this captcha will be given in login.jsp.
            String password = request.getParameter("password"); //get password from login.jsp
            PreparedStatement pstmt = null;
            String formattedDate = null;
            int count = 1;
            int status = 1;
            String ip = "", macAddress = "", systemName = "";
            String userAgent = "";
            boolean stafforfaculty = false;
            String msg = "";

            int fail = 0;

            ResultSet rs = null;
            PreparedStatement ps = null;
            ip = request.getHeader("X-FORWARDED-FOR");
            if (ip == null) {
                ip = request.getRemoteAddr();
            }
            //get formatted date and time.
            Calendar calendar = Calendar.getInstance();
            formattedDate = new SimpleDateFormat(" hh:mm:MMa, yyyy/MM/dd").format(calendar.getTime());
            String formattedDate1 = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss").format(calendar.getTime());

            /*
             *Check user is already login. if so directly login with existing session info.
             */
            try {

                String user1 = (String) session.getAttribute("user");
                String role1 = (String) session.getAttribute("role");
                if (user1 != null && role1 != null && user1.equalsIgnoreCase(user) == false) {
                    String fwdpage = session.getAttribute("role") + "main.jsp";
                    session.setAttribute("checkUserLogin", "yes");
                    response.sendRedirect(fwdpage);
                    return;
                }
            } catch (Exception e) {

            }
            //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            if (user == null) {//check userid
                msg = "Error !";
                response.sendRedirect("error.jsp?msg=" + msg);
                return;
            } else if ((user.length() > 2)) {

                stafforfaculty = true;

                try {

                    /*
                     *create loginactivity and logindetails table.
                     *here loginactivity table mainten userid failed attempts,count, and last failed login details(ip,mac,system name,agent(browse details)).
                     *here count column value keep track in current record for user and latest successfull login record in logindetails table.
                     *
                     *logindetails table maintence last 30 successfull login details. here count column value keep track of latest successfull in loginactivity table.
                     *
                     */
                    PreparedStatement pst = con.prepareStatement("create table if not exists loginactivity(userid varchar(50),count INT(5),lastlogin varchar(100),failedattempts int(20),status INT(5),lockouttime varchar(100),ipaddress varchar(100),mackaddress varchar(60),systemname varchar(120),agent varchar(200), primary key(userid))");
                    PreparedStatement pst1 = con.prepareStatement("create table if not exists logindetails(userid varchar(20),count INT(5),lastlogin varchar(100),ipaddress varchar(100),mackaddress varchar(60),systemname varchar(120),agent varchar(200), primary key(userid,count))");
                    pst.executeUpdate();
                    pst1.executeUpdate();

                    String sqlOption = "SELECT * FROM loginactivity where userid=? ";
                    ps = con.prepareStatement(sqlOption);
                    ps.setString(1, user);
                    rs = ps.executeQuery();

                    /*
                     *
                     *failed attempts login rules.                    
                     */
                    if (rs.next()) {

                        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        pstmt = con.prepareStatement("select a.lastlogin,a.ipaddress,a.mackaddress,a.systemname,a.agent from logindetails a, loginactivity b where ((a.userid =b.userid ) and (a.count=b.count)and (b.userid=?) and(b.status=?))");
                        pstmt.setString(1, user);
                        pstmt.setInt(2, 1);
                        ResultSet rs11 = pstmt.executeQuery();
                        if (rs11.next()) {
                            try {

                                String tim1 = rs11.getString(1);
                                formattedDate = new SimpleDateFormat(" hh:mm:MMa, yyyy/MM/dd").format(calendar.getTime());
                                long diff3 = scis1.diffMinutes(tim1, formattedDate);
                                int timeoutInSeconds = request.getSession().getMaxInactiveInterval();
                                if (diff3 <= timeoutInSeconds) {
                                    session.setAttribute("alreadylogin", "yes");
                                    session.setAttribute("alreadyloginlost", rs11.getString(1));
                                    session.setAttribute("alreadyloginip", rs11.getString(2));
                                    session.setAttribute("alreadyloginmack", rs11.getString(3));
                                    session.setAttribute("alreadyloginsystem", rs11.getString(4));
                                    session.setAttribute("alreadyloginagent", rs11.getString(5));
                                    System.out.println(diff3 + "[[[91[" + rs11.getString(1) + rs11.getString(2) + rs11.getString(3) + rs11.getString(4) + rs11.getString(5));
                                    System.out.println(session.getAttribute("alreadyloginlost"));
                                }

                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        fail = rs.getInt("failedattempts");
                        String datestart = rs.getString("lockouttime");
                        long diff = scis1.diffMinutes(datestart, formattedDate1);
                        long diff1 = 0;
                        if (fail == 5 || fail == 7 || fail == 10 || fail == 15 || fail == 20) {
                            pstmt = con.prepareStatement("UPDATE loginactivity set lockouttime=? where userid=?");
                            pstmt.setString(1, formattedDate1);
                            pstmt.setString(2, user);
                            pstmt.executeUpdate();
                        }

                        if ((8 > fail) && (fail > 4)) {
                            if (diff < 3) {
                                diff1 = 3 - diff;
                                session.setAttribute("loginuseriiiiiiiii", "no");
                                msg = "Please try after " + diff1 + " minets";
                                response.sendRedirect("login.jsp?msg=" + msg);
                                return;
                            }
                        } else if ((11 > fail) && (fail > 7)) {
                            if (diff < 6) {
                                diff1 = 6 - diff;
                                session.setAttribute("loginuseriiiiiiiii", "no");
                                msg = "Please try after " + diff1 + " minets";
                                response.sendRedirect("login.jsp?msg=" + msg);
                                return;
                            }
                        } else if ((16 > fail) && (fail > 10)) {
                            if (diff < 16) {
                                diff1 = 15 - diff;
                                session.setAttribute("loginuseriiiiiiiii", "no");
                                msg = "Please try after " + diff1 + " minets";
                                response.sendRedirect("login.jsp?msg=" + msg);
                                return;
                            }
                        } else if ((21 > fail) && (fail > 15)) {
                            if (diff < 60) {
                                diff1 = 60 - diff;
                                session.setAttribute("loginuseriiiiiiiii", "no");
                                msg = "Please try after " + diff1 + " minets";
                                response.sendRedirect("login.jsp?msg=" + msg);
                                return;
                            }
                        } else if (fail >= 20) {
                            if (diff < 1440) {
                                diff1 = 1440 - diff;
                                long diff2 = diff1;
                                diff1 = diff1 / 60;

                                if (diff1 >= 1) {
                                    session.setAttribute("loginuseriiiiiiiii", "no");
                                    msg = "Please try after " + diff1 + " hour";
                                    response.sendRedirect("login.jsp?msg=" + msg);
                                    return;
                                } else {
                                    session.setAttribute("loginuseriiiiiiiii", "no");
                                    msg = "Please try after " + diff2 + " minets";
                                    response.sendRedirect("login.jsp?msg=" + msg);
                                    return;
                                }
                            }
                        }
                        try {
                            ReCaptchaImpl reCaptcha = new ReCaptchaImpl();
                            reCaptcha.setPrivateKey("6LePSPQSAAAAAC5LY-korz96f5c_x8cz7Kv3GDU5");
                            String challenge = request.getParameter("recaptcha_challenge_field");
                            String uresponse = request.getParameter("recaptcha_response_field");
                            ReCaptchaResponse reCaptchaResponse = reCaptcha.checkAnswer(ip, challenge, uresponse);

                            if (reCaptchaResponse.isValid()) {

                            } else {

                                msg = "CAPTCHA Validation Failed! Try Again.";
                                response.sendRedirect("login.jsp?msg=" + msg);
                                fail = fail + 1;
                                pstmt = con.prepareStatement("UPDATE loginactivity set lastlogin=?,ipaddress=?,status=?,mackaddress=?,systemname=?,agent=?, failedattempts=? where userid=?");
                                pstmt.setString(1, formattedDate1);
                                pstmt.setString(2, ip);
                                pstmt.setInt(3, 0);
                                pstmt.setString(4, macAddress);
                                pstmt.setString(5, systemName);
                                pstmt.setString(6, userAgent);
                                pstmt.setInt(7, fail);
                                pstmt.setString(8, user);
                                pstmt.executeUpdate();
                                return;
                            }
                        } catch (Exception e) {
                        }
                    }
                    rs.beforeFirst();
                    //pstmt.close();
                     rs.close();

                } catch (Exception e) {

                    msg = "Sorry ! Internal Server Error Occurred, Please Try later !";
                    response.sendRedirect("error.jsp?msg=" + msg);
                    e.printStackTrace();
                    return;
                }

            }

            String filter = "(|(uid=" + user + ")" + "(mail=" + user + "@*))";
            String cliEquiv = "<tt>ldapsearch -x -h " + server + " -p "
                    + port + " -b " + basedn + " \"" + filter + "\"</tt></p>";
        %>
        <p>Equivalent command line:<br /><%= cliEquiv%><hr />
            <%
                // Connect to the LDAP server.
                Hashtable env = new Hashtable(11);
                env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
                env.put(Context.PROVIDER_URL, "ldap://" + server + ":" + port + "/");

                // Search and retrieve DN.
                //get ip Address , MAC address , system name, user Agent
                if (ip.equalsIgnoreCase("127.0.0.1") == false) {
                    InetAddress inetAddress;
                    StringBuilder sb = new StringBuilder();

                    int i = 0;
                    try {

                        InetAddress address = InetAddress.getByName(ip);
                        NetworkInterface ni = NetworkInterface.getByInetAddress(address);
                        byte[] hw = ni.getHardwareAddress();
                        systemName = address.getHostName();

                        for (i = 0; i < hw.length; i++) {
                            sb.append(String.format("%02X%s", hw[i], (i < hw.length - 1) ? "-" : ""));
                        }
                        macAddress = sb.toString();
                    } catch (Exception e) {

                    }
                } else {
                    macAddress = "Localhost";
                    systemName = "Localhost";
                }

                userAgent = "" + request.getHeader("user-agent");
                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                try {
                    LdapContext ldap = new InitialLdapContext(env, null);
                    NamingEnumeration results = ldap.search(basedn, filter, null);
                    String binddn = "None";
                    while (results.hasMore()) {
                        SearchResult sr = (SearchResult) results.next();
                        binddn = sr.getName() + "," + basedn;
                    }
            %>
        <p>Bind DN found: <%= binddn%><hr /></p>
        <%
            ldap.close();

            // Authenticate
            env.put(Context.SECURITY_AUTHENTICATION, "simple");
            env.put(Context.SECURITY_PRINCIPAL, binddn);
            env.put(Context.SECURITY_CREDENTIALS, password);

            ldap = new InitialLdapContext(env, null);
            Attributes attrs = ldap.getAttributes(binddn);

            String role = attrs.get("gidNumber").get().toString();
            if (role.equals("507")) {
                if (user.equals("staff")) {
                    role = "staff";
                } else if (user.equals("admin")) {
                    role = "admin";
                }
            } else if (role.equals("506")) {

                role = "faculty";
            } else if (role.equals("503") || role.equals("504")) {
              if(user.substring(4,6).equalsIgnoreCase("pc"))
		role="student1";
		else
                role = "student";
            }%>

    <p>Successful authentication for <%= user%>.</p>

    <%

            /*
             * last seen session attribute set. It is used in header.jsp
             */
            session.setAttribute("user", user);
            session.setAttribute("role", role);
            pstmt = con.prepareStatement("select a.lastlogin from logindetails a, loginactivity b where ((a.userid =b.userid ) and (a.count=b.count)and b.userid=?)");
            pstmt.setString(1, user);
            ResultSet rs1 = pstmt.executeQuery();
            if (rs1.next()) {
                try {
                    if (rs.next()) {
                        session.setAttribute("lostseen", rs1.getString(1));//used in header.jsp
                    }
                } catch (Exception e) {
                }
            }
            //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            if (stafforfaculty) {

                try {
                    count = 1;
                    status = 1;
                    String getsize = request.getParameter("Size");
                    /**
                     * Insert record into loginactivity and logindetails table
                     * if it is first login otherwise update the record.
                     *
                     */
                    try {

                        String failedattempts = "0";
                        pstmt = con.prepareStatement("INSERT into loginactivity (userid,count,lastlogin,failedattempts,status,lockouttime,ipaddress,mackaddress,systemname,agent) VALUES (?,?,?,?,?,?,?,?,?,?)");
                        pstmt.setString(1, user);
                        pstmt.setInt(2, count);
                        pstmt.setString(3, null);
                        pstmt.setString(4, failedattempts);
                        pstmt.setInt(5, status);
                        pstmt.setString(6, null);
                        pstmt.setString(7, null);
                        pstmt.setString(8, null);
                        pstmt.setString(9, null);
                        pstmt.setString(10, null);
                        pstmt.executeUpdate();

                        pstmt = con.prepareStatement("INSERT into logindetails (userid,count,lastlogin,ipaddress,mackaddress,systemname,agent) VALUES (?,?,?,?,?,?,?)");
                        pstmt.setString(1, user);
                        pstmt.setInt(2, count);
                        pstmt.setString(3, formattedDate);
                        pstmt.setString(4, ip);
                        pstmt.setString(5, macAddress);
                        pstmt.setString(6, systemName);
                        pstmt.setString(7, userAgent);
                        pstmt.executeUpdate();

                    } catch (Exception e) {

                        String sqlOption = "SELECT count FROM loginactivity where userid=? ";
                        ps = con.prepareStatement(sqlOption);
                        ps.setString(1, user);
                        rs = ps.executeQuery();

                        if (rs.next()) {
                            count = rs.getInt(1) + 1;
                        }

                        /**
                         * It maintence only 30 successfull login attempts, then
                         * after update the records from 1st for that particular
                         * user. here it can done with the help of count column
                         * value.
                         */
                        if (count <= 30) {

                            try {

                                pstmt = con.prepareStatement("INSERT into logindetails (userid,count,lastlogin,ipaddress,mackaddress,systemname,agent) VALUES (?,?,?,?,?,?,?)");
                                pstmt.setString(1, user);
                                pstmt.setInt(2, count);
                                pstmt.setString(3, formattedDate);
                                pstmt.setString(4, ip);
                                pstmt.setString(5, macAddress);
                                pstmt.setString(6, systemName);
                                pstmt.setString(7, userAgent);
                                pstmt.executeUpdate();

                            } catch (Exception ex) {
                                pstmt = con.prepareStatement("UPDATE logindetails set lastlogin=?, ipaddress=?,mackaddress=?,systemname=?, agent=? where (userid=? and count=?)");
                                pstmt.setString(1, formattedDate);
                                pstmt.setString(2, ip);
                                pstmt.setString(3, macAddress);
                                pstmt.setString(4, systemName);
                                pstmt.setString(5, userAgent);
                                pstmt.setString(6, user);
                                pstmt.setInt(7, count);
                                pstmt.executeUpdate();
                            }

                        } else {

                            count = 0;
                            pstmt = con.prepareStatement("UPDATE logindetails set lastlogin=?, ipaddress=?,mackaddress=?,systemname=?, agent=? where (userid=? and count=?)");
                            pstmt.setString(1, formattedDate);
                            pstmt.setString(2, ip);
                            pstmt.setString(3, macAddress);
                            pstmt.setString(4, systemName);
                            pstmt.setString(5, userAgent);
                            pstmt.setString(6, user);
                            pstmt.setInt(7, count);
                            pstmt.executeUpdate();

                        }
                    }

                    pstmt = con.prepareStatement("UPDATE loginactivity set count=?,failedattempts=?,status=?,lockouttime=? where userid=?");
                    pstmt.setInt(1, count);
                    pstmt.setInt(2, 0);
                    pstmt.setInt(3, 1);
                    pstmt.setString(4, null);
                    pstmt.setString(5, user);
                    pstmt.executeUpdate();

                } catch (Exception e) {
                    msg = "Sorry, internal Server Error, Please Try later, Thank you!";

                }

            }

            /**
             * after successfull login redirecting to user main page.
             */
            if (session.getAttribute("user") == null) {
                session.setAttribute("lastseen", user);
                String fwdpage = role + "main.jsp";
                response.sendRedirect(fwdpage);
                return;
            } else {
                String fwdpage = session.getAttribute("role") + "main.jsp";
                response.sendRedirect(fwdpage);
                return;
            }

        } catch (AuthenticationException ae) {

            /**
             * Unsuccessfull login details mainten in loginactivity table.
             */
            if (stafforfaculty) {
                fail = fail + 1;
                pstmt = con.prepareStatement("UPDATE loginactivity set lastlogin=?,ipaddress=?,status=?,mackaddress=?,systemname=?,agent=?, failedattempts=? where userid=?");
                pstmt.setString(1, formattedDate1);
                pstmt.setString(2, ip);
                pstmt.setInt(3, 0);
                pstmt.setString(4, macAddress);
                pstmt.setString(5, systemName);
                pstmt.setString(6, userAgent);
                pstmt.setInt(7, fail);
                pstmt.setString(8, user);
                try {
                    pstmt.executeUpdate();

                } catch (Exception e) {
                    msg = "Sorry, internal Server Error, Please Try later, Thank you!";
                    response.sendRedirect("error.jsp?msg=" + msg);
                    return;
                }
            }
            msg = "Invalid User id/password";
            response.sendRedirect("login.jsp?msg=" + msg);
        } catch (NamingException e) {
            msg = "Error! Please check your userid !";
            response.sendRedirect("error.jsp?msg=" + msg);
            // e.printStackTrace();
        }
    %>
    <hr /><p>Return to <a href="login.jsp">top page</a>.</p>
</body>
</html>