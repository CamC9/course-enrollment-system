<html>
<body>
    <%@ page import="java.sql.*" %>
    <table>
        <tr>
            <td>
                <jsp:include page="menu.html" />
            </td>
            <td>
                <table>
                    <tr>
                        <th>PID</th>
                        <th>SSN</th>
                        <th>First</th>
                        <th>Middle</th>
                        <th>Last</th>
                        <th>College</th>
                        <th>Residency</th>
                        <th>IsEnrolled</th>
                        <th>GraduateStatus</th>
                    </tr>
                </table>
            </td>
        </tr>
       
        <tr>
            <td>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("org.postgresql.Driver");
                        conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/cse132b", "cameroncuellar","tasker");
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery("SELECT * FROM students");
                        while (rs.next()) {
                %>
                    <tr>
                        <td><%=rs.getString("PID")%></td>
                        <td><%=rs.getString("SSN")%></td>
                        <td><%=rs.getString("first")%></td>
                        <td><%=rs.getString("middle")%></td>
                        <td><%=rs.getString("last")%></td>
                        <td><%=rs.getString("college")%></td>
                        <td><%=rs.getString("residency")%></td>
                        <td><%=rs.getString("is_enrolled")%></td>
                        <td><%=rs.getString("graduate_status")%></td>
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
        </tr> 
       
        <!--
        Open connection code
        Statement code
        Presentation code
        Close connection code
        -->
        </table>
</body>
</html>