<!DOCTYPE html>
<html>
<head>
    <title>Class Information</title>
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
                            <th>class_title</th>
                            <th>quarter</th>
                            <th>year</th>
                            <th>class_id</th>
                        </tr>
                        <tr>
                            <form action="classes.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="course_name" size="13" placeholder="Course Name" />
                                <input type="text" name="class_title" size="41" placeholder="Class Title" />
                                <input type="text" name="quarter" size="11" placeholder="Quarter" />
                                <input type="text" name="year" size="11" placeholder="Year" />
                                <input type="text" name="offering_id" size="10" placeholder="Class ID" />
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
                                    pstmt.setString(1, request.getParameter("course_name"));
                                    pstmt.setString(2, request.getParameter("class_title"));
                                    pstmt.setString(3, request.getParameter("quarter"));
                                    pstmt.setInt(4, Integer.parseInt(request.getParameter("year")));
                                    pstmt.setInt(5, Integer.parseInt(request.getParameter("offering_id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("classes.jsp");
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("UPDATE classes SET course_name = ?, class_title = ?, quarter = ?, year = ? WHERE offering_id = ?"); 
                                    pstmt.setString(1, request.getParameter("course_name"));
                                    pstmt.setString(2, request.getParameter("class_title"));
                                    pstmt.setString(3, request.getParameter("quarter"));
                                    pstmt.setInt(4, Integer.parseInt(request.getParameter("year")));
                                    pstmt.setInt(5, Integer.parseInt(request.getParameter("offering_id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("classes.jsp");
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("DELETE FROM classes WHERE offering_id = ?");
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("offering_id")));
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
                                    <td><input value="<%= rs.getString("course_name") %>" name="course_name" size="12"></td>
                                    <td><input value="<%= rs.getString("class_title") %>" name="class_title" size="40"></td>
                                    <td><input value="<%= rs.getString("quarter") %>" name="quarter" size="10"></td>
                                    <td><input value="<%= rs.getInt("year") %>" name="year" size="10"></td>
                                    <td><input value="<%= rs.getInt("offering_id") %>" name="offering_id" size="10"></td>
                                    <td><input type="submit" value="Update"></td>
                                </form>
                                <td>
                                    <form action="classes.jsp" method="get">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="offering_id" value="<%= rs.getInt("offering_id") %>" />
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
