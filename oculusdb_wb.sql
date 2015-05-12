-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: 83.212.126.222    Database: oculus_group1
-- ------------------------------------------------------
-- Server version	5.6.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `anamnesis`
--

DROP TABLE IF EXISTS `anamnesis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `anamnesis` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `patient` varchar(36) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_anamnesis_patient_idx` (`patient`),
  CONSTRAINT `fk_anamnesis_patient` FOREIGN KEY (`patient`) REFERENCES `patient` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment` (
  `calendarentry` varchar(36) NOT NULL,
  `version` int(11) DEFAULT '0',
  `patient` varchar(36) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`calendarentry`),
  KEY `fk_appointment_patient_idx` (`patient`),
  CONSTRAINT `fk_appointment_calendarentry` FOREIGN KEY (`calendarentry`) REFERENCES `calendarentry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_patient` FOREIGN KEY (`patient`) REFERENCES `patient` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendarentry`
--

DROP TABLE IF EXISTS `calendarentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendarentry` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `employee` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_calendarentry_employee_idx` (`employee`),
  CONSTRAINT `fk_calendarentry_employee` FOREIGN KEY (`employee`) REFERENCES `employee` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Tabellenstruktur für Tabelle `disease`
--

DROP TABLE IF EXISTS `disease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disease` (
  `id` varchar(36) CHARACTER SET utf8mb4 NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Table structure for table `diagnosis`
--

DROP TABLE IF EXISTS `diagnosis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diagnosis` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `appointment` varchar(36) DEFAULT NULL,  
  `disease` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_diagnosis_appointment_idx` (`appointment`),
  KEY `fk_diagnosis_disease_idx` (`disease`),
  CONSTRAINT `fk_diagnosis_appointment` FOREIGN KEY (`appointment`) REFERENCES `appointment` (`calendarentry`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_diagnosis_disease` FOREIGN KEY (`disease`) REFERENCES `disease` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor` (
  `employee` varchar(36) NOT NULL,
  `version` int(11) DEFAULT '0',
  `doctornumber` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`employee`),
  CONSTRAINT `fk_doctor_employee` FOREIGN KEY (`employee`) REFERENCES `employee` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drug`
--

DROP TABLE IF EXISTS `drug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drug` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drugintolerance`
--

DROP TABLE IF EXISTS `drugintolerance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drugintolerance` (
  `anamnesis` varchar(36) NOT NULL,
  `drug` varchar(36) NOT NULL,
  PRIMARY KEY (`anamnesis`,`drug`),
  KEY `fk_anamnesis_drug_drug_idx` (`drug`),
  CONSTRAINT `fk_anamnesis_drug_drug` FOREIGN KEY (`drug`) REFERENCES `drug` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_anamnesis_drug_anamnesis` FOREIGN KEY (`anamnesis`) REFERENCES `anamnesis` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(100) DEFAULT NULL,
  `phonenumber` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `streetnumber` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `socialsecuritynumber` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eyeprescription`
--

DROP TABLE IF EXISTS `eyeprescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eyeprescription` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `diagnosis` varchar(36) DEFAULT NULL,  
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_eyeprescription_diagnosis_idx` (`diagnosis`),
  CONSTRAINT `fk_eyeprescription_diagnosis` FOREIGN KEY (`diagnosis`) REFERENCES `diagnosis` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Tabellenstruktur für Tabelle `eyeprescriptionentry`
--

DROP TABLE IF EXISTS `eyeprescriptionentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eyeprescriptionentry` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `eyeprescription` varchar(36) DEFAULT NULL,
  `amblyopia` varchar(100) DEFAULT NULL,
  `side` varchar(100) DEFAULT NULL,
  `sphere` decimal(4,2) DEFAULT NULL,
  `cylinder` decimal(4,2) DEFAULT NULL,
  `axis` int(11) DEFAULT NULL,
  `prism` decimal(4,2) DEFAULT NULL,
  `base` int(11) DEFAULT NULL,
  `vertexdistance` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_eyeprescriptionentry_eyeprescription_idx` (`eyeprescription`),
  CONSTRAINT `fk_eyeprescriptionentry_eyeprescription` FOREIGN KEY (`eyeprescription`) REFERENCES `eyeprescription` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `insurance`
--
DROP TABLE IF EXISTS `insurance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insurance` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `measurement`
--

DROP TABLE IF EXISTS `measurement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measurement` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `appointment` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_measurements_appointment_idx` (`appointment`),
  CONSTRAINT `fk_measurements_appointment` FOREIGN KEY (`appointment`) REFERENCES `appointment` (`calendarentry`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `measuremententry`
--

DROP TABLE IF EXISTS `measuremententry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measuremententry` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `measurement` varchar(36) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `value` double DEFAULT '0',
  `unit` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_measuremententry_measurement_idx` (`measuremet`),
  CONSTRAINT `fk_measuremententry_measurement` FOREIGN KEY (`measurement`) REFERENCES `measurement` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orthoptist`
--

DROP TABLE IF EXISTS `orthoptist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orthoptist` (
  `employee` varchar(36) NOT NULL,
  `version` int(11) DEFAULT '0',
  PRIMARY KEY (`employee`),
  CONSTRAINT `fk_orthoptist_employee` FOREIGN KEY (`employee`) REFERENCES `employee` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(100) DEFAULT NULL,
  `phonenumber` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `streetnumber` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `socialsecuritynumber` varchar(255) DEFAULT NULL,
  `employer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_insurance`
--

DROP TABLE IF EXISTS `patient_insurance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_insurance` (
  `patient` varchar(36) NOT NULL,
  `insurance` varchar(36) NOT NULL,
  PRIMARY KEY (`patient`,`insurance`),
  KEY `fk_patient_insurance_insurance_idx` (`insurance`),
  CONSTRAINT `fk_patient_insurance_insurance` FOREIGN KEY (`insurance`) REFERENCES `insurance` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_insurance_patient` FOREIGN KEY (`patient`) REFERENCES `patient` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prescription`
--

DROP TABLE IF EXISTS `prescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prescription` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `expired` datetime DEFAULT NULL,
  `insurance` varchar(36) DEFAULT NULL,
  `diagnosis` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_prescription_diagnosis_idx` (`diagnosis`),
  KEY `fk_prescription_insurance_idx` (`insurance`),
  CONSTRAINT `fk_prescription_diagnosis` FOREIGN KEY (`diagnosis`) REFERENCES `diagnosis` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_prescription_insurance` FOREIGN KEY (`insurance`) REFERENCES `insurance` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prescriptionentry`
--

DROP TABLE IF EXISTS `prescriptionentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prescriptionentry` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `prescription` varchar(36) DEFAULT NULL,
  `drug` varchar(36) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_prescriptionentry_prescription_idx` (`prescription`),
  KEY `fk_prescriptionentry_drug_idx` (`drug`),
  CONSTRAINT `fk_prescriptionentry_drug` FOREIGN KEY (`drug`) REFERENCES `drug` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_prescriptionentry_prescription` FOREIGN KEY (`prescription`) REFERENCES `prescription` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `servicecode`
--
DROP TABLE IF EXISTS `servicecode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servicecode` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `code` varchar(40) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `points` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patient_insurance`
--
DROP TABLE IF EXISTS `appointment_servicecode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment_servicecode` (
  `appointment` varchar(36) NOT NULL,
  `servicecode` varchar(36) NOT NULL,
  PRIMARY KEY (`appointment`,`servicecode`),
  KEY `fk_appointment_servicecode_servicecode_idx` (`servicecode`),
  CONSTRAINT `fk_appointment_servicecode_servicecode` FOREIGN KEY (`servicecode`) REFERENCES `servicecode` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_servicecode_appointment` FOREIGN KEY (`appointment`) REFERENCES `appointment` (`calendarentry`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue_employee`
--

DROP TABLE IF EXISTS `queue_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue_employee` (
  `queue` varchar(36) NOT NULL,
  `employee` varchar(36) NOT NULL,
  PRIMARY KEY (`queue`,`employee`),
  KEY `fk_queue_employee_employee_idx` (`employee`),
  CONSTRAINT `fk_queue_employee_employee` FOREIGN KEY (`employee`) REFERENCES `employee` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_queue_employee_queue` FOREIGN KEY (`queue`) REFERENCES `queue` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queueentry`
--

DROP TABLE IF EXISTS `queueentry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queueentry` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `queue` varchar(36) DEFAULT NULL,
  `appointment` varchar(36) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_queueentry_queue_idx` (`queue`),
  KEY `fk_queueentry_appointment_idx` (`appointment`),
  CONSTRAINT `fk_queueentry_appointment` FOREIGN KEY (`appointment`) REFERENCES `appointment` (`calendarentry`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_queueentry_queue` FOREIGN KEY (`queue`) REFERENCES `queue` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `receptionist`
--

DROP TABLE IF EXISTS `receptionist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `receptionist` (
  `employee` varchar(36) NOT NULL,
  `version` int(11) DEFAULT '0',
  PRIMARY KEY (`employee`),
  CONSTRAINT `fk_receptionist_employee` FOREIGN KEY (`employee`) REFERENCES `employee` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `referral`
--

DROP TABLE IF EXISTS `referral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `referral` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `appointment` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_referral_appointment_idx` (`appointment`),
  CONSTRAINT `fk_referral_appointment` FOREIGN KEY (`appointment`) REFERENCES `appointment` (`calendarentry`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sicknote`
--

DROP TABLE IF EXISTS `sicknote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sicknote` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `insurance` varchar(36) DEFAULT NULL,
  `diagnosis` varchar(36) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sicknote_diagnosis_idx` (`diagnosis`),
  KEY `fk_sicknote_insurance_idx` (`insurance`),
  CONSTRAINT `fk_sicknote_diagnosis` FOREIGN KEY (`diagnosis`) REFERENCES `diagnosis` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sicknote_insurance` FOREIGN KEY (`insurance`) REFERENCES `insurance` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `employee` varchar(36) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_user_employee_idx` (`employee`),
  CONSTRAINT `fk_user_employee` FOREIGN KEY (`employee`) REFERENCES `employee` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_userrole`
--

DROP TABLE IF EXISTS `user_userrole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_userrole` (
  `user` varchar(36) NOT NULL,
  `userrole` varchar(36) NOT NULL,
  PRIMARY KEY (`user`,`userrole`),
  KEY `fk_user_userrole_userrole_idx` (`userrole`),
  CONSTRAINT `fk_user_userrole_user` FOREIGN KEY (`user`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_userrole_userrole` FOREIGN KEY (`userrole`) REFERENCES `userrole` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userright`
--

DROP TABLE IF EXISTS `userright`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userright` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userright_userrole`
--

DROP TABLE IF EXISTS `userright_userrole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userright_userrole` (
  `userright` varchar(36) NOT NULL,
  `userrole` varchar(36) NOT NULL,
  PRIMARY KEY (`userright`,`userrole`),
  KEY `fk_userright_userrole_userrole_idx` (`userrole`),
  CONSTRAINT `fk_userright_userrole_userright` FOREIGN KEY (`userright`) REFERENCES `userright` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_userright_userrole_userrole` FOREIGN KEY (`userrole`) REFERENCES `userrole` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userrole`
--

DROP TABLE IF EXISTS `userrole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userrole` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `finding`
--
DROP TABLE IF EXISTS `finding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `finding` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `finding` varchar(1024) DEFAULT NULL,
  `appointment` varchar(36) DEFAULT NULL,  
  PRIMARY KEY (`id`),
  KEY `fk_finding_appointment_idx` (`appointment`),
  CONSTRAINT `fk_finding_appointment` FOREIGN KEY (`appointment`) REFERENCES `appointment` (`calendarentry`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-02 12:57:10
