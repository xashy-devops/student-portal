package com.xashytech.university.dao;

import com.xashytech.university.model.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * Student Data Access Object
 * Handles database operations for Student entities
 */
@Repository
public class StudentDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private static final String INSERT_STUDENT = 
        "INSERT INTO students (student_id, first_name, last_name, email, phone_number, " +
        "date_of_birth, program, year, status, enrollment_date, gpa) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String SELECT_ALL_STUDENTS = 
        "SELECT * FROM students ORDER BY last_name, first_name";

    private static final String SELECT_STUDENT_BY_ID = 
        "SELECT * FROM students WHERE id = ?";

    private static final String SELECT_STUDENT_BY_STUDENT_ID = 
        "SELECT * FROM students WHERE student_id = ?";

    private static final String SELECT_STUDENT_BY_EMAIL = 
        "SELECT * FROM students WHERE email = ?";

    private static final String UPDATE_STUDENT = 
        "UPDATE students SET student_id = ?, first_name = ?, last_name = ?, email = ?, " +
        "phone_number = ?, date_of_birth = ?, program = ?, year = ?, status = ?, gpa = ? " +
        "WHERE id = ?";

    private static final String DELETE_STUDENT = 
        "DELETE FROM students WHERE id = ?";

    private static final String COUNT_STUDENTS = 
        "SELECT COUNT(*) FROM students";

    /**
     * Save a new student to the database
     */
    public Student save(Student student) {
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(INSERT_STUDENT, 
                new String[]{"id"});
            ps.setString(1, student.getStudentId());
            ps.setString(2, student.getFirstName());
            ps.setString(3, student.getLastName());
            ps.setString(4, student.getEmail());
            ps.setString(5, student.getPhoneNumber());
            ps.setDate(6, student.getDateOfBirth() != null ? 
                Date.valueOf(student.getDateOfBirth()) : null);
            ps.setString(7, student.getProgram());
            ps.setString(8, student.getYear());
            ps.setString(9, student.getStatus());
            ps.setDate(10, Date.valueOf(student.getEnrollmentDate()));
            ps.setDouble(11, student.getGpa() != null ? student.getGpa() : 0.0);
            return ps;
        }, keyHolder);

        Long generatedId = keyHolder.getKey().longValue();
        student.setId(generatedId);
        return student;
    }

    /**
     * Find all students
     */
    public List<Student> findAll() {
        return jdbcTemplate.query(SELECT_ALL_STUDENTS, new StudentRowMapper());
    }

    /**
     * Find student by ID
     */
    public Student findById(Long id) {
        try {
            return jdbcTemplate.queryForObject(SELECT_STUDENT_BY_ID, 
                new StudentRowMapper(), id);
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * Find student by student ID
     */
    public Student findByStudentId(String studentId) {
        try {
            return jdbcTemplate.queryForObject(SELECT_STUDENT_BY_STUDENT_ID, 
                new StudentRowMapper(), studentId);
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * Find student by email
     */
    public Student findByEmail(String email) {
        try {
            return jdbcTemplate.queryForObject(SELECT_STUDENT_BY_EMAIL, 
                new StudentRowMapper(), email);
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * Update an existing student
     */
    public Student update(Student student) {
        int rowsAffected = jdbcTemplate.update(UPDATE_STUDENT,
            student.getStudentId(),
            student.getFirstName(),
            student.getLastName(),
            student.getEmail(),
            student.getPhoneNumber(),
            student.getDateOfBirth() != null ? Date.valueOf(student.getDateOfBirth()) : null,
            student.getProgram(),
            student.getYear(),
            student.getStatus(),
            student.getGpa() != null ? student.getGpa() : 0.0,
            student.getId()
        );

        if (rowsAffected == 0) {
            throw new RuntimeException("Failed to update student with ID: " + student.getId());
        }

        return student;
    }

    /**
     * Delete student by ID
     */
    public boolean delete(Long id) {
        int rowsAffected = jdbcTemplate.update(DELETE_STUDENT, id);
        return rowsAffected > 0;
    }

    /**
     * Get total count of students
     */
    public int getStudentCount() {
        Integer count = jdbcTemplate.queryForObject(COUNT_STUDENTS, Integer.class);
        return count != null ? count : 0;
    }

    /**
     * Initialize database tables (for development/testing)
     */
    public void initializeDatabase() {
        String createTableSQL = 
            "CREATE TABLE IF NOT EXISTS students (" +
            "id BIGINT AUTO_INCREMENT PRIMARY KEY, " +
            "student_id VARCHAR(20) UNIQUE NOT NULL, " +
            "first_name VARCHAR(50) NOT NULL, " +
            "last_name VARCHAR(50) NOT NULL, " +
            "email VARCHAR(100) UNIQUE NOT NULL, " +
            "phone_number VARCHAR(20), " +
            "date_of_birth DATE, " +
            "program VARCHAR(100) NOT NULL, " +
            "year VARCHAR(10) NOT NULL, " +
            "status VARCHAR(20) DEFAULT 'ACTIVE', " +
            "enrollment_date DATE NOT NULL, " +
            "gpa DECIMAL(3,2) DEFAULT 0.00, " +
            "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
            "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP" +
            ")";

        jdbcTemplate.execute(createTableSQL);
    }

    /**
     * Insert sample data for testing
     */
    public void insertSampleData() {
        // Check if data already exists
        if (getStudentCount() > 0) {
            return;
        }

        String[] sampleStudents = {
            "('XTU20250001', 'John', 'Doe', 'john.doe@xashytech.edu', '555-0101', '2003-05-15', 'Computer Science', '2', 'ACTIVE', '2023-09-01', 3.75)",
            "('XTU20250002', 'Jane', 'Smith', 'jane.smith@xashytech.edu', '555-0102', '2002-08-22', 'Software Engineering', '3', 'ACTIVE', '2022-09-01', 3.92)",
            "('XTU20250003', 'Mike', 'Johnson', 'mike.johnson@xashytech.edu', '555-0103', '2004-01-10', 'Cybersecurity', '1', 'ACTIVE', '2024-09-01', 3.45)",
            "('XTU20250004', 'Sarah', 'Williams', 'sarah.williams@xashytech.edu', '555-0104', '2001-12-03', 'Data Science', '4', 'ACTIVE', '2021-09-01', 3.88)",
            "('XTU20250005', 'David', 'Brown', 'david.brown@xashytech.edu', '555-0105', '2003-07-18', 'DevOps Engineering', '2', 'ACTIVE', '2023-09-01', 3.67)"
        };

        String insertSampleSQL = 
            "INSERT INTO students (student_id, first_name, last_name, email, phone_number, " +
            "date_of_birth, program, year, status, enrollment_date, gpa) VALUES ";

        for (String student : sampleStudents) {
            jdbcTemplate.execute(insertSampleSQL + student);
        }
    }

    /**
     * Row mapper for Student objects
     */
    private static class StudentRowMapper implements RowMapper<Student> {
        @Override
        public Student mapRow(ResultSet rs, int rowNum) throws SQLException {
            Student student = new Student();
            student.setId(rs.getLong("id"));
            student.setStudentId(rs.getString("student_id"));
            student.setFirstName(rs.getString("first_name"));
            student.setLastName(rs.getString("last_name"));
            student.setEmail(rs.getString("email"));
            student.setPhoneNumber(rs.getString("phone_number"));
            
            Date dateOfBirth = rs.getDate("date_of_birth");
            if (dateOfBirth != null) {
                student.setDateOfBirth(dateOfBirth.toLocalDate());
            }
            
            student.setProgram(rs.getString("program"));
            student.setYear(rs.getString("year"));
            student.setStatus(rs.getString("status"));
            
            Date enrollmentDate = rs.getDate("enrollment_date");
            if (enrollmentDate != null) {
                student.setEnrollmentDate(enrollmentDate.toLocalDate());
            }
            
            student.setGpa(rs.getDouble("gpa"));
            return student;
        }
    }
}