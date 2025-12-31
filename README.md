![Project Pipeline](walmart_project-pipelines.png)


# Walmart Sales Analytics

This project focuses on analyzing Walmart sales data. The dataset was obtained via the **Kaggle API**, processed in **VS Code**, and imported into **PostgreSQL** for analysis. The project demonstrates the full workflow from **data acquisition** to **business insights**.

---

## Project Workflow

### Step 1: Get the Dataset via Kaggle API
- Install the Kaggle Python package.
- Generate your Kaggle API token (`kaggle.json`) from your Kaggle account.
- Place `kaggle.json` in the `.kaggle` folder.
- Use the Kaggle API commands to download the Walmart dataset.
- Extract the dataset into a working folder.

### Step 2: Load and Preprocess Data in VS Code
- Open VS Code and create a Python script.
- Read the CSV dataset using **Pandas**.
- Clean the data: handle missing values, correct data types, and standardize columns.
- Save the cleaned dataset for database import.

### Step 3: Import Data into PostgreSQL
- Create a database and a table matching the dataset structure.
- Import the cleaned CSV file into PostgreSQL using `\copy` or other import tools.

### Step 4: Analytical Questions Solved
The project focuses on answering key business and analytical questions, including:

1. Exploratory analysis: 
   - Counting transactions by payment method, city, and branch.
2. Branch-wise and category-wise insights:
   - Identifying highest-rated categories.
   - Finding busiest days and preferred payment methods per branch.
3. Sales and profit analysis:
   - Calculating total quantity sold, total profit per category.
   - Categorizing sales into shifts (morning, afternoon, evening).
4. Revenue comparisons:
   - Determining branches with revenue decrease compared to previous years.

> All questions were solved **independently** using SQL queries on PostgreSQL.

---

## Tools and Technologies
- **Kaggle API**: to fetch the dataset.  
- **VS Code**: for data preprocessing and scripting.  
- **Python & Pandas**: for cleaning and preparing the dataset.  
- **PostgreSQL**: for storing data and performing SQL analysis.  
- **SQL**: for querying and answering analytical questions.

---

## Key Takeaways
- Built a complete workflow from **data acquisition to analysis**.  
- Learned to clean and structure real-world datasets.  
- Practiced writing SQL queries for meaningful business insights.  
- Gained experience with PostgreSQL database operations and Python data preprocessing.

---

## License
This project is licensed under the MIT License.
