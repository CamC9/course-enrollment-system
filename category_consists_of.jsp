<!DOCTYPE html>
<html>
<head>
    <title>Category Requirements Information</title>
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
                            <th>degree_name</th>
                            <th>category_name</th>
                            <th>course_name</th>
                            <th>id</th>
                        </tr>
                        <tr>
                            <form action="category_consists_of.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="degree_name" size="17" placeholder="Degree Name" />
                                <input type="text" name="category_name" size="18" placeholder="Category Name" />
                                <input type="text" name="course_name" size="18" placeholder="Course Name" />
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
                                    // Then INSERT the data into the category_consists_of table

                                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO category_consists_of VALUES (?, ?, ?)");
                                    pstmt.setString(1, request.getParameter("degree_name"));
                                    pstmt.setString(2, request.getParameter("category_name"));
                                    pstmt.setString(3, request.getParameter("course_name"));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("category_consists_of.jsp");
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("UPDATE category_consists_of SET degree_name = ?, category_name = ?, course_name = ? WHERE id = ?");
                                    pstmt.setString(1, request.getParameter("degree_name"));
                                    pstmt.setString(2, request.getParameter("category_name"));
                                    pstmt.setString(3, request.getParameter("course_name"));
                                    pstmt.setInt(4, Integer.parseInt(request.getParameter("id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("category_consists_of.jsp");
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("DELETE FROM category_consists_of WHERE id = ?");
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("category_consists_of.jsp");
                                }

                                rs = stmt.executeQuery("SELECT * FROM category_consists_of");
                                while (rs.next()) {
                        %>
                            <tr>
                                <form action="category_consists_of.jsp" method="get">
                                    <input type="hidden" name="action" value="update" />
                                    <td><input value="<%= rs.getString("degree_name") %>" name="degree_name" size="16"></td>
                                    <td><input value="<%= rs.getString("category_name") %>" name="category_name" size="17"></td>
                                    <td><input value="<%= rs.getString("course_name") %>" name="course_name" size="17"></td>
                                    <td><input value="<%= rs.getInt("id") %>" name="id" size="6"></td>
                                    <td><input type="submit" value="Update"></td>
                                </form>
                                <td>
                                    <form action="category_consists_of.jsp" method="get">
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