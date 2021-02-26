-- Создать нового пользователя и задать ему права доступа на базу данных «Страны и города мира».

CREATE USER 'lesson7'@'localhost' IDENTIFIED BY 'lesson7';

GRANT ALL privileges ON geodata.* TO 'lesson7'@'localhost';

FLUSH privileges;

/* вывод из консоли после создания
$ mysql -ulesson7 -plesson7                                                            
mysql: [Warning] Using a password on the command line interface can be insecure.       
Welcome to the MySQL monitor.  Commands end with ; or \g.                              
Your MySQL connection id is 14                                                         
Server version: 8.0.19 MySQL Community Server - GPL                                    
                                                                                       
Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.           
                                                                                       
Oracle is a registered trademark of Oracle Corporation and/or its                      
affiliates. Other names may be trademarks of their respective                          
owners.                                                                                
                                                                                       
Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.         
                                                                                       
mysql> SELECT * FROM geodata._regions limit 2;                                         
+------+------------+-----------+                                                      
| id   | country_id | title     |                                                      
+------+------------+-----------+                                                      
|  875 |        137 | Imo State |                                                      
| 2188 |         80 | Pune      |                                                      
+------+------------+-----------+                                                      
2 rows in set (0.00 sec)   
*/                                                            
                                                                                       