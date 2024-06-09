<!DOCTYPE html>
<html>
<head>
    <title>Classes Taken By Student Report Form</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script>
        function updatePIDGradeReport() {
            var PID = document.getElementById('PIDSelectGradeReport').value;
            document.getElementById('selectedPIDGradeReport').value = PID;
        }
        window.onload = function() {
            updatePIDGradeReport();  // The initial PID is now set when the page loads
        }
    </script>
</head>
<body>
    <table>
        <tr>
            <td>
                <%@ page import="java.sql.*" %>
                <%@ page import="java.util.ArrayList" %>
                <jsp:include page="menu.html" />
            </td>
            <td>
                <table border="1">
                    <thead>
                        <tr>
                            <th>PID</th>
                            <th>First</th>
                            <th>Middle</th>
                            <th>Last</th>
                        </tr>
                        <tr>
                            <form action="grade_report.jsp" method="get">
                                <input type="hidden" name="action" value="select" />
                                <input type="submit" value="Select Student" />
                                <select name="PID" id="PIDSelectGradeReport" onchange="updatePIDGradeReport()">
                                    <% 
                                        Connection conn1 = null;
                                        Statement stmt1 = null;
                                        ResultSet rs1 = null;
                                        try {
                                            Class.forName("org.postgresql.Driver");
                                            conn1 = DriverManager.getConnection("jdbc:postgresql://localhost:5432/cse132b", "cameroncuellar","tasker");
                                            stmt1 = conn1.createStatement();
                                            
                                            String action = request.getParameter("action");
                                            if (action != null && action.equals("select")) {
                                                conn1.setAutoCommit(false);
                                                PreparedStatement pstmt = conn1.prepareStatement("SELECT students.PID FROM students JOIN enrollment ON students.PID = enrollment.student_pid UNION SELECT students.PID FROM students JOIN past_enrollment ON students.PID = past_enrollment.student_pid GROUP BY PID");
                                                rs1 = pstmt.executeQuery();
                                                conn1.commit();
                                                conn1.setAutoCommit(true);
                                            }
                                            
                                            // Iterate over the result set and generate the options
                                            while (rs1.next()) {
                                                String PID = rs1.getString("PID");
                                                %>
                                                <option value="<%= PID %>"><%= PID%></option>
                                                <%
                                            }
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        } finally {
                                            try {
                                                if (rs1 != null) {
                                                    rs1.close();
                                                }
                                                if (stmt1 != null) {
                                                    stmt1.close();
                                                }
                                                if (conn1 != null) {
                                                    conn1.close();
                                                }
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            }
                                        }
                                    %>
                                </select>
                            </form>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <form action="grade_report.jsp" method="get">
                                <input type="hidden" name="action" value="show_student_details" />
                                <input type="hidden" name="PID" id="selectedPIDGradeReport" />
                                <input type="submit" value="Show Details" />
                            </form>
                        </tr>

                        <%
                            Connection conn = null;
                            PreparedStatement pstmt = null;
                            ResultSet rs = null;
                            String errorMessage = "";
                            try {
                                Class.forName("org.postgresql.Driver");
                                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/cse132b", "cameroncuellar","tasker");
                                
                                // Check if any form data was submitted
                                String action = request.getParameter("action");
                                if (action != null && action.equals("show_student_details")) {
                                    conn.setAutoCommit(false);
                                   
                                    // Retrieve all student attributes given the PID
                                    PreparedStatement checkStmt = conn.prepareStatement(
                                        "SELECT * FROM students WHERE PID = ?");
                                    
                                    checkStmt.setString(1, request.getParameter("PID"));
                                    ResultSet checkRs = checkStmt.executeQuery();
                                    conn.commit();
                                    conn.setAutoCommit(true);

                                    try {
                                        if (checkStmt != null) {
                                            while (checkRs.next()) {
                        %>
                            <tr>
                                <form action="grade_report.jsp" method="get">
                                    <input type="hidden" name="action" value="show_classes" />
                                    <td><input type="text" name="PID" value="<%= checkRs.getString("PID") %>" size="10" /></td>
                                    <td><input type="text" name="First" value="<%= checkRs.getString("first") %>" size="13" /></td>
                                    <td><input type="text" name="Middle" value="<%= checkRs.getString("middle") %>" size="11" /></td>
                                    <td><input type="text" name="Last" value="<%= checkRs.getString("last") %>" size="11" /></td>
                                    <td><input type="submit" value="Show Classes"></td>
                                </form>
                            </tr>
                                
                        <%
                                            }
                                            checkStmt.close();
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }

                                }

                                if (action != null && action.equals("show_classes")) {
                                    conn.setAutoCommit(false);

                                    String sql = "SELECT combined.section_id, combined.class_id, combined.units, c.class_title, combined.quarter, combined.year, combined.grade " +
                                        "FROM " +
                                        "    ( " +
                                        "        SELECT " +
                                        "            e.section_id, " +
                                        "            e.class_id, " +
                                        "            e.units, " +
                                        "            NULL AS quarter, " +
                                        "            NULL AS year, " +
                                        "            NULL AS grade " +
                                        "        FROM " +
                                        "            enrollment e " +
                                        "        WHERE " +
                                        "            e.student_pid = ? " +
                                        "        UNION " +
                                        "        SELECT " +
                                        "            pe.section_id, " +
                                        "            pe.class_id, " +
                                        "            pe.units, " +
                                        "            cls.quarter, " +
                                        "            cls.year, " +
                                        "            pe.grade " +
                                        "        FROM " +
                                        "            past_enrollment pe " +
                                        "        JOIN classes cls ON pe.class_id = cls.class_id " + 
                                        "        WHERE " +
                                        "            pe.student_pid = ? " +
                                        "    ) combined " +
                                        "JOIN class_sections s ON s.section_id = combined.section_id " +
                                        "JOIN classes c ON c.class_id = s.class_id " +
                                        "ORDER BY combined.year DESC, combined.quarter DESC ";

                                    pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                                    pstmt.setString(1, request.getParameter("PID"));
                                    pstmt.setString(2, request.getParameter("PID"));
                                    rs = pstmt.executeQuery();
                                    conn.commit();
                                    conn.setAutoCommit(true);
                                }
                        %>
                            <table border="1">
                                <tr>
                                    <th>Section ID</th>
                                    <th>Course ID</th>
                                    <th>Class Title</th>
                                    <th>Quarter</th>
                                    <th>Year</th>
                                    <th>Grade</th>
                                </tr>
                                <%
                                    String lastQuarter = "";
                                    int lastYear = -1;
                                    Double totalGradePoints = 0.0;
                                    int totalUnits = 0;
                                    Double currQuarterGradePoints = 0.0;
                                    int currQuarterUnits = 0;
                                
                                    String grade_val = "";
                                    String quarter_val = "";
                                    Integer year_val = 0;
                                
                                    if (rs.next()) {
                                        do {
                                            grade_val = rs.getString("grade");
                                            quarter_val = rs.getString("quarter");
                                            year_val = rs.getInt("year");
                                            int units = rs.getInt("units");
                                            if (grade_val == null) {
                                                grade_val = "";
                                            }
                                            if (quarter_val == null) {
                                                quarter_val = "Spring";
                                            }
                                            if (year_val == 0) {
                                                year_val = 2018;
                                            }
                                %>
                                            <tr>
                                                <td><%= rs.getString("section_id") %></td>
                                                <td><%= rs.getInt("class_id") %></td>
                                                <td><%= rs.getString("class_title") %></td>
                                                <td><%= quarter_val %></td>
                                                <td><%= year_val %></td>
                                                <td><%= grade_val %></td>
                                            </tr>
                                <%
                                            if (grade_val.isEmpty()) {
                                %>
                                            <tr><td colspan="6">&nbsp;</td></tr>
                                <%
                                                continue;
                                            }
                                
                                            PreparedStatement gradeConversionStmt = conn.prepareStatement("SELECT number_grade FROM grade_conversion WHERE letter_grade = ?");
                                            gradeConversionStmt.setString(1, grade_val);
                                            ResultSet gradeConversionRs = gradeConversionStmt.executeQuery();
                                            gradeConversionRs.next();
                                            double gradeDouble = gradeConversionRs.getDouble("number_grade");
                                            // Exclude classes with a Letter grade of 'IN' from the GPA calculation
                                            if (!grade_val.equals("IN")) {
                                                totalGradePoints += gradeDouble * units;
                                                totalUnits += units;
                                                if (gradeDouble > 0.0) {
                                                    currQuarterGradePoints += gradeDouble * units;
                                                    currQuarterUnits += units;
                                                }
                                            }
                                
                                            boolean isLastRow = rs.isLast();
                                            String nextQuarter = null;
                                            int nextYear = -1;
                                
                                            if (!isLastRow) {
                                                rs.next();
                                                nextQuarter = rs.getString("quarter");
                                                nextYear = rs.getInt("year");
                                                rs.previous();
                                            }
                                
                                            if (isLastRow || (nextQuarter != null && !nextQuarter.equals(quarter_val)) || (nextYear != -1 && nextYear != year_val)) {
                                %>
                                            <tr>
                                                <td>Quarter GPA: <%= String.format("%.2f", currQuarterGradePoints / currQuarterUnits) %></td>
                                            </tr>
                                            <tr>
                                                <td colspan="6">&nbsp;</td>
                                            </tr>
                                <%
                                                lastQuarter = quarter_val;
                                                lastYear = year_val;
                                                currQuarterGradePoints = 0.0;
                                                currQuarterUnits = 0;
                                            }
                                        } while (rs.next());
                                    }
                                %>
                                <tr>
                                    <td colspan="6">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>Cumulative GPA: <%= String.format("%.2f", totalGradePoints / totalUnits) %></td>
                                </tr>
                                </table>
                            <%
                            } catch (Exception e) {
                                errorMessage = e.getMessage();
                                %>
                                <tr>
                                    <td colspan="6"><%= errorMessage %></td>
                                </tr>
                                <%
                                e.printStackTrace();
                            } finally {
                                try {
                                    if (rs != null) {
                                        rs.close();
                                    }
                                    if (pstmt != null) {
                                        pstmt.close();
                                    }
                                    if (conn != null) {
                                        conn.close();
                                    }
                                } catch (Exception e) {
                                    errorMessage = e.getMessage();
                                    %>
                                    <tr>
                                        <td colspan="6"><%= errorMessage %></td>
                                    </tr>
                                    <%
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