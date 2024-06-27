<!DOCTYPE html>
<html>
<head>
    <title>Category Requirements Information</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/static/styles.css"> 
</head>
<body>
    <table>
        <tr>
            <td>
                <%@ page import="java.sql.*, java.math.BigDecimal" %>
                <%@ include file="menu.html" %>
            </td>
            <td>
                <table border="1">
                    <thead>
                        <tr>
                            <th>degree_name</th>
                            <th>concentration_name</th>
                            <th>course_id</th>
                            <th>min_units_concentration</th>
                            <th>min_gpa</th>
                            <th>id</th>
                        </tr>
                        <tr>
                            <form action="concentration_consists_of.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="degree_name" size="26" placeholder="Degree Name" />
                                <input type="text" name="concentration_name" size="20" placeholder="Concentration Name" />
                                <input type="text" name="course_id" size="18" placeholder="Course ID" />
                                <input type="text" name="min_units_concentration" size="25" placeholder="Min Units" />
                                <input type="text" name="min_gpa" size="7" placeholder="Min GPA" />
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
                                    // Then INSERT the data into the concentration_consists_of table

                                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO concentration_consists_of VALUES (?, ?, ?, ?, ?)");
                                    pstmt.setString(1, request.getParameter("degree_name"));
                                    pstmt.setString(2, request.getParameter("concentration_name"));
                                    pstmt.setInt(3, Integer.parseInt(request.getParameter("course_id")));
                                    pstmt.setInt(4, Integer.parseInt(request.getParameter("min_units_concentration")));
                                    pstmt.setBigDecimal(5, new BigDecimal(request.getParameter("min_gpa")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("concentration_consists_of.jsp");
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("UPDATE concentration_consists_of SET degree_name = ?, concentration_name = ?, course_id= ?, min_units_concentration = ?, min_gpa = ? WHERE id = ?");
                                    pstmt.setString(1, request.getParameter("degree_name"));
                                    pstmt.setString(2, request.getParameter("concentration_name"));
                                    pstmt.setInt(3, Integer.parseInt(request.getParameter("course_id")));
                                    pstmt.setInt(4, Integer.parseInt(request.getParameter("min_units_concentration")));
                                    pstmt.setBigDecimal(5, new BigDecimal(request.getParameter("min_gpa")));
                                    pstmt.setInt(6, Integer.parseInt(request.getParameter("id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("concentration_consists_of.jsp");
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("DELETE FROM concentration_consists_of WHERE id = ?");
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("concentration_consists_of.jsp");
                                }

                                rs = stmt.executeQuery("SELECT * FROM concentration_consists_of");
                                while (rs.next()) {
                        %>
                            <tr>
                                <form action="concentration_consists_of.jsp" method="get">
                                    <input type="hidden" name="action" value="update" />
                                    <td><input value="<%= rs.getString("degree_name") %>" name="degree_name" size="25"></td>
                                    <td><input value="<%= rs.getString("concentration_name") %>" name="concentration_name" size="19"></td>
                                    <td><input value="<%= rs.getInt("course_id") %>" name="course_id" size="17"></td>
                                    <td><input value="<%= rs.getInt("min_units_concentration") %>" name="min_units_concentration" size="24"></td>
                                    <td><input value="<%= rs.getBigDecimal("min_gpa") %>" name="min_gpa" size="7"></td>
                                    <td><input value="<%= rs.getInt("id") %>" name="id" size="6"></td>
                                    <td><input type="submit" value="Update"></td>
                                </form>
                                <td>
                                    <form action="concentration_consists_of.jsp" method="get">
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