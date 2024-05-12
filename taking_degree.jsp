<!DOCTYPE html>
<html>
<head>
    <title>Student Degree Information</title>
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
                            <th>degree_name</th>
                            <th>department</th>
                            <th>id</th>
                        </tr>
                        <tr>
                            <form action="taking_degree.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="PID" size="8" placeholder="PID" />
                                <input type="text" name="degree_name" size="17" placeholder="Degree Name" />
                                <input type="text" name="department" size="17" placeholder="Department" />
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
                                    // Then INSERT the data into the taking_degree table

                                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO taking_degree VALUES (?, ?, ?)");
                                    pstmt.setString(1, request.getParameter("PID"));
                                    pstmt.setString(2, request.getParameter("degree_name"));
                                    pstmt.setString(3, request.getParameter("department"));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("taking_degree.jsp");
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("UPDATE taking_degree SET PID = ?, degree_name = ?, department = ? WHERE id = ?"); 
                                    pstmt.setString(1, request.getParameter("PID"));
                                    pstmt.setString(2, request.getParameter("degree_name"));
                                    pstmt.setString(3, request.getParameter("department"));
                                    pstmt.setInt(4, Integer.parseInt(request.getParameter("id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("taking_degree.jsp");
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("DELETE FROM taking_degree WHERE id = ?");
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("taking_degree.jsp");
                                }

                                rs = stmt.executeQuery("SELECT * FROM taking_degree");
                                while (rs.next()) {
                        %>
                            <tr>
                                <form action="taking_degree.jsp" method="get">
                                    <input type="hidden" name="action" value="update" />
                                    <td><input value="<%= rs.getString("PID") %>" name="PID" size="7"></td>
                                    <td><input value="<%= rs.getString("degree_name") %>" name="degree_name" size="16"></td>
                                    <td><input value="<%= rs.getString("department") %>" name="department" size="16"></td>
                                    <td><input value="<%= rs.getInt("id") %>" name="id" size="6"></td>
                                    <td><input type="submit" value="Update"></td>
                                </form>
                                <td>
                                    <form action="taking_degree.jsp" method="get">
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