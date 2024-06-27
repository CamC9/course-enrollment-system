<!DOCTYPE html>
<html>
<head>
    <title>Graduated From Information</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/static/styles.css"> 
</head>
<body>
    <table>
        <tr>
            <td>
                <%@ page import="java.sql.*" %>
                <%@ include file="menu.html" %>
            </td>
            <td>
                <table border="1">
                    <thead>
                        <tr>
                            <th>PID</th>
                            <th>college</th>
                            <th>degree</th>
                            <th>id</th>
                        </tr>
                        <tr>
                            <form action="graduated_from.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="PID" size="8" placeholder="PID" />
                                <input type="text" name="college" size="41" placeholder="College" />
                                <input type="text" name="degree" size="17" placeholder="Degree" />
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
                                    // Then INSERT the data into the graduated_from table

                                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO graduated_from VALUES (?, ?, ?)");
                                    pstmt.setString(1, request.getParameter("PID"));
                                    pstmt.setString(2, request.getParameter("college"));
                                    pstmt.setString(3, request.getParameter("degree"));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("graduated_from.jsp");
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("UPDATE graduated_from SET PID = ?, college = ?, degree = ? WHERE id = ?"); 
                                    pstmt.setString(1, request.getParameter("PID"));
                                    pstmt.setString(2, request.getParameter("college"));
                                    pstmt.setString(3, request.getParameter("degree"));
                                    pstmt.setInt(4, Integer.parseInt(request.getParameter("id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("graduated_from.jsp");
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("DELETE FROM graduated_from WHERE id = ?");
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("graduated_from.jsp");
                                }

                                rs = stmt.executeQuery("SELECT * FROM graduated_from");
                                while (rs.next()) {
                        %>
                            <tr>
                                <form action="graduated_from.jsp" method="get">
                                    <input type="hidden" name="action" value="update" />
                                    <td><input value="<%= rs.getString("PID") %>" name="PID" size="7"></td>
                                    <td><input value="<%= rs.getString("college") %>" name="college" size="40"></td>
                                    <td><input value="<%= rs.getString("degree") %>" name="degree" size="16"></td>
                                    <td><input value="<%= rs.getInt("id") %>" name="id" size="6"></td>
                                    <td><input type="submit" value="Update"></td>
                                </form>
                                <td>
                                    <form action="graduated_from.jsp" method="get">
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