@echo off
echo ====================================
echo Creating Users Table
echo ====================================
echo.

echo Dropping existing users table if exists...
mysql -u root -pAyush@25 management -e "DROP TABLE IF EXISTS users;"

echo.
echo Creating users table structure...
mysql -u root -pAyush@25 management -e "CREATE TABLE users (id int NOT NULL AUTO_INCREMENT, username varchar(50) NOT NULL, age int NOT NULL, email varchar(100) NOT NULL, password varchar(255) NOT NULL, phone varchar(15) NOT NULL, created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY (id), UNIQUE KEY username (username), UNIQUE KEY email (email)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;"

echo.
echo Inserting sample user data...
mysql -u root -pAyush@25 management < create_users_simple.sql

echo.
echo ====================================
echo Users Table Created Successfully!
echo ====================================
echo.

echo Displaying table structure:
mysql -u root -pAyush@25 management -e "DESCRIBE users;"

echo.
echo Total users in database:
mysql -u root -pAyush@25 management -e "SELECT COUNT(*) as Total_Users FROM users;"

echo.
echo Sample users (first 10):
mysql -u root -pAyush@25 management -e "SELECT id, username, age, email, phone FROM users LIMIT 10;"

echo.
pause
