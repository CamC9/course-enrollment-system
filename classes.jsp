<!DOCTYPE html>
<html>
<head>
    <title>Class Information</title>
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
                            <th>class_id</th>
                            <th>course_id</th>
                            <th>class_title</th>
                            <th>quarter</th>
                            <th>year</th>
                        </tr>
                        <tr>
                            <form action="classes.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="class_id" size="10" placeholder="Class ID" />
                                <input type="text" name="course_id" size="13" placeholder="Course ID" />
                                <input type="text" name="class_title" size="41" placeholder="Class Title" />
                                <input type="text" name="quarter" size="11" placeholder="Quarter" />
                                <input type="text" name="year" size="11" placeholder="Year" />
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
                                    // Then INSERT the data into the classes table

                                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO classes VALUES (?, ?, ?, ?, ?)");
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("class_id")));
                                    pstmt.setInt(2, Integer.parseInt(request.getParameter("course_id")));
                                    pstmt.setString(3, request.getParameter("class_title"));
                                    pstmt.setString(4, request.getParameter("quarter"));
                                    pstmt.setInt(5, Integer.parseInt(request.getParameter("year")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("classes.jsp");
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("UPDATE classes SET course_id = ?, class_title = ?, quarter = ?, year = ? WHERE class_id = ?"); 
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("course_id")));
                                    pstmt.setString(2, request.getParameter("class_title"));
                                    pstmt.setString(3, request.getParameter("quarter"));
                                    pstmt.setInt(4, Integer.parseInt(request.getParameter("year")));
                                    pstmt.setInt(5, Integer.parseInt(request.getParameter("class_id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("classes.jsp");
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("DELETE FROM classes WHERE class_id = ?");
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("class_id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("classes.jsp");
                                }

                                rs = stmt.executeQuery("SELECT * FROM classes");
                                while (rs.next()) {
                        %>
                            <tr>
                                <form action="classes.jsp" method="get">
                                    <input type="hidden" name="action" value="update" />
                                    <td><input value="<%= rs.getInt("class_id") %>" name="class_id" size="10"></td>
                                    <td><input value="<%= rs.getInt("course_id") %>" name="course_id" size="12"></td>
                                    <td><input value="<%= rs.getString("class_title") %>" name="class_title" size="40"></td>
                                    <td><input value="<%= rs.getString("quarter") %>" name="quarter" size="10"></td>
                                    <td><input value="<%= rs.getInt("year") %>" name="year" size="10"></td>
                                    <td><input type="submit" value="Update"></td>
                                </form>
                                <td>
                                    <form action="classes.jsp" method="get">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="class_id" value="<%= rs.getInt("class_id") %>" />
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
