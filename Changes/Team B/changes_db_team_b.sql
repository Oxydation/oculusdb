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
  KEY `fk_measuremententry_measurement_idx` (`measurement`),
  CONSTRAINT `fk_measuremententry_measurement` FOREIGN KEY (`measurement`) REFERENCES `measurement` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
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
-- Table structure for table `finding`
--
DROP TABLE IF EXISTS `finding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `finding` (
  `id` varchar(36) NOT NULL DEFAULT 'UUID()',
  `version` int(11) DEFAULT '0',
  `description` varchar(1024) DEFAULT NULL,
  `appointment` varchar(36) DEFAULT NULL,  
  PRIMARY KEY (`id`),
  KEY `fk_finding_appointment_idx` (`appointment`),
  CONSTRAINT `fk_finding_appointment` FOREIGN KEY (`appointment`) REFERENCES `appointment` (`calendarentry`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;