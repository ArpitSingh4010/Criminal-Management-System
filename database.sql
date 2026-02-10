-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: management
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `criminal`
--

DROP TABLE IF EXISTS `criminal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `criminal` (
  `Case_id` varchar(45) NOT NULL,
  `Criminal_no` varchar(45) DEFAULT NULL,
  `Criminal_name` varchar(45) DEFAULT NULL,
  `Nick_name` varchar(45) DEFAULT NULL,
  `arrest_date` varchar(45) DEFAULT NULL,
  `dateOfcrime` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `age` varchar(45) DEFAULT NULL,
  `occupation` varchar(45) DEFAULT NULL,
  `BirthMark` varchar(45) DEFAULT NULL,
  `crimeType` varchar(45) DEFAULT NULL,
  `fatherName` varchar(45) DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `wanted` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Case_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `criminal`
--

LOCK TABLES `criminal` WRITE;
/*!40000 ALTER TABLE `criminal` DISABLE KEYS */;
INSERT INTO `criminal` VALUES 
('1','1001','Rajesh Kumar','Raju','15/01/2024','10/12/2023','Mumbai, Maharashtra','35','Businessman','Scar on left arm','Fraud','Suresh Kumar','male','no'),
('2','1002','Vikram Singh','Vikki','22/03/2024','18/02/2024','Delhi','28','Unemployed','Mole on neck','Robbery','Harpal Singh','male','yes'),
('3','1003','Amit Sharma','Bunty','05/06/2023','28/05/2023','Bangalore, Karnataka','32','Driver','Tattoo on right hand','Theft','Ramesh Sharma','male','no'),
('4','1004','Sanjay Verma','Sanju','18/09/2024','12/09/2024','Lucknow, UP','40','Shopkeeper','Birth mark on face','Kidnapping','Vijay Verma','male','yes'),
('5','1005','Deepak Yadav','Deep','30/11/2023','20/11/2023','Patna, Bihar','29','Laborer','Scar on forehead','Assault','Ramesh Yadav','male','no'),
('6','1006','Arjun Reddy','AJ','14/02/2024','05/02/2024','Hyderabad, Telangana','34','IT Professional','None','Cybercrime','Venkat Reddy','male','no'),
('7','1007','Rahul Gupta','Rahul','08/07/2024','01/07/2024','Jaipur, Rajasthan','37','Contractor','Mole on left cheek','Corruption','Mohan Gupta','male','yes'),
('8','1008','Suresh Patel','Suri','25/04/2023','15/04/2023','Ahmedabad, Gujarat','45','Trader','Scar on chin','Money Laundering','Keshav Patel','male','yes'),
('9','1009','Manoj Kumar','Monu','12/08/2024','03/08/2024','Kolkata, West Bengal','31','Driver','Burn mark on hand','Dacoity','Anil Kumar','male','yes'),
('10','1010','Ashok Mishra','Ashu','19/10/2023','10/10/2023','Bhopal, MP','38','Teacher','None','Domestic Violence','Prakash Mishra','male','no'),
('11','1011','Ravi Shankar','Ravi','27/05/2024','20/05/2024','Chennai, Tamil Nadu','33','Mechanic','Scar on leg','Extortion','Shankar Pillai','male','no'),
('12','1012','Praveen Roy','Praveen','03/12/2023','25/11/2023','Guwahati, Assam','30','Businessman','Mole on back','Smuggling','Pintu Roy','male','yes'),
('13','1013','Naveen Singh','Navi','16/01/2024','08/01/2024','Chandigarh','26','Unemployed','Tattoo on chest','Drug Trafficking','Balwant Singh','male','yes'),
('14','1014','Karan Malhotra','Karan','21/06/2024','12/06/2024','Pune, Maharashtra','42','Real Estate Agent','None','Forgery','Rajiv Malhotra','male','no'),
('15','1015','Ankit Joshi','Anku','09/03/2024','01/03/2024','Indore, MP','27','Student','Scar on eyebrow','Rape','Dinesh Joshi','male','yes'),
('16','1016','Sohan Lal','Sohan','14/09/2023','05/09/2023','Surat, Gujarat','44','Shopkeeper','Birth mark on neck','Arson','Mohan Lal','male','no'),
('17','1017','Pradeep Kumar','Pradeep','28/11/2024','18/11/2024','Noida, UP','36','Security Guard','None','Murder','Dinesh Kumar','male','yes'),
('18','1018','Santosh Rao','Santo','07/04/2024','30/03/2024','Mangalore, Karnataka','39','Fisher','Scar on palm','Human Trafficking','Ganesh Rao','male','yes'),
('19','1019','Jagdish Tiwari','Jaggu','23/07/2023','15/07/2023','Varanasi, UP','48','Priest','Mole on face','Cheating','Ramesh Tiwari','male','no'),
('20','1020','Mukesh Yadav','Mukesh','11/02/2024','02/02/2024','Agra, UP','35','Tour Guide','Tattoo on arm','Theft','Omkar Yadav','male','no'),
('21','1021','Dinesh Chauhan','Dinu','05/10/2024','25/09/2024','Nagpur, Maharashtra','41','Farmer','Scar on back','Robbery','Suresh Chauhan','male','no'),
('22','1022','Vijay Mehta','VJ','18/05/2023','10/05/2023','Surat, Gujarat','33','Diamond Trader','None','Fraud','Ashok Mehta','male','yes'),
('23','1023','Ramesh Nair','Ramesh','29/08/2024','20/08/2024','Kochi, Kerala','37','Shop Owner','Mole on shoulder','Extortion','Krishnan Nair','male','no'),
('24','1024','Ajay Kapoor','Ajay','12/01/2024','03/01/2024','Ludhiana, Punjab','30','Factory Worker','Scar on leg','Assault','Rajesh Kapoor','male','no'),
('25','1025','Harish Bhandari','Harry','26/06/2024','18/06/2024','Dehradun, Uttarakhand','34','Hotel Manager','None','Drug Trafficking','Mohan Bhandari','male','yes'),
('26','1026','Sunil Kumar','Sunil','14/12/2023','05/12/2023','Ranchi, Jharkhand','43','Mine Worker','Birth mark on arm','Dacoity','Anil Kumar','male','yes'),
('27','1027','Gopal Sharma','Gopal','08/03/2024','28/02/2024','Shimla, HP','38','Driver','Scar on forehead','Kidnapping','Rakesh Sharma','male','yes'),
('28','1028','Bharat Singh','Bharat','22/09/2024','12/09/2024','Jodhpur, Rajasthan','45','Camel Trader','Mole on chin','Smuggling','Gajendra Singh','male','yes'),
('29','1029','Kishore Reddy','Kishore','04/11/2023','28/10/2023','Vijayawada, AP','32','Software Engineer','None','Cybercrime','Ravi Reddy','male','no'),
('30','1030','Lokesh Gupta','Loki','19/07/2024','10/07/2024','Gwalior, MP','36','Politician','Tattoo on back','Corruption','Mahesh Gupta','male','yes'),
('31','1031','Manish Pandey','Manish','31/05/2023','22/05/2023','Allahabad, UP','40','Lawyer','None','Forgery','Shyam Pandey','male','no'),
('32','1032','Nitesh Singh','Nitesh','15/08/2024','05/08/2024','Patna, Bihar','29','Mechanic','Scar on hand','Theft','Rajendra Singh','male','no'),
('33','1033','Pankaj Jain','Pankaj','27/02/2024','18/02/2024','Jaipur, Rajasthan','35','Jeweller','Mole on ear','Money Laundering','Suresh Jain','male','yes'),
('34','1034','Ranjan Kumar','Ranjan','10/10/2024','01/10/2024','Siliguri, West Bengal','31','Tea Garden Worker','None','Murder','Ganesh Kumar','male','yes'),
('35','1035','Sanjiv Malhotra','Sanjiv','24/04/2023','15/04/2023','Amritsar, Punjab','44','Cloth Merchant','Scar on neck','Fraud','Arun Malhotra','male','no'),
('36','1036','Tarun Saxena','Tarun','06/12/2024','28/11/2024','Kanpur, UP','33','Engineer','Birth mark on face','Rape','Vivek Saxena','male','yes'),
('37','1037','Umesh Verma','Umesh','20/01/2024','12/01/2024','Raipur, Chhattisgarh','37','Government Employee','None','Corruption','Mahendra Verma','male','no'),
('38','1038','Vishal Thakur','Vishal','13/06/2024','05/06/2024','Jammu, J&K','28','Army Deserter','Tattoo on shoulder','Terrorism','Mohan Thakur','male','yes'),
('39','1039','Yash Pratap','Yash','28/09/2023','20/09/2023','Bhubaneswar, Odisha','34','Contractor','Scar on arm','Extortion','Pratap Singh','male','no'),
('40','1040','Aarav Choudhary','Aarav','11/11/2024','03/11/2024','Udaipur, Rajasthan','26','Student','None','Drug Trafficking','Vikram Choudhary','male','yes'),
('41','1041','Bhavesh Patel','Bhavesh','17/03/2024','08/03/2024','Vadodara, Gujarat','39','Factory Owner','Mole on forehead','Arson','Ramesh Patel','male','no'),
('42','1042','Chetan Rao','Chetan','02/07/2024','25/06/2024','Mysore, Karnataka','35','Bus Driver','Scar on cheek','Robbery','Suresh Rao','male','no'),
('43','1043','Devendra Yadav','Devendra','25/05/2023','18/05/2023','Muzaffarpur, Bihar','42','Farmer','None','Assault','Rameshwar Yadav','male','no'),
('44','1044','Firoz Khan','Firoz','09/08/2024','01/08/2024','Hyderabad, Telangana','31','Restaurant Owner','Birth mark on hand','Cheating','Abdul Khan','male','no'),
('45','1045','Ganesh Kulkarni','Ganesh','21/12/2023','14/12/2023','Nashik, Maharashtra','38','Wine Trader','Mole on neck','Smuggling','Dattatray Kulkarni','male','yes'),
('46','1046','Hemant Desai','Hemant','16/02/2024','08/02/2024','Rajkot, Gujarat','33','Automobile Dealer','Tattoo on leg','Theft','Jayesh Desai','male','no'),
('47','1047','Inder Mohan','Inder','30/10/2024','22/10/2024','Faridabad, Haryana','40','Property Dealer','Scar on face','Kidnapping','Mohan Singh','male','yes'),
('48','1048','Jitendra Kumar','Jitu','14/04/2024','06/04/2024','Gorakhpur, UP','36','Shopkeeper','None','Domestic Violence','Mukesh Kumar','male','no'),
('49','1049','Kamal Hassan','Kamal','28/06/2023','20/06/2023','Coimbatore, Tamil Nadu','41','Textile Worker','Mole on back','Vandalism','Hassan Ali','male','no'),
('50','1050','Lalit Singh','Lalit','03/09/2024','27/08/2024','Meerut, UP','34','Gym Trainer','Scar on shoulder','Human Trafficking','Jaswant Singh','male','yes');
/*!40000 ALTER TABLE `criminal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `case_types`
--

