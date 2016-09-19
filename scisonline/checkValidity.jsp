<script>
    function checkvalidity()
    {

    <% try {
            String userName=(String)session.getAttribute("user");
           
            if (!request.isRequestedSessionIdValid()) {
                //String msg = "Session Expired!";
                //response.sendRedirect("login.jsp?msg=" + msg);
                response.sendRedirect("redirectlogin.jsp");
                return;

                // response.sendRedirect("redirectlogin.jsp");
            } else if (session.getAttribute("user") == null) {
                //String msg="Session Expired or You are not Logged in";
                response.sendRedirect("redirectlogin.jsp");
                return;

            }

        } catch (Exception e) {
        }
    %>
    }
</script>