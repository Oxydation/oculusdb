rmdir /S /Q C:\Users\Administrator\Documents\oculusdb_group1
git clone https://github.com/Oxydation/oculusdb.git C:\Users\Administrator\Documents\oculusdb_group1
cd C:\Users\Administrator\Documents\oculusdb_group1
C:\xampp\mysql\bin\mysql.exe --default-character-set=utf8 --user=root --database=oculus_a < .\oculusdb_wb.sql
C:\xampp\mysql\bin\mysql.exe --default-character-set=utf8 --debug-info --user=root --database=oculus_a < .\fillDB.sql
pause