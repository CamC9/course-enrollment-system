<!DOCTYPE html>
<html>
<head>
    <title>Probation Information</title>
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
                            <th>department_name</th>
                            <th>category_name</th>
                            <th>concentration_name</th>
                            <th>id</th>
                        </tr>
                        <tr>
                            <form action="degree_requirements.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="degree_name" size="16" placeholder="Degree Name" />
                                <input type="text" name="department_name" size="18" placeholder="Department Name" />
                                <input type="text" name="category_name" size="17" placeholder="Category Name" />
                                <input type="text" name="concentration_name" size="19" placeholder="Concentration Name" />
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
                                    // Then INSERT the data into the degree_requirements table

                                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO degree_requirements VALUES (?, ?, ?, ?)");
                                    String degree_name = request.getParameter("degree_name");
                                    String department_name = request.getParameter("department_name");
                                    String category_name = request.getParameter("category_name");
                                    String concentration_name = request.getParameter("concentration_name");
                                    pstmt.setString(1, degree_name);
                                    pstmt.setString(2, department_name);
                                    if (concentration_name == null || concentration_name.trim().isEmpty()) {
                                        pstmt.setString(3, category_name); 
                                        pstmt.setString(4, null);
                                    } else {
                                        pstmt.setString(3, null);
                                        pstmt.setString(4, concentration_name);
                                    }
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("degree_requirements.jsp");
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("UPDATE degree_requirements SET degree_name = ?, department_name = ?, category_name = ?, concentration_name = ? WHERE id = ?"); 
                                    String degree_name = request.getParameter("degree_name");
                                    String department_name = request.getParameter("department_name");
                                    String category_name = request.getParameter("category_name");
                                    String concentration_name = request.getParameter("concentration_name");
                                    pstmt.setString(1, degree_name);
                                    pstmt.setString(2, department_name);
                                    if (concentration_name == null || concentration_name.trim().isEmpty()) {
                                        pstmt.setString(3, category_name); 
                                        pstmt.setString(4, null);
                                    } else {
                                        pstmt.setString(3, null);
                                        pstmt.setString(4, concentration_name);
                                    } 
                                    pstmt.setInt(5, Integer.parseInt(request.getParameter("id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("degree_requirements.jsp");
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("DELETE FROM degree_requirements WHERE id = ?");
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("degree_requirements.jsp");
                                }

                                rs = stmt.executeQuery("SELECT * FROM degree_requirements");
                                while (rs.next()) {
                        %>
                            <tr>
                                <form action="degree_requirements.jsp" method="get">
                                    <input type="hidden" name="action" value="update" />
                                    <td><input type="text" name="degree_name" value="<%= rs.getString("degree_name") %>" size="15" /></td>
                                    <td><input type="text" name="department_name" value="<%= rs.getString("department_name") %>" size="17" /></td>
                                    <td><input type="text" name="category_name" value="<%= rs.getString("category_name") %>" size="16" /></td>
                                    <td><input type="text" name="concentration_name" value="<%= rs.getString("concentration_name") %>" size="19" /></td>
                                    <td><input type="text" name="id" value="<%= rs.getInt("id") %>" size="7" /></td>
                                    <td><input type="submit" value="Update"></td>
                                </form>
                                <td>
                                    <form action="degree_requirements.jsp" method="get">
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
