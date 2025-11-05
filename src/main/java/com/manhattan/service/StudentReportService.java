package com.manhattan.service;

import com.lowagie.text.*;
import com.lowagie.text.pdf.*;
import com.manhattan.bean.Student;
import com.manhattan.bean.StudentAttendance;
import com.manhattan.bean.StudentMarks;
import com.manhattan.repo.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.List;

@Service
public class StudentReportService {

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private StudentAttendanceService attendanceService;

    @Autowired
    private StudentMarksService marksService;

    public ByteArrayInputStream generateStudentReport(String adminNo) {
        System.out.println("📄 [DEBUG] Generating report for adminNo: " + adminNo);

        // ✅ Step 1: Defensive null/empty checks
        if (adminNo == null) {
            System.err.println("❌ [ERROR] adminNo is NULL. Report generation aborted.");
            throw new IllegalArgumentException("Admin No is missing or null.");
        }

        adminNo = adminNo.trim();
        if (adminNo.isEmpty()) {
            System.err.println("❌ [ERROR] adminNo is EMPTY after trimming. Report generation aborted.");
            throw new IllegalArgumentException("Admin No cannot be empty.");
        }

        // ✅ Step 2: Normalize safely
        adminNo = adminNo.toUpperCase();
        final String normalizedAdminNo = adminNo; // <— used inside lambdas safely

        // ✅ Step 3: Fetch student safely
        Student student = null;
        try {
            student = studentRepository.findByAdminNoIgnoreCase(normalizedAdminNo);
        } catch (Exception e) {
            System.err.println("❌ [ERROR] StudentRepository lookup failed: " + e.getMessage());
        }

        if (student == null) {
            System.err.println("❌ [ERROR] No student found for Admin No: " + normalizedAdminNo);
            throw new RuntimeException("No student found for Admin No: " + normalizedAdminNo);
        }

        // ✅ Step 4: Fetch attendance and marks
        List<StudentAttendance> attendanceList = attendanceService.getAllAttendance()
                .stream()
                .filter(a -> a.getAdminNo() != null &&
                        a.getAdminNo().trim().equalsIgnoreCase(normalizedAdminNo))
                .toList();

        List<StudentMarks> marksList = marksService.getAllMarks()
                .stream()
                .filter(m -> m.getAdminNo() != null &&
                        m.getAdminNo().trim().equalsIgnoreCase(normalizedAdminNo))
                .toList();

        System.out.println("🟢 [DEBUG] Attendance Records Found: " + attendanceList.size());
        System.out.println("🟢 [DEBUG] Marks Records Found: " + marksList.size());

        // ✅ Step 5: Generate the PDF
        Document document = new Document(PageSize.A4);
        ByteArrayOutputStream out = new ByteArrayOutputStream();

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            // ===== HEADER =====
            Font titleFont = new Font(Font.HELVETICA, 18, Font.BOLD);
            Paragraph title = new Paragraph("Student Performance Report", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);
            document.add(Chunk.NEWLINE);

            // ===== STUDENT DETAILS =====
            Font sectionHeader = new Font(Font.HELVETICA, 14, Font.BOLD);
            Font normalFont = new Font(Font.HELVETICA, 12);

            document.add(new Paragraph("Student Details", sectionHeader));
            document.add(new Paragraph("Full Name: " + student.getFullName(), normalFont));
            document.add(new Paragraph("Student Email: " + student.getAdminNo(), normalFont));
            document.add(new Paragraph("Standard: " + student.getStandard(), normalFont));
            document.add(new Paragraph("Date of Birth: " + student.getDob(), normalFont));
            document.add(new Paragraph("Phone No: " + student.getPhoneNo(), normalFont));
            document.add(new Paragraph("Father's Name: " + student.getFatherName(), normalFont));
            document.add(new Paragraph("Mother's Name: " + student.getMotherName(), normalFont));
            document.add(new Paragraph("Address: " + student.getAddress(), normalFont));
            document.add(Chunk.NEWLINE);

            // ===== ATTENDANCE SECTION =====
            document.add(new Paragraph("Attendance Details", sectionHeader));
            if (attendanceList.isEmpty()) {
                document.add(new Paragraph("No attendance records found.", normalFont));
            } else {
                PdfPTable attendanceTable = new PdfPTable(5);
                attendanceTable.setWidthPercentage(100);
                attendanceTable.addCell("Month");
                attendanceTable.addCell("Days Attended");
                attendanceTable.addCell("Total Days");
                attendanceTable.addCell("Percentage");
                attendanceTable.addCell("Status");

                double totalPercentage = 0.0;
                for (StudentAttendance a : attendanceList) {
                    attendanceTable.addCell(a.getMonth());
                    attendanceTable.addCell(String.valueOf(a.getNoOfDaysAttended()));
                    attendanceTable.addCell(String.valueOf(a.getTotalNoOfWorkingDays()));
                    attendanceTable.addCell(String.format("%.2f%%", a.getPercentage()));
                    attendanceTable.addCell(a.getStatus());
                    totalPercentage += a.getPercentage();
                }

                document.add(attendanceTable);
                double avgAttendance = totalPercentage / attendanceList.size();
                document.add(Chunk.NEWLINE);
                document.add(new Paragraph(String.format("Average Attendance: %.2f%%", avgAttendance), normalFont));
            }
            document.add(Chunk.NEWLINE);

            // ===== MARKS SECTION =====
            document.add(new Paragraph("Marks Details", sectionHeader));
            if (marksList.isEmpty()) {
                document.add(new Paragraph("No marks records found.", normalFont));
            } else {
                PdfPTable marksTable = new PdfPTable(6);
                marksTable.setWidthPercentage(100);
                marksTable.addCell("Exam Type");
                marksTable.addCell("Year");
                marksTable.addCell("English");
                marksTable.addCell("Maths");
                marksTable.addCell("Science");
                marksTable.addCell("Standard");

                for (StudentMarks m : marksList) {
                    marksTable.addCell(m.getPfSelect());
                    marksTable.addCell(String.valueOf(m.getYear()));
                    marksTable.addCell(String.valueOf(m.getEnglish()));
                    marksTable.addCell(String.valueOf(m.getMaths()));
                    marksTable.addCell(String.valueOf(m.getScience()));
                    marksTable.addCell(m.getStandard());
                }

                document.add(marksTable);

                double avgEnglish = marksList.stream().mapToDouble(StudentMarks::getEnglish).average().orElse(0);
                double avgMaths = marksList.stream().mapToDouble(StudentMarks::getMaths).average().orElse(0);
                double avgScience = marksList.stream().mapToDouble(StudentMarks::getScience).average().orElse(0);

                document.add(Chunk.NEWLINE);
                document.add(new Paragraph(String.format(
                        "Average Marks → English: %.2f, Maths: %.2f, Science: %.2f",
                        avgEnglish, avgMaths, avgScience), normalFont));
            }

            // ===== FOOTER =====
            document.add(Chunk.NEWLINE);
            Paragraph footer = new Paragraph("Report Generated by Manhattan Associates ©", new Font(Font.HELVETICA, 10, Font.ITALIC));
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

            document.close();

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("❌ [ERROR] PDF generation failed: " + e.getMessage());
            throw new RuntimeException("Error generating student report: " + e.getMessage());
        }

        return new ByteArrayInputStream(out.toByteArray());
    }
}