DROP TABLE IF EXISTS `case_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `case_types` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `case_type` varchar(50) NOT NULL,
  `description` text,
  `ipc_section` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case_types`
--

LOCK TABLES `case_types` WRITE;
/*!40000 ALTER TABLE `case_types` DISABLE KEYS */;
INSERT INTO `case_types` VALUES 
(1,'Murder','Intentional killing of another person with premeditation','Section 302 IPC'),
(2,'Robbery','Theft with use of force or threat of violence','Section 392 IPC'),
(3,'Theft','Taking someone\'s property without consent or permission','Section 378 IPC'),
(4,'Kidnapping','Unlawfully taking or detaining someone against their will','Section 363-373 IPC'),
(5,'Rape','Sexual violence and assault against a person without consent','Section 376 IPC'),
(6,'Fraud','Deception or cheating for financial or personal gain','Section 420 IPC'),
(7,'Drug Trafficking','Illegal trade, distribution, or possession of narcotics','NDPS Act'),
(8,'Cybercrime','Crimes involving computers, internet, or digital devices','IT Act 2000'),
(9,'Domestic Violence','Physical, emotional, or economic abuse within household','Section 498A IPC'),
(10,'Extortion','Obtaining money or property through threats or coercion','Section 383 IPC'),
(11,'Assault','Physical attack causing bodily harm to another person','Section 351 IPC'),
(12,'Corruption','Misuse of public office for personal or financial gain','Prevention of Corruption Act'),
(13,'Forgery','Making or using false documents with intent to deceive','Section 463 IPC'),
(14,'Dacoity','Robbery committed by five or more persons acting together','Section 395 IPC'),
(15,'Smuggling','Illegal import or export of prohibited goods across borders','Customs Act'),
(16,'Terrorism','Violence or threat used for political or religious objectives','UAPA'),
(17,'Money Laundering','Concealing the origins of illegally obtained money','PMLA'),
(18,'Human Trafficking','Trading humans for forced labor or sexual exploitation','Section 370 IPC'),
(19,'Arson','Deliberately setting fire to property or buildings','Section 435 IPC'),
(20,'Vandalism','Intentional destruction or damage to public or private property','Section 425 IPC');
/*!40000 ALTER TABLE `case_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laws`
--

DROP TABLE IF EXISTS `laws`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laws` (
  `law_id` int NOT NULL,
  `section` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `act_name` varchar(100) DEFAULT NULL,
  `offense_type` varchar(50) DEFAULT NULL,
  `punishment` varchar(255) DEFAULT NULL,
  `bailable` varchar(10) DEFAULT NULL,
  `cognizable` varchar(10) DEFAULT NULL,
  `compoundable` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`law_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laws`
--

LOCK TABLES `laws` WRITE;
/*!40000 ALTER TABLE `laws` DISABLE KEYS */;
INSERT INTO `laws` VALUES 
(101,'Section 302','Murder','Whoever commits murder shall be punished with death or imprisonment for life, and shall also be liable to fine','Indian Penal Code','Against Person','Death or Life Imprisonment and fine','No','Yes','No'),
(102,'Section 304','Culpable Homicide Not Amounting to Murder','Punishment for culpable homicide not amounting to murder','Indian Penal Code','Against Person','Imprisonment for life or up to 10 years and fine','No','Yes','No'),
(103,'Section 307','Attempt to Murder','Whoever does any act with such intention or knowledge and under such circumstances that if he by that act caused death, he would be guilty of murder','Indian Penal Code','Against Person','Imprisonment up to 10 years and fine; if hurt caused, life imprisonment','No','Yes','No'),
(104,'Section 376','Rape','Sexual intercourse by a man with a woman without her consent or against her will','Indian Penal Code','Sexual Offence','Rigorous imprisonment not less than 10 years, extendable to life and fine','No','Yes','No'),
(105,'Section 376A','Intercourse Causing Death or Persistent Vegetative State','Whoever commits an offense punishable under section 376 and in the course of such commission inflicts an injury which causes death or causes the woman to be in a persistent vegetative state','Indian Penal Code','Sexual Offence','Rigorous imprisonment not less than 20 years, extendable to life or death','No','Yes','No'),
(106,'Section 354','Assault or Criminal Force to Woman with Intent to Outrage her Modesty','Whoever assaults or uses criminal force to any woman, intending to outrage or knowing it to be likely that he will thereby outrage her modesty','Indian Penal Code','Against Women','Imprisonment up to 2 years or fine or both','No','Yes','No'),
(107,'Section 363','Kidnapping','Whoever kidnaps any person from India or from lawful guardianship','Indian Penal Code','Against Person','Imprisonment up to 7 years and fine','No','Yes','No'),
(108,'Section 366','Kidnapping, Abducting or Inducing Woman to Compel her Marriage','Whoever kidnaps or abducts any woman with intent that she may be compelled to marry any person against her will','Indian Penal Code','Against Women','Imprisonment up to 10 years and fine','No','Yes','No'),
(109,'Section 370','Trafficking of Persons','Whoever, for the purpose of exploitation, recruits, transports, harbours, transfers, or receives a person or persons','Indian Penal Code','Human Trafficking','Rigorous imprisonment not less than 7 years, extendable to 10 years and fine','No','Yes','No'),
(110,'Section 378','Theft','Whoever, intending to take dishonestly any movable property out of the possession of any person without that person\'s consent','Indian Penal Code','Against Property','Imprisonment up to 3 years or fine or both','Yes','No','No'),
(111,'Section 379','Punishment for Theft','Whoever commits theft shall be punished with imprisonment of either description for a term which may extend to three years, or with fine, or with both','Indian Penal Code','Against Property','Imprisonment up to 3 years or fine or both','Yes','No','No'),
(112,'Section 380','Theft in Dwelling House','Whoever commits theft in any building, tent or vessel used as a human dwelling','Indian Penal Code','Against Property','Imprisonment up to 7 years and fine','No','Yes','No'),
(113,'Section 392','Robbery','Whoever commits robbery shall be punished with rigorous imprisonment for a term which may extend to ten years, and shall also be liable to fine','Indian Penal Code','Against Property','Rigorous imprisonment up to 10 years and fine','No','Yes','No'),
(114,'Section 395','Dacoity','When five or more persons conjointly commit or attempt to commit a robbery, every person so committing is said to commit dacoity','Indian Penal Code','Against Property','Rigorous imprisonment for life or up to 10 years and fine','No','Yes','No'),
(115,'Section 396','Dacoity with Murder','If any one of five or more persons, who are conjointly committing dacoity, commits murder in so committing dacoity','Indian Penal Code','Against Property','Death or imprisonment for life or rigorous imprisonment up to 10 years and fine','No','Yes','No'),
(116,'Section 403','Dishonest Misappropriation of Property','Whoever dishonestly misappropriates or converts to his own use any movable property','Indian Penal Code','Against Property','Imprisonment up to 2 years or fine or both','Yes','No','No'),
(117,'Section 405','Criminal Breach of Trust','Whoever, being in any manner entrusted with property, or with any dominion over property, dishonestly misappropriates or converts to his own use that property','Indian Penal Code','Against Property','Imprisonment up to 3 years or fine or both','Yes','No','No'),
(118,'Section 406','Punishment for Criminal Breach of Trust','Whoever commits criminal breach of trust shall be punished with imprisonment of either description for a term which may extend to three years, or with fine, or with both','Indian Penal Code','Against Property','Imprisonment up to 3 years or fine or both','Yes','No','No'),
(119,'Section 420','Cheating and Dishonestly Inducing Delivery of Property','Whoever cheats and thereby dishonestly induces the person deceived to deliver any property to any person','Indian Penal Code','Against Property','Imprisonment up to 7 years and fine','No','Yes','No'),
(120,'Section 467','Forgery of Valuable Security, Will, etc.','Whoever forges a document which purports to be a valuable security or a will','Indian Penal Code','Against Property','Imprisonment for life or up to 10 years and fine','No','Yes','No'),
(121,'Section 471','Using as Genuine a Forged Document','Whoever fraudulently or dishonestly uses as genuine any document which he knows or has reason to believe to be a forged document','Indian Penal Code','Against Property','Same as for forgery','Depends','Yes','No'),
(122,'Section 498A','Husband or Relative of Husband of a Woman Subjecting her to Cruelty','Whoever, being the husband or the relative of the husband of a woman, subjects such woman to cruelty','Indian Penal Code','Against Women','Imprisonment up to 3 years and fine','No','Yes','No'),
(123,'Section 323','Punishment for Voluntarily Causing Hurt','Whoever, except in the case provided for by section 334, voluntarily causes hurt','Indian Penal Code','Against Person','Imprisonment up to 1 year or fine up to Rs.1000 or both','Yes','Yes','Yes'),
(124,'Section 324','Voluntarily Causing Hurt by Dangerous Weapons or Means','Whoever, except in the case provided for by section 334, voluntarily causes hurt by means of any instrument for shooting, stabbing or cutting','Indian Penal Code','Against Person','Imprisonment up to 3 years or fine or both','No','Yes','No'),
(125,'Section 325','Punishment for Voluntarily Causing Grievous Hurt','Whoever, except in the case provided for by section 335, voluntarily causes grievous hurt','Indian Penal Code','Against Person','Imprisonment up to 7 years and fine','No','Yes','No'),
(126,'Section 326','Voluntarily Causing Grievous Hurt by Dangerous Weapons or Means','Whoever, except in the case provided for by section 335, voluntarily causes grievous hurt by means of any instrument for shooting, stabbing or cutting','Indian Penal Code','Against Person','Imprisonment for life or up to 10 years and fine','No','Yes','No'),
(127,'Section 341','Punishment for Wrongful Restraint','Whoever wrongfully restrains any person shall be punished with simple imprisonment for a term which may extend to one month, or with fine which may extend to five hundred rupees, or with both','Indian Penal Code','Against Person','Simple imprisonment up to 1 month or fine up to Rs.500 or both','Yes','No','Yes'),
(128,'Section 342','Punishment for Wrongful Confinement','Whoever wrongfully confines any person shall be punished with imprisonment of either description for a term which may extend to one year, or with fine which may extend to one thousand rupees, or with both','Indian Penal Code','Against Person','Imprisonment up to 1 year or fine up to Rs.1000 or both','Yes','Yes','No'),
(129,'Section 384','Punishment for Extortion','Whoever commits extortion shall be punished with imprisonment of either description for a term which may extend to three years, or with fine, or with both','Indian Penal Code','Against Property','Imprisonment up to 3 years or fine or both','No','Yes','No'),
(130,'Section 389','Putting Person in Fear of Accusation of Offence, in Order to Commit Extortion','Whoever, in order to the committing of extortion, puts any person in fear of an accusation against that person or any other','Indian Penal Code','Against Property','Imprisonment up to 10 years and fine','No','Yes','No'),
(131,'Section 435','Mischief by Fire or Explosive Substance with Intent to Cause Damage','Whoever commits mischief by fire or any explosive substance intending to cause damage to any property','Indian Penal Code','Against Property','Imprisonment up to 7 years and fine','No','Yes','No'),
(132,'Section 436','Mischief by Fire or Explosive Substance with Intent to Destroy House','Whoever commits mischief by fire or any explosive substance, intending to cause the destruction of any building used as a place of worship or as a human dwelling','Indian Penal Code','Against Property','Imprisonment for life or up to 10 years and fine','No','Yes','No'),
(133,'Section 506','Punishment for Criminal Intimidation','Whoever commits criminal intimidation shall be punished with imprisonment of either description for a term which may extend to two years, or with fine, or with both','Indian Penal Code','Against Person','Imprisonment up to 2 years or fine or both; if threat to cause death, up to 7 years','Depends','Yes','No'),
(134,'Section 509','Word, Gesture or Act Intended to Insult the Modesty of a Woman','Whoever, intending to insult the modesty of any woman, utters any word, makes any sound or gesture, or exhibits any object','Indian Penal Code','Against Women','Simple imprisonment up to 3 years and fine','No','Yes','No'),
(135,'Section 8','Possession of Narcotic Drugs and Psychotropic Substances','Prohibition of certain operations related to narcotic drugs and psychotropic substances','NDPS Act','Drug Offence','Rigorous imprisonment up to 10 years and fine up to Rs.1 lakh (small quantity)','Depends','Yes','No'),
(136,'Section 20','Punishment for Contravention in Relation to Cannabis Plant and Cannabis','Production, manufacture, sale, purchase, transport or consumption of cannabis','NDPS Act','Drug Offence','Small quantity: up to 1 year or fine up to Rs.10,000; Commercial: 10-20 years and fine up to Rs.2 lakh','Depends','Yes','No'),
(137,'Section 21','Punishment for Contravention in Relation to Cocaine and Other Drugs','Production, manufacture, possession, sale, purchase, transport of cocaine, morphine, diacetyl-morphine or other drugs','NDPS Act','Drug Offence','Small quantity: up to 1 year and fine; Commercial: 10-20 years and fine minimum Rs.1 lakh','No','Yes','No'),
(138,'Section 66','Computer Related Offences','If any person, dishonestly or fraudulently, does any act referred to in the description of any computer resource','IT Act 2000','Cybercrime','Imprisonment up to 3 years or fine up to Rs.5 lakh or both','Yes','Yes','No'),
(139,'Section 66B','Punishment for Dishonestly Receiving Stolen Computer Resource or Communication Device','Whoever dishonestly receives or retains any stolen computer resource or communication device','IT Act 2000','Cybercrime','Imprisonment up to 3 years or fine up to Rs.1 lakh or both','Yes','Yes','No'),
(140,'Section 66C','Punishment for Identity Theft','Whoever, fraudulently or dishonestly makes use of the electronic signature, password or any other unique identification feature of any other person','IT Act 2000','Cybercrime','Imprisonment up to 3 years and fine up to Rs.1 lakh','Yes','Yes','No'),
(141,'Section 66D','Punishment for Cheating by Personation by Using Computer Resource','Whoever, by means of any communication device or computer resource cheats by personation','IT Act 2000','Cybercrime','Imprisonment up to 3 years and fine up to Rs.1 lakh','Yes','Yes','No'),
(142,'Section 66E','Punishment for Violation of Privacy','Whoever, intentionally or knowingly captures, publishes or transmits the image of a private area of any person without his or her consent','IT Act 2000','Cybercrime','Imprisonment up to 3 years or fine up to Rs.2 lakh or both','Yes','Yes','No'),
(143,'Section 67','Punishment for Publishing or Transmitting Obscene Material in Electronic Form','Whoever publishes or transmits or causes to be published or transmitted in electronic form any material which is lascivious or appeals to the prurient interest','IT Act 2000','Cybercrime','First conviction: imprisonment up to 3 years and fine up to Rs.5 lakh; Subsequent: up to 5 years and fine up to Rs.10 lakh','Yes','Yes','No'),
(144,'Section 7','Public Servant Taking Gratification Other than Legal Remuneration','Whoever, being a public servant, accepts any gratification other than legal remuneration as a motive or reward','Prevention of Corruption Act','Corruption','Imprisonment not less than 6 months up to 5 years and fine','No','Yes','No'),
(145,'Section 13','Criminal Misconduct by a Public Servant','A public servant is said to commit criminal misconduct if he habitually accepts or obtains illegal gratification or misappropriates property','Prevention of Corruption Act','Corruption','Imprisonment not less than 4 years up to 10 years and fine','No','Yes','No'),
(146,'Section 15','Offences Related to Elections','Whoever accepts or obtains or agrees to accept or attempts to obtain from any person for himself or for any other person any gratification as a motive or reward for inducing an elector to vote','Prevention of Corruption Act','Corruption','Imprisonment up to 1 year or fine or both','Yes','Yes','No'),
(147,'Section 3','Atrocities Against SC/ST Members','Whoever, not being a member of a Scheduled Caste or a Scheduled Tribe, commits specified offences against members of SC/ST communities','SC/ST (Prevention of Atrocities) Act','Against SC/ST','Imprisonment not less than 6 months up to 5 years and fine','No','Yes','No'),
(148,'Section 3/4','Dowry Death','Where the death of a woman is caused by burns or bodily injury or occurs otherwise than under normal circumstances within seven years of her marriage','Dowry Prohibition Act','Against Women','Imprisonment not less than 7 years up to life imprisonment','No','Yes','No'),
(149,'Section 4','Penalty for Giving or Taking Dowry','If any person, after the commencement of this Act, gives or takes or abets the giving or taking of dowry','Dowry Prohibition Act','Against Women','Imprisonment up to 5 years and fine not less than Rs.15,000 or dowry amount','No','Yes','No'),
(150,'Section 138','Dishonour of Cheque for Insufficiency of Funds','Where any cheque drawn by a person is returned by the bank unpaid for insufficiency of funds','Negotiable Instruments Act','Financial Crime','Imprisonment up to 2 years or fine up to twice the amount or both','Yes','No','Yes');
/*!40000 ALTER TABLE `laws` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `officers`
--

DROP TABLE IF EXISTS `officers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `officers` (
  `officer_id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `badge_number` varchar(50) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `years_of_service` int DEFAULT NULL,
  PRIMARY KEY (`officer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `officers`
--

LOCK TABLES `officers` WRITE;
/*!40000 ALTER TABLE `officers` DISABLE KEYS */;
INSERT INTO `officers` VALUES 
(1,'Rakesh Kumar Sharma',58,'Director General of Police','DGP001','State Police Headquarters','Maharashtra',35),
(2,'Anjali Bhardwaj',55,'Additional Director General of Police','ADGP002','Crime Branch','Delhi',32),
(3,'Vikram Singh Rathore',52,'Inspector General of Police','IGP003','Central Zone','Uttar Pradesh',30),
(4,'Priya Deshmukh',49,'Deputy Inspector General of Police','DIG004','Western Range','Karnataka',27),
(5,'Suresh Menon',47,'Superintendent of Police','SP005','Bangalore City','Karnataka',25),
(6,'Kavita Reddy',45,'Additional Superintendent of Police','ASP006','Cyber Crime','Telangana',22),
(7,'Rajesh Patel',43,'Deputy Superintendent of Police','DSP007','Traffic Division','Gujarat',20),
(8,'Meera Iyer',41,'Inspector','INS008','Economic Offences Wing','Tamil Nadu',18),
(9,'Anil Kumar Verma',39,'Inspector','INS009','Anti-Narcotics Cell','Madhya Pradesh',16),
(10,'Sunita Nair',37,'Sub-Inspector','SI010','Women Protection Cell','Kerala',14),
(11,'Ramesh Chandra Gupta',52,'Inspector General of Police','IGP011','Northern Range','Rajasthan',29),
(12,'Pooja Malhotra',44,'Superintendent of Police','SP012','Crime Investigation','Punjab',21),
(13,'Mahesh Joshi',48,'Deputy Inspector General of Police','DIG013','Special Branch','Haryana',26),
(14,'Deepika Rao',42,'Inspector','INS014','Homicide Division','Andhra Pradesh',19),
(15,'Sanjay Tripathi',40,'Inspector','INS015','Robbery Squad','Bihar',17),
(16,'Neha Kapoor',38,'Sub-Inspector','SI016','Missing Persons Bureau','Delhi',15),
(17,'Arjun Khanna',46,'Deputy Superintendent of Police','DSP017','Intelligence Unit','Jammu & Kashmir',23),
(18,'Swati Banerjee',36,'Sub-Inspector','SI018','Juvenile Justice','West Bengal',13),
(19,'Vivek Pandey',50,'Superintendent of Police','SP019','Rural Division','Chhattisgarh',28),
(20,'Ritu Saxena',35,'Assistant Sub-Inspector','ASI020','Local Police Station','Uttar Pradesh',12),
(21,'Karan Bedi',54,'Additional Director General of Police','ADGP021','Law and Order','Himachal Pradesh',31),
(22,'Nisha Agarwal',41,'Inspector','INS022','Fraud Investigation','Odisha',18),
(23,'Amit Chauhan',39,'Inspector','INS023','Special Task Force','Uttarakhand',16),
(24,'Roshni Mehta',37,'Sub-Inspector','SI024','Domestic Violence Cell','Goa',14),
(25,'Harsh Sinha',45,'Additional Superintendent of Police','ASP025','Highway Patrol','Jharkhand',22),
(26,'Tanvi Chopra',34,'Assistant Sub-Inspector','ASI026','Community Policing','Chandigarh',11),
(27,'Varun Tiwari',48,'Deputy Superintendent of Police','DSP027','Anti-Terrorism Squad','Maharashtra',25),
(28,'Simran Kaur',36,'Sub-Inspector','SI028','Cyber Security','Punjab',13),
(29,'Nikhil Dubey',42,'Inspector','INS029','Narcotics Control','Gujarat',19),
(30,'Aarti Sharma',40,'Inspector','INS030','Financial Crimes','Rajasthan',17),
(31,'Gaurav Singh',51,'Deputy Inspector General of Police','DIG031','Eastern Zone','Assam',28),
(32,'Pallavi Kulkarni',38,'Sub-Inspector','SI032','Victim Support','Karnataka',15),
(33,'Rohit Mishra',44,'Superintendent of Police','SP033','Metropolitan Police','Tamil Nadu',21),
(34,'Divya Jain',35,'Assistant Sub-Inspector','ASI034','Traffic Control','Madhya Pradesh',12),
(35,'Manish Kumar',49,'Deputy Superintendent of Police','DSP035','Crime Records','Bihar',26),
(36,'Shruti Raghavan',33,'Assistant Sub-Inspector','ASI036','Public Relations','Kerala',10),
(37,'Abhishek Yadav',43,'Inspector','INS037','Organized Crime','Uttar Pradesh',20),
(38,'Jyoti Pillai',39,'Inspector','INS038','Human Trafficking Unit','Andhra Pradesh',16),
(39,'Sachin Pathak',47,'Additional Superintendent of Police','ASP039','VIP Security','Delhi',24),
(40,'Madhuri Bose',37,'Sub-Inspector','SI040','Child Protection','West Bengal',14),
(41,'Ashok Rana',53,'Inspector General of Police','IGP041','Border Security','Gujarat',30),
(42,'Preeti Sood',41,'Inspector','INS042','Extortion Cell','Haryana',18),
(43,'Tarun Mallik',46,'Deputy Superintendent of Police','DSP043','Riot Control','Odisha',23),
(44,'Shweta Singh',34,'Assistant Sub-Inspector','ASI044','Emergency Response','Telangana',11),
(45,'Rahul Bhatt',50,'Superintendent of Police','SP045','Railway Police','Maharashtra',27),
(46,'Anita Devi',36,'Sub-Inspector','SI046','Women Safety','Bihar',13),
(47,'Mohit Grover',42,'Inspector','INS047','Corruption Investigation','Punjab',19),
(48,'Rekha Nambiar',38,'Sub-Inspector','SI048','Senior Citizen Helpdesk','Tamil Nadu',15),
(49,'Naveen Reddy',45,'Additional Superintendent of Police','ASP049','Anti-Dacoity Squad','Rajasthan',22),
(50,'Sneha Pandey',32,'Assistant Sub-Inspector','ASI050','Tourist Police','Himachal Pradesh',9);
/*!40000 ALTER TABLE `officers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `report_id` int NOT NULL,
  `report_type` varchar(100) DEFAULT NULL,
  `report_title` varchar(255) DEFAULT NULL,
  `description` text,
  `generated_date` date DEFAULT NULL,
  `generated_by` varchar(100) DEFAULT NULL,
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  `total_records` int DEFAULT NULL,
  `summary` text,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES 
(1,'Crime Statistics','Monthly Crime Report - January 2026','Comprehensive analysis of all crimes registered in January 2026','2026-02-01','Admin','2026-01-01','2026-01-31',45,'Total crimes: 45, Murder: 5, Theft: 15, Robbery: 8, Fraud: 10, Others: 7','Active'),
(2,'Crime Statistics','Quarterly Crime Analysis Q4 2025','Crime trends and patterns for October-December 2025','2026-01-05','Admin','2025-10-01','2025-12-31',128,'Total crimes: 128, Most common: Theft (35%), Murder cases increased by 12%','Active'),
(3,'Officer Statistics','Police Force Distribution Report','State-wise and rank-wise officer distribution analysis','2026-02-08','Admin',NULL,NULL,50,'Total Officers: 50, DGP: 3, IGP: 5, SP: 8, Inspector: 15, Sub-Inspector: 12, ASI: 7','Active'),
(4,'Crime Statistics','State-wise Crime Report 2025','Annual crime statistics grouped by state','2026-01-15','Admin','2025-01-01','2025-12-31',456,'Highest: Maharashtra (89), Lowest: Goa (12), Major crimes in urban areas','Active'),
(5,'Law Violations','Most Violated IPC Sections Report','Analysis of frequently violated law sections','2026-02-05','Admin','2025-01-01','2025-12-31',320,'Section 420 (Cheating): 45 cases, Section 379 (Theft): 67 cases, Section 323 (Assault): 38 cases','Active'),
(6,'Criminal Analysis','Age Demographics Report','Criminal age group distribution and patterns','2026-02-07','Admin',NULL,NULL,234,'Age 18-25: 35%, Age 26-35: 40%, Age 36-45: 18%, Age 46+: 7%','Active'),
(7,'Crime Statistics','Cybercrime Trend Report 2025','Analysis of cybercrimes and IT Act violations','2026-01-20','Admin','2025-01-01','2025-12-31',87,'Total cybercrimes: 87, Identity theft: 25, Online fraud: 35, Data breach: 15, Others: 12','Active'),
(8,'Criminal Analysis','Wanted Criminals Report','List and analysis of criminals currently wanted','2026-02-08','Admin',NULL,NULL,23,'Total wanted: 23, Murder cases: 8, Robbery: 7, Kidnapping: 5, Fraud: 3','Active'),
(9,'Crime Statistics','Drug Offences Report 2025','NDPS Act violations and drug trafficking cases','2026-01-25','Admin','2025-01-01','2025-12-31',56,'Total drug cases: 56, Cannabis: 28, Cocaine: 12, Heroin: 10, Others: 6','Active'),
(10,'Case Analysis','Case Resolution Time Analysis','Average time taken to resolve different types of cases','2026-02-03','Admin','2025-01-01','2025-12-31',178,'Avg resolution: 45 days, Theft: 30 days, Murder: 120 days, Fraud: 60 days','Active'),
(11,'Crime Statistics','Violence Against Women Report','Cases under crimes against women category','2026-02-06','Admin','2025-01-01','2025-12-31',92,'Total cases: 92, Domestic violence: 35, Assault (354): 28, Dowry: 15, Others: 14','Active'),
(12,'Officer Statistics','Officer Recruitment Report 2025','Analysis of new officers recruited in 2025','2026-01-10','Admin','2025-01-01','2025-12-31',12,'New recruits: 12, Sub-Inspectors: 7, ASI: 5, Departments: Traffic (4), Cyber (3), Others (5)','Active'),
(13,'Crime Statistics','Organized Crime Report','Analysis of organized crime and gang activities','2026-01-28','Admin','2025-01-01','2025-12-31',34,'Total cases: 34, Dacoity: 12, Extortion: 15, Human trafficking: 7','Active'),
(14,'Law Violations','Non-Bailable Offences Report','Cases registered under non-bailable sections','2026-02-02','Admin','2025-01-01','2025-12-31',156,'Total non-bailable: 156, Murder (302): 23, Rape (376): 18, Dacoity: 15, Others: 100','Active'),
(15,'Crime Statistics','Corruption Cases Report 2025','Cases under Prevention of Corruption Act','2026-01-18','Admin','2025-01-01','2025-12-31',28,'Total corruption cases: 28, Public servants: 18, Bribery: 15, Misconduct: 13','Active'),
(16,'Criminal Analysis','Repeat Offenders Analysis','Study of criminals with multiple offences','2026-02-04','Admin',NULL,NULL,45,'Repeat offenders: 45, 2 offences: 28, 3+ offences: 17, Most common: Theft and fraud','Active'),
(17,'Crime Statistics','Property Crime Report','Analysis of crimes against property','2026-01-22','Admin','2025-01-01','2025-12-31',234,'Total property crimes: 234, Theft: 120, Robbery: 56, Burglary: 35, Arson: 12, Others: 11','Active'),
(18,'Crime Statistics','Juvenile Crime Report 2025','Cases involving juveniles in conflict with law','2026-01-30','Admin','2025-01-01','2025-12-31',23,'Juvenile cases: 23, Age 14-16: 12, Age 16-18: 11, Theft: 10, Assault: 8, Others: 5','Active'),
(19,'Law Violations','Traffic Violations Report','Analysis of traffic-related offences','2026-02-01','Admin','2025-01-01','2025-12-31',567,'Total violations: 567, Drunk driving: 45, Over-speeding: 234, No license: 78, Others: 210','Active'),
(20,'Crime Statistics','Seasonal Crime Pattern Report','Crime trends across different seasons in 2025','2026-01-12','Admin','2025-01-01','2025-12-31',489,'Summer crimes: 145, Monsoon: 98, Winter: 123, Spring: 123. Peak: Summer months','Active'),
(21,'Criminal Analysis','Gender-wise Crime Analysis','Distribution of crimes by criminal gender','2026-02-07','Admin',NULL,NULL,234,'Male offenders: 89%, Female offenders: 11%, Joint crimes: 5%','Active'),
(22,'Crime Statistics','Economic Offences Report 2025','Financial crimes and white-collar offences','2026-01-16','Admin','2025-01-01','2025-12-31',67,'Total economic crimes: 67, Cheating (420): 28, Forgery: 18, Breach of trust: 12, Others: 9','Active'),
(23,'Officer Statistics','Department-wise Officer Distribution','Officers assigned to various departments','2026-02-08','Admin',NULL,NULL,50,'Crime Branch: 12, Cyber: 6, Traffic: 8, Narcotics: 5, Special Branch: 7, Others: 12','Active'),
(24,'Crime Statistics','Night Crime Analysis Report','Crimes occurring during night hours','2026-01-26','Admin','2025-01-01','2025-12-31',178,'Night crimes (8PM-6AM): 178, Robbery: 45, Burglary: 56, Assault: 38, Others: 39','Active'),
(25,'Law Violations','SC/ST Atrocities Report 2025','Cases under SC/ST Prevention of Atrocities Act','2026-01-14','Admin','2025-01-01','2025-12-31',15,'Total SC/ST cases: 15, Assault: 6, Intimidation: 5, Economic exploitation: 4','Active'),
(26,'Crime Statistics','Weapon-based Crime Report','Analysis of crimes involving weapons','2026-02-05','Admin','2025-01-01','2025-12-31',89,'Weapon crimes: 89, Firearms: 23, Sharp weapons: 45, Explosives: 8, Others: 13','Active'),
(27,'Criminal Analysis','Occupation-wise Criminal Profile','Criminal distribution by occupation','2026-02-06','Admin',NULL,NULL,234,'Unemployed: 45%, Laborers: 25%, Business: 15%, Students: 8%, Others: 7%','Active'),
(28,'Crime Statistics','Kidnapping Cases Report 2025','Analysis of kidnapping and abduction cases','2026-01-24','Admin','2025-01-01','2025-12-31',34,'Total kidnapping: 34, For ransom: 12, Women: 15, Children: 7, All rescued: 28, Pending: 6','Active'),
(29,'Law Violations','Cognizable Offences Report','Cases registered as cognizable offences','2026-02-03','Admin','2025-01-01','2025-12-31',378,'Cognizable cases: 378, Immediate arrests: 245, Investigation ongoing: 98, Closed: 35','Active'),
(30,'Crime Statistics','Annual Crime Summary 2025','Comprehensive annual report of all crimes in 2025','2026-01-31','Admin','2025-01-01','2025-12-31',489,'Total crimes 2025: 489, Increase from 2024: 8%, Conviction rate: 67%, Case closure: 72%','Active');
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES 
('admin','admin123');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-10
