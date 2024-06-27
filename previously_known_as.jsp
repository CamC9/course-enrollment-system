<!DOCTYPE html>
<html>
<head>
    <title>Previous Course Names Information</title>
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
                            <th>course_name</th>
                            <th>previous_course_name</th>
                            <th>id</th>
                        </tr>
                        <tr>
                            <form action="previously_known_as.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="course_name" size="16" placeholder="Course Name" />
                                <input type="text" name="previous_course_name" size="23" placeholder="Previous Course Name" />
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
                                    String previous_course_name = request.getParameter("previous_course_name");
                                     
                                    String sql = "INSERT INTO previously_known_as (course_name, previous_course_name) VALUES (?, ?)";
                                    PreparedStatement ps = conn.prepareStatement(sql);
                                    ps.setString(1, course_name);
                                    ps.setString(2, previous_course_name);
                                     
                                    ps.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("previously_known_as.jsp");
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    String course_name = request.getParameter("course_name");
                                    String previous_course_name = request.getParameter("previous_course_name");
                                    Integer id = Integer.parseInt(request.getParameter("id"));
                                    String sql = "UPDATE previously_known_as SET course_name = ?, previous_course_name = ? WHERE id = ?";
                                    PreparedStatement ps = conn.prepareStatement(sql);
                                    ps.setString(1, course_name);
                                    ps.setString(2, previous_course_name);
                                    ps.setInt(3, id);
                                    ps.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("previously_known_as.jsp");
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    Integer id = Integer.parseInt(request.getParameter("id"));
                                     
                                    String sql = "DELETE FROM previously_known_as WHERE id = ?";
                                    PreparedStatement ps = conn.prepareStatement(sql);
                                    ps.setInt(1, id);
                                     
                                    ps.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("previously_known_as.jsp");
                                }
                                 
                                // Get the data from the database
                                rs = stmt.executeQuery("SELECT * FROM previously_known_as");
                                while (rs.next()) {
                        %>
                        <tr>
                            <form action="previously_known_as.jsp" method="get">
                                <input type="hidden" name="action" value="update" />
                                <td><input value="<%= rs.getString("course_name") %>" name="course_name" size="15" /></td>
                                <td><input value="<%= rs.getString("previous_course_name") %>" name="previous_course_name" size="22" /></td>
                                <td><input value="<%= rs.getInt("id") %>" name="id" size="13" /></td>
                                <td><input type="submit" value="Update" /></td>
                            </form>
                            <form action="previously_known_as.jsp" method="get">
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