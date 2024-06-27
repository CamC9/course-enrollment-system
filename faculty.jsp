<!DOCTYPE html>
<html>
<head>
    <title>Faculty Information</title>
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
                            <th>Name</th>
                            <th>Title</th>
                            <th>Department</th>
                        </tr>
                        <tr>
                            <form action="faculty.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="Name" size="21" placeholder="Name" />
                                <input type="text" name="Title" size="21" placeholder="Title" />
                                <input type="text" name="Department" size="21" placeholder="Department" />
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
                                    // Then INSERT the data into the faculty table

                                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO faculty VALUES (?, ?, ?)");
                                    pstmt.setString(1, request.getParameter("Name"));
                                    pstmt.setString(2, request.getParameter("Title"));
                                    pstmt.setString(3, request.getParameter("Department"));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("faculty.jsp");
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("UPDATE faculty SET Title = ?, Department = ? WHERE Name = ?");
                                    pstmt.setString(1, request.getParameter("Title"));
                                    pstmt.setString(2, request.getParameter("Department"));
                                    pstmt.setString(3, request.getParameter("Name"));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("faculty.jsp");
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("DELETE FROM faculty WHERE Name = ?");
                                    pstmt.setString(1, request.getParameter("Name"));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("faculty.jsp");
                                }

                                rs = stmt.executeQuery("SELECT * FROM faculty");
                                while (rs.next()) {
                        %>
                            <tr>
                                <form action="faculty.jsp" method="get">
                                    <input type="hidden" name="action" value="update" />
                                    <td><input value="<%= rs.getString("Name") %>" name="Name" size="20"></td>
                                    <td><input value="<%= rs.getString("Title") %>" name="Title" size="20"></td>
                                    <td><input value="<%= rs.getString("Department") %>" name="Department" size="20"></td>
                                    <td><input type="submit" value="Update"></td>
                                </form>
                                <td>
                                    <form action="faculty.jsp" method="get">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="Name" value="<%= rs.getString("Name") %>" />
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
