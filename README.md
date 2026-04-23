# E-Learning-Project-in-my-SQL
An end-to-end E-Learning data analysis project using SQL. This project focuses on analyzing learner behavior, course performance, and sales insights through structured queries. It includes data cleaning, transformation, and analytical queries to derive meaningful business insights and support data-driven decision-making.
# 📊 E-Learning Platform Data Analysis (MySQL)

## 📌 Project Overview

This project is a complete **end-to-end SQL-based data analysis solution** for an E-Learning platform. It includes database design, data insertion, and advanced analytical queries to generate business insights.

The project demonstrates strong proficiency in:

* Database schema design
* Data relationships using foreign keys
* Data analysis using SQL joins and aggregations
* Real-world business problem solving

---

## 🎯 Objectives

* Design a structured relational database
* Analyze learner purchasing behavior
* Identify top-performing courses and categories
* Measure revenue generation
* Extract actionable business insights

---

## 🛠️ Tools & Technologies

* MySQL
* SQL (DDL, DML, Joins, Aggregations)

---

## 🗄️ Database Schema

The project consists of **3 main tables**:

### 1️⃣ Learners Table

Stores user information

* learner_id (Primary Key)
* full_name
* email
* country
* joined_date

### 2️⃣ Courses Table

Stores course details

* course_id (Primary Key)
* course_name
* category
* unit_price
* instructor

### 3️⃣ Purchases Table

Stores transaction details

* purchase_id (Primary Key)
* learner_id (Foreign Key)
* course_id (Foreign Key)
* quantity
* purchase_date

🔗 Relationships:

* One learner → Many purchases
* One course → Many purchases

---

## 📥 Data Insertion

* 5 learners
* 6 courses
* 9 purchase records

Data includes multiple countries, categories, and realistic purchase scenarios.

---

## 🔍 SQL Concepts Used

* INNER JOIN
* LEFT JOIN
* RIGHT JOIN
* GROUP BY
* HAVING
* ORDER BY
* Aggregate functions (SUM, COUNT)
* COALESCE()
* FORMAT()

---

## 📊 Data Exploration Queries

### 🔹 INNER JOIN

Displays only learners who made purchases

### 🔹 LEFT JOIN

Shows all learners (including those with no purchases)

### 🔹 RIGHT JOIN

Shows all courses (including those not purchased)

---

## 📈 Key Analytical Queries

### 1️⃣ Total Spending per Learner

* Calculates each learner's total spending
* Helps identify high-value customers

### 2️⃣ Top 3 Most Purchased Courses

* Based on total quantity sold
* Useful for marketing focus

### 3️⃣ Revenue by Course Category

* Total revenue per category
* Counts unique learners

### 4️⃣ Multi-Category Learners

* Learners who purchased from multiple categories
* Indicates highly engaged users

### 5️⃣ Courses with No Purchases

* Identifies underperforming courses

---

## 📊 Key Insights

* Data Science and Web Development courses generate high revenue
* Some learners purchase across multiple categories
* A few courses dominate total sales
* Certain courses have zero purchases (opportunity for improvement)

---

## 💡 Business Recommendations

* Focus marketing on top-selling courses
* Improve or promote low-performing courses
* Offer bundle deals across categories
* Target high-spending learners with premium content

---

## 🚀 How to Run This Project

1. Open MySQL Workbench (or any SQL tool)
2. Copy the full SQL script
3. Run the script step-by-step:

   * Create database
   * Create tables
   * Insert data
   * Execute queries
4. Analyze the outputs

---

## 📂 Project Structure

```
E-Learning-Project-in-my-SQL/
│
├── elearning_project.sql
├── README.md
└── report.pdf (optional)
```

---

## 🌟 Future Enhancements

* Add advanced SQL (CTEs, Window Functions)
* Integrate with Power BI for dashboards
* Add real-time analytics
* Expand dataset for deeper insights

---

## 🙌 Conclusion

This project showcases practical SQL skills by solving real-world business problems using structured data. It is ideal for demonstrating data analytics capabilities in portfolios and interviews.

---

## 📬 Contact

Feel free to connect for feedback or collaboration!
