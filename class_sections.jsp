<!DOCTYPE html>
<html>
<head>
    <title>Class Section Information</title>
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
                            <th>class_offering_id</th>
                            <th>instructor</th>
                            <th>enrollment_cap</th>
                            <th>section_id</th>
                        </tr>
                        <tr>
                            <form action="class_sections.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="course_name" size="12" placeholder="Course Name" />
                                <input type="text" name="class_offering_id" size="12" placeholder="Offering ID" />
                                <input type="text" name="instructor" size="15" placeholder="Instructor" />
                                <input type="text" name="enrollment_cap" size="13" placeholder="Enrollment Cap" />
                                <input type="text" name="section_id" size="11" placeholder="Section ID" />
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
                                    // Then INSERT the data into the enrollment table

                                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO class_sections VALUES (?, ?, ?, ?, ?)");
                                    pstmt.setString(1, request.getParameter("course_name"));
                                    pstmt.setInt(2, Integer.parseInt(request.getParameter("class_offering_id")));
                                    pstmt.setString(3, request.getParameter("instructor"));
                                    pstmt.setInt(4, Integer.parseInt(request.getParameter("enrollment_cap")));
                                    pstmt.setInt(5, Integer.parseInt(request.getParameter("section_id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("UPDATE class_sections SET course_name = ?, class_offering_id = ?, instructor = ?, enrollment_cap = ? WHERE section_id = ?"); 
                                    pstmt.setString(1, request.getParameter("course_name"));
                                    pstmt.setInt(2, Integer.parseInt(request.getParameter("class_offering_id")));
                                    pstmt.setString(3, request.getParameter("instructor"));
                                    pstmt.setInt(4, Integer.parseInt(request.getParameter("enrollment_cap")));
                                    pstmt.setInt(5, Integer.parseInt(request.getParameter("section_id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("DELETE FROM class_sections WHERE section_id = ?");
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("section_id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }

                                rs = stmt.executeQuery("SELECT * FROM class_sections");
                                while (rs.next()) {
                        %>
                            <tr>
                                <form action="class_sections.jsp" method="get">
                                    <input type="hidden" name="action" value="update" />
                                    <td><input type="text" name="course_name" value="<%= rs.getString("course_name") %>" size="12" /></td>
                                    <td><input type="text" name="class_offering_id" value="<%= rs.getInt("class_offering_id") %>" size="3" /></td>
                                    <td><input type="text" name="instructor" value="<%= rs.getString("instructor") %>" size="11" /></td>
                                    <td><input type="text" name="enrollment_cap" value="<%= rs.getInt("enrollment_cap") %>" size="4" /></td>
                                    <td><input type="text" name="section_id" value="<%= rs.getInt("section_id") %>" size="4" /></td>
                                    <td><input type="submit" value="Update"></td>
                                </form>
                                <td>
                                    <form action="class_sections.jsp" method="get">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="section_id" value="<%= rs.getInt("section_id") %>" />
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