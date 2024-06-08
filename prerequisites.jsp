<!DOCTYPE html>
<html>
<head>
    <title>Prerequisite Information</title>
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
                            <th>Course ID</th>
                            <th>Prerequisite ID</th>
                            <th>id</th>
                        </tr>
                        <tr>
                            <form action="prerequisites.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="course_id" size="16" placeholder="Course ID" />
                                <input type="text" name="prerequisite_id" size="18" placeholder="Prerequisite ID" />
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
                                    Integer course_id = Integer.parseInt(request.getParameter("course_id")); 
                                    Integer prerequisite_id = Integer.parseInt(request.getParameter("prerequisite_id")); 
                                     
                                    String sql = "INSERT INTO prerequisites (course_id, prerequisite_id) VALUES (?, ?)";
                                    PreparedStatement ps = conn.prepareStatement(sql);
                                    ps.setInt(1, course_id);
                                    ps.setInt(2, prerequisite_id);
                                     
                                    ps.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("prerequisites.jsp");
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    Integer course_id = Integer.parseInt(request.getParameter("course_id")); 
                                    Integer prerequisite_id = Integer.parseInt(request.getParameter("prerequisite_id"));
                                    Integer id = Integer.parseInt(request.getParameter("id"));
                                    String sql = "UPDATE prerequisites SET course_id = ?, prerequisite_id = ? WHERE id = ?";
                                    PreparedStatement ps = conn.prepareStatement(sql);
                                    ps.setInt(1, course_id);
                                    ps.setInt(2, prerequisite_id);
                                    ps.setInt(3, id);
                                    ps.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("prerequisites.jsp");
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    Integer id = Integer.parseInt(request.getParameter("id"));
                                     
                                    String sql = "DELETE FROM prerequisites WHERE id = ?";
                                    PreparedStatement ps = conn.prepareStatement(sql);
                                    ps.setInt(1, id);
                                     
                                    ps.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("prerequisites.jsp");
                                }
                                 
                                // Get the data from the database
                                rs = stmt.executeQuery("SELECT * FROM prerequisites");
                                while (rs.next()) {
                        %>
                        <tr>
                            <form action="prerequisites.jsp" method="get">
                                <input type="hidden" name="action" value="update" />
                                <td><input value="<%= rs.getInt("course_id") %>" name="course_id" size="15" /></td>
                                <td><input value="<%= rs.getInt("prerequisite_id") %>" name="prerequisite_id" size="17" /></td>
                                <td><input value="<%= rs.getInt("id") %>" name="id" size="13" /></td>
                                <td><input type="submit" value="Update" /></td>
                            </form>
                            <form action="prerequisites.jsp" method="get">
                                <input type="hidden" name="action" value="delete" />
                                <input type="hidden" name="id" value="<%= rs.getInt("id") %>" />
                                <td><input type="submit" value="Delete" /></td>
                            </form>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            }
                        %>
                    </tbody>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>