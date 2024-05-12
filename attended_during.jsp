<!DOCTYPE html>
<html>
<head>
    <title>Attendance Information</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <table>
        <tr>
            <td>
                <%@ page import="java.sql.*" %>
                <jsp:include page="menu.html" />
            </td>
            <td>
                <table border="1">
                    <thead>
                        <tr>
                            <th>PID</th>
                            <th>start_date</th>
                            <th>end_date</th>
                            <th>id</th>
                        </tr>
                        <tr>
                            <form action="attended_during.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="PID" size="8" placeholder="PID" />
                                <input type="text" name="start_date" size="17" placeholder="Start Date" />
                                <input type="text" name="end_date" size="17" placeholder="End Date" />
                                <input type="submit" value="Add" />
                            </form>
                        </tr>
                    </thead>
                    <tbody>

                        <%
                            Connection conn = null;
                            Statement stmt = null;
                            ResultSet rs = null;
                            try {
                                Class.forName("org.postgresql.Driver");
                                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/cse132b", "cameroncuellar","tasker");
                                stmt = conn.createStatement();
                                
                                // Check if any form data was submitted
                                String action = request.getParameter("action");
                                if (action != null && action.equals("add")) {
                                    conn.setAutoCommit(false);
                                    
                                    // Create the prepared Statement
                                    // Then INSERT the data into the attended_during table

                                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO attended_during VALUES (?, ?, ?)");
                                    pstmt.setString(1, request.getParameter("PID"));
                                    pstmt.setDate(2, Date.valueOf(request.getParameter("start_date")));
                                    pstmt.setDate(3, Date.valueOf(request.getParameter("end_date")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("attended_during.jsp");
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("UPDATE attended_during SET PID = ?, start_date = ?, end_date = ? WHERE id = ?"); 
                                    pstmt.setString(1, request.getParameter("PID"));
                                    pstmt.setDate(2, Date.valueOf(request.getParameter("start_date")));
                                    pstmt.setDate(3, Date.valueOf(request.getParameter("end_date")));
                                    pstmt.setInt(4, Integer.parseInt(request.getParameter("id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("attended_during.jsp");
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("DELETE FROM attended_during WHERE id = ?");
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("attended_during.jsp");
                                }

                                rs = stmt.executeQuery("SELECT * FROM attended_during");
                                while (rs.next()) {
                        %>
                            <tr>
                                <form action="attended_during.jsp" method="get">
                                    <input type="hidden" name="action" value="update" />
                                    <td><input value="<%= rs.getString("PID") %>" name="PID" size="7"></td>
                                    <td><input value="<%= rs.getDate("start_date") %>" name="start_date" size="16"></td>
                                    <td><input value="<%= rs.getDate("end_date") %>" name="end_date" size="16"></td>
                                    <td><input value="<%= rs.getInt("id") %>" name="id" size="6"></td>
                                    <td><input type="submit" value="Update"></td>
                                </form>
                                <td>
                                    <form action="attended_during.jsp" method="get">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="id" value="<%= rs.getInt("id") %>" />
                                        <input type="submit" value="Delete" />
                                    </form>
                                </td>
                            </tr>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                try {
                                    if (rs != null) {
                                        rs.close();
                                    }
                                    if (stmt != null) {
                                        stmt.close();
                                    }
                                    if (conn != null) {
                                        conn.close();
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                        %>
                    </tbody>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>