import os
import psycopg2

# Get database URL from environment variable
# DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://admin:admin@localhost:5432/students_db")
DATABASE_URL = "postgresql://admin:admin@localhost:5432/students_db"


# Define table schema
TABLE_SCHEMA = """
CREATE TABLE IF NOT EXISTS students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INTEGER NOT NULL,
    grade VARCHAR(5) NOT NULL
);
"""

try:
    # Connect to the database
    conn = psycopg2.connect(DATABASE_URL)
    cursor = conn.cursor()
    
    # Create table
    cursor.execute(TABLE_SCHEMA)
    conn.commit()

    print("✅ Table created successfully!")

except Exception as e:
    print(f"❌ Error creating table: {e}")

finally:
    cursor.close()
    conn.close()
