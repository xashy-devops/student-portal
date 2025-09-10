package com.xashytech.university.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import javax.sql.DataSource;

/**
 * Spring MVC Configuration
 * Configures the web application context
 */
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.xashytech.university")
@PropertySource("classpath:application.properties")
public class WebConfig implements WebMvcConfigurer {

    @Value("${db.url:jdbc:h2:mem:testdb}")
    private String dbUrl;

    @Value("${db.username:sa}")
    private String dbUsername;

    @Value("${db.password:}")
    private String dbPassword;

    @Value("${db.driver:org.h2.Driver}")
    private String dbDriver;

    /**
     * Configure View Resolver for JSP pages
     */
    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setViewClass(JstlView.class);
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        return resolver;
    }

    /**
     * Configure DataSource
     */
    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName(dbDriver);
        dataSource.setUrl(dbUrl);
        dataSource.setUsername(dbUsername);
        dataSource.setPassword(dbPassword);
        return dataSource;
    }

    /**
     * Configure JdbcTemplate
     */
    @Bean
    public JdbcTemplate jdbcTemplate(DataSource dataSource) {
        return new JdbcTemplate(dataSource);
    }

    /**
     * Configure static resource handling
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/static/**")
                .addResourceLocations("/static/");
        registry.addResourceHandler("/css/**")
                .addResourceLocations("/static/css/");
        registry.addResourceHandler("/js/**")
                .addResourceLocations("/static/js/");
        registry.addResourceHandler("/images/**")
                .addResourceLocations("/static/images/");
    }
}

/**
 * Application Configuration for different environments
 */
@Configuration
@PropertySource("classpath:application-${spring.profiles.active:dev}.properties")
class AppConfig {

    /**
     * Database initialization for development
     */
    @Bean
    public DatabaseInitializer databaseInitializer(JdbcTemplate jdbcTemplate) {
        return new DatabaseInitializer(jdbcTemplate);
    }

    /**
     * Database initializer class
     */
    public static class DatabaseInitializer {
        private final JdbcTemplate jdbcTemplate;

        public DatabaseInitializer(JdbcTemplate jdbcTemplate) {
            this.jdbcTemplate = jdbcTemplate;
            initializeDatabase();
        }

        private void initializeDatabase() {
            // Create students table
            String createStudentsTable = 
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

            jdbcTemplate.execute(createStudentsTable);

            // Insert sample data if table is empty
            Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM students", Integer.class);
            if (count == null || count == 0) {
                insertSampleData();
            }
        }

        private void insertSampleData() {
            String insertSQL = 
                "INSERT INTO students (student_id, first_name, last_name, email, phone_number, " +
                "date_of_birth, program, year, status, enrollment_date, gpa) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            Object[][] sampleData = {
                {"XTU20250001", "John", "Doe", "john.doe@xashytech.edu", "555-0101", "2003-05-15", "Computer Science", "2", "ACTIVE", "2023-09-01", 3.75},
                {"XTU20250002", "Jane", "Smith", "jane.smith@xashytech.edu", "555-0102", "2002-08-22", "Software Engineering", "3", "ACTIVE", "2022-09-01", 3.92},
                {"XTU20250003", "Mike", "Johnson", "mike.johnson@xashytech.edu", "555-0103", "2004-01-10", "Cybersecurity", "1", "ACTIVE", "2024-09-01", 3.45},
                {"XTU20250004", "Sarah", "Williams", "sarah.williams@xashytech.edu", "555-0104", "2001-12-03", "Data Science", "4", "ACTIVE", "2021-09-01", 3.88},
                {"XTU20250005", "David", "Brown", "david.brown@xashytech.edu", "555-0105", "2003-07-18", "DevOps Engineering", "2", "ACTIVE", "2023-09-01", 3.67}
            };

            for (Object[] student : sampleData) {
                jdbcTemplate.update(insertSQL, student);
            }

            System.out.println("Sample data inserted successfully!");
        }
    }
}