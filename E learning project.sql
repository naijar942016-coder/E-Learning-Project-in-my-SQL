-- ============================================================
--  E-LEARNING PLATFORM DATABASE
--  Complete MySQL Script: Schema + Data + Queries
-- ============================================================

-- 1. CREATE DATABASE
-- ============================================================
CREATE DATABASE IF NOT EXISTS elearning_platform;
USE elearning_platform;

-- ============================================================
-- 2. CREATE TABLES
-- ============================================================

-- Table 1: Learners
CREATE TABLE learners (
    learner_id    INT           AUTO_INCREMENT PRIMARY KEY,
    full_name     VARCHAR(100)  NOT NULL,
    email         VARCHAR(150)  NOT NULL UNIQUE,
    country       VARCHAR(80)   NOT NULL,
    joined_date   DATE          NOT NULL
);

-- Table 2: Courses
CREATE TABLE courses (
    course_id     INT           AUTO_INCREMENT PRIMARY KEY,
    course_name   VARCHAR(200)  NOT NULL,
    category      VARCHAR(80)   NOT NULL,
    unit_price    DECIMAL(8,2)  NOT NULL,
    instructor    VARCHAR(100)  NOT NULL
);

-- Table 3: Purchases
CREATE TABLE purchases (
    purchase_id   INT           AUTO_INCREMENT PRIMARY KEY,
    learner_id    INT           NOT NULL,
    course_id     INT           NOT NULL,
    quantity      INT           NOT NULL DEFAULT 1,
    purchase_date DATE          NOT NULL,
    CONSTRAINT fk_learner FOREIGN KEY (learner_id) REFERENCES learners(learner_id),
    CONSTRAINT fk_course  FOREIGN KEY (course_id)  REFERENCES courses(course_id)
);

-- ============================================================
-- 3. INSERT SAMPLE DATA
-- ============================================================

-- Learners (5 records)
INSERT INTO learners (full_name, email, country, joined_date) VALUES
('Arjun Sharma',    'arjun.sharma@email.com',    'India',         '2023-01-15'),
('Priya Nair',      'priya.nair@email.com',      'India',         '2023-03-20'),
('Carlos Rivera',   'carlos.rivera@email.com',   'Mexico',        '2023-05-10'),
('Emily Chen',      'emily.chen@email.com',      'United States', '2023-07-08'),
('Fatima Al-Zahra', 'fatima.alzahra@email.com',  'UAE',           '2023-09-25');

-- Courses (5 records across 4 categories)
INSERT INTO courses (course_name, category, unit_price, instructor) VALUES
('Python for Data Science',          'Data Science',    49.99, 'Dr. Meera Iyer'),
('Machine Learning A–Z',             'Data Science',    79.99, 'Prof. James Liu'),
('Full Stack Web Development',       'Web Development', 59.99, 'Sarah Thompson'),
('React & Node.js Bootcamp',         'Web Development', 69.99, 'Alex Kumar'),
('Digital Marketing Fundamentals',   'Marketing',       39.99, 'Nina Patel'),
('Cybersecurity Essentials',         'IT & Security',   54.99, 'Mark Owens');

-- Purchases (8 records)
INSERT INTO purchases (learner_id, course_id, quantity, purchase_date) VALUES
(1, 1, 1, '2023-02-10'),   -- Arjun → Python for Data Science
(1, 2, 1, '2023-04-05'),   -- Arjun → Machine Learning A-Z
(2, 3, 2, '2023-06-15'),   -- Priya → Full Stack Web Development
(2, 5, 1, '2023-08-20'),   -- Priya → Digital Marketing Fundamentals
(3, 3, 1, '2023-07-01'),   -- Carlos → Full Stack Web Development
(3, 4, 1, '2023-09-10'),   -- Carlos → React & Node.js Bootcamp
(4, 1, 1, '2023-10-05'),   -- Emily → Python for Data Science
(4, 6, 2, '2023-11-18'),   -- Emily → Cybersecurity Essentials
(5, 2, 1, '2023-12-01');   -- Fatima → Machine Learning A-Z

-- ============================================================
-- 4. DATA EXPLORATION USING JOINS
-- ============================================================

-- 4a. INNER JOIN — Learners who have made purchases (with full details)
SELECT
    l.full_name                             AS learner_name,
    l.country,
    c.course_name,
    c.category,
    p.quantity,
    FORMAT(p.quantity * c.unit_price, 2)    AS total_amount,
    p.purchase_date
FROM purchases p
INNER JOIN learners l ON p.learner_id = l.learner_id
INNER JOIN courses  c ON p.course_id  = c.course_id
ORDER BY l.full_name, p.purchase_date;

-- 4b. LEFT JOIN — All learners, including those with no purchases
SELECT
    l.full_name                                        AS learner_name,
    l.country,
    COALESCE(c.course_name, 'No Purchase Yet')         AS course_name,
    COALESCE(c.category,    'N/A')                     AS category,
    COALESCE(p.quantity,    0)                         AS quantity,
    FORMAT(COALESCE(p.quantity * c.unit_price, 0), 2)  AS total_amount,
    p.purchase_date
FROM learners l
LEFT JOIN purchases p ON l.learner_id = p.learner_id
LEFT JOIN courses   c ON p.course_id  = c.course_id
ORDER BY l.full_name, p.purchase_date;

-- 4c. RIGHT JOIN — All courses, including those with no purchases
SELECT
    COALESCE(l.full_name, 'No Learner Yet')            AS learner_name,
    c.course_name,
    c.category,
    COALESCE(p.quantity, 0)                            AS quantity,
    FORMAT(COALESCE(p.quantity * c.unit_price, 0), 2)  AS total_amount,
    p.purchase_date
FROM purchases p
RIGHT JOIN courses  c ON p.course_id  = c.course_id
LEFT  JOIN learners l ON p.learner_id = l.learner_id
ORDER BY c.course_name, l.full_name;

-- ============================================================
-- 5. ANALYTICAL QUERIES
-- ============================================================

-- Q1. Each learner's total spending along with their country
SELECT
    l.full_name                              AS learner_name,
    l.country,
    FORMAT(SUM(p.quantity * c.unit_price), 2) AS total_spent
FROM learners l
INNER JOIN purchases p ON l.learner_id = p.learner_id
INNER JOIN courses   c ON p.course_id  = c.course_id
GROUP BY l.learner_id, l.full_name, l.country
ORDER BY SUM(p.quantity * c.unit_price) DESC;

-- Q2. Top 3 most purchased courses by total quantity sold
SELECT
    c.course_name,
    c.category,
    SUM(p.quantity)                          AS total_quantity_sold,
    FORMAT(SUM(p.quantity * c.unit_price), 2) AS total_revenue
FROM courses  c
INNER JOIN purchases p ON c.course_id = p.course_id
GROUP BY c.course_id, c.course_name, c.category
ORDER BY total_quantity_sold DESC
LIMIT 3;

-- Q3. Each course category's total revenue and unique learner count
SELECT
    c.category,
    FORMAT(SUM(p.quantity * c.unit_price), 2) AS total_revenue,
    COUNT(DISTINCT p.learner_id)              AS unique_learners
FROM courses  c
INNER JOIN purchases p ON c.course_id = p.course_id
GROUP BY c.category
ORDER BY SUM(p.quantity * c.unit_price) DESC;

-- Q4. Learners who purchased courses from MORE than one category
SELECT
    l.full_name                  AS learner_name,
    l.country,
    COUNT(DISTINCT c.category)   AS categories_purchased
FROM learners l
INNER JOIN purchases p ON l.learner_id = p.learner_id
INNER JOIN courses   c ON p.course_id  = c.course_id
GROUP BY l.learner_id, l.full_name, l.country
HAVING COUNT(DISTINCT c.category) > 1
ORDER BY categories_purchased DESC;

-- Q5. Courses that have NOT been purchased at all
SELECT
    c.course_id,
    c.course_name,
    c.category,
    FORMAT(c.unit_price, 2) AS unit_price
FROM courses c
LEFT JOIN purchases p ON c.course_id = p.course_id
WHERE p.purchase_id IS NULL
ORDER BY c.category, c.course_name;

-- ============================================================
-- END OF SCRIPT
-- ============================================================