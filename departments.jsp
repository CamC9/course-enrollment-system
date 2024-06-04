<!DOCTYPE html>
<html>
<head>
    <title>Department Information</title>
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
                            <th>DepartmentName</th>
                            <th>TotalUnitsReq</th>
                            <th>LowerDivUnitsReq</th>
                            <th>UpperDivUnitsReq</th>
                            <th>TechnicalElectiveUnitsReq</th>
                        </tr>
                        <tr>
                            <form action="departments.jsp" method="get">
                                <input type="hidden" name="action" value="add" />
                                <input type="text" name="department_name" size="21" placeholder="Department Name" />
                                <input type="text" name="total_units_req" size="15" placeholder="Total Units Req" />
                                <input type="text" name="lower_div_units_req" size="19" placeholder="Lower Div Units Req" />
                                <input type="text" name="upper_div_units_req" size="19" placeholder="Upper Div Units Req" />
                                <input type="text" name="technical_elective_units_req" size="25" placeholder="Technical Elective Units Req" />
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
                                    // Then INSERT the data into the departments table

                                    PreparedStatement pstmt = conn.prepareStatement("INSERT INTO departments VALUES (?, ?, ?, ?, ?)");
                                    pstmt.setString(1, request.getParameter("department_name"));
                                    pstmt.setInt(2, Integer.parseInt(request.getParameter("total_units_req")));
                                    pstmt.setInt(3, Integer.parseInt(request.getParameter("lower_div_units_req")));
                                    pstmt.setInt(4, Integer.parseInt(request.getParameter("upper_div_units_req")));
                                    pstmt.setInt(5, Integer.parseInt(request.getParameter("technical_elective_units_req")));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("departments.jsp");
                                }

                                if (action != null && action.equals("update")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("UPDATE departments SET total_units_req = ?, lower_div_units_req = ?, upper_div_units_req = ?, technical_elective_units_req = ? WHERE department_name = ?");
                                    pstmt.setInt(1, Integer.parseInt(request.getParameter("total_units_req")));
                                    pstmt.setInt(2, Integer.parseInt(request.getParameter("lower_div_units_req")));
                                    pstmt.setInt(3, Integer.parseInt(request.getParameter("upper_div_units_req")));
                                    pstmt.setInt(4, Integer.parseInt(request.getParameter("technical_elective_units_req")));
                                    pstmt.setString(5, request.getParameter("department_name"));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("departments.jsp");
                                }

                                if (action != null && action.equals("delete")) {
                                    conn.setAutoCommit(false);
                                    PreparedStatement pstmt = conn.prepareStatement("DELETE FROM departments WHERE department_name = ?");
                                    pstmt.setString(1, request.getParameter("department_name"));
                                    pstmt.executeUpdate();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                    response.sendRedirect("departments.jsp");
                                }

                                rs = stmt.executeQuery("SELECT * FROM departments");
                                while (rs.next()) {
                        %>
                            <tr>
                                <form action="departments.jsp" method="get">
                                    <input type="hidden" name="action" value="update" />
                                    <td><input value="<%= rs.getString("department_name") %>" name="department_name" size="20"></td>
                                    <td><input value="<%= rs.getInt("total_units_req") %>" name="total_units_req" size="14"></td>
                                    <td><input value="<%= rs.getInt("lower_div_units_req") %>" name="lower_div_units_req" size="18"></td>
                                    <td><input value="<%= rs.getInt("upper_div_units_req") %>" name="upper_div_units_req" size="18"></td>
                                    <td><input value="<%= rs.getInt("technical_elective_units_req") %>" name="technical_elective_units_req" size="24"></td>
                                    <td><input type="submit" value="Update"></td>
                                </form>
                                <td>
                                    <form action="departments.jsp" method="get">
                                        <input type="hidden" name="action" value="delete" />
                                        <input type="hidden" name="department_name" value="<%= rs.getString("department_name") %>" />
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