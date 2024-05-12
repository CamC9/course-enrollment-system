<!DOCTYPE html>
<html>
<head>
    <title>Previous Course Names Information</title>
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
                            <th>course_name</th>
                            <th>previous_couse_name</th>
                            <th>PrerequisiteID</th>
                        </tr>
                        <tr>
                            <form action="prerequisites.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="course_name" size="16" placeholder="Course Name" />
                                <input type="text" name="prerequisite_name" size="18" placeholder="Prerequisite Name" />
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
                                    String course_name = request.getParameter("course_name");
                                    String prerequisite_name = request.getParameter("prerequisite_name");
                                     
                                    String sql = "INSERT INTO prerequisites (course_name, prerequisite_name) VALUES (?, ?)";
                                    PreparedStatement ps = conn.prepareStatement(sql);
                                    ps.setString(1, course_name);
                                    ps.setString(2, prerequisite_name);
                                     
                                    ps.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("prerequisites.jsp");
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    String course_name = request.getParameter("course_name");
                                    String prerequisite_name = request.getParameter("prerequisite_name");
                                    Integer prerequisite_id = Integer.parseInt(request.getParameter("prerequisite_id"));
                                    String sql = "UPDATE prerequisites SET course_name = ?, prerequisite_name = ? WHERE prerequisite_id = ?";
                                    PreparedStatement ps = conn.prepareStatement(sql);
                                    ps.setString(1, course_name);
                                    ps.setString(2, prerequisite_name);
                                    ps.setInt(3, prerequisite_id);
                                    ps.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("prerequisites.jsp");
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    Integer prerequisite_id = Integer.parseInt(request.getParameter("prerequisite_id"));
                                     
                                    String sql = "DELETE FROM prerequisites WHERE prerequisite_id = ?";
                                    PreparedStatement ps = conn.prepareStatement(sql);
                                    ps.setInt(1, prerequisite_id);
                                     
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
                                <td><input value="<%= rs.getString("course_name") %>" name="course_name" size="15" /></td>
                                <td><input value="<%= rs.getString("prerequisite_name") %>" name="prerequisite_name" size="17" /></td>
                                <td><input value="<%= rs.getInt("prerequisite_id") %>" name="prerequisite_id" size="13" /></td>
                                <td><input type="submit" value="Update" /></td>
                            </form>
                            <form action="prerequisites.jsp" method="get">
                                <input type="hidden" name="action" value="delete" />
                                <input type="hidden" name="prerequisite_id" value="<%= rs.getInt("prerequisite_id") %>" />
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