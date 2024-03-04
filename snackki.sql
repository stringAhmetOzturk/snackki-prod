-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: snackki
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `automatbrands`
--

DROP TABLE IF EXISTS `automatbrands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automatbrands` (
  `id` int NOT NULL AUTO_INCREMENT,
  `brandName` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automatbrands`
--

LOCK TABLES `automatbrands` WRITE;
/*!40000 ALTER TABLE `automatbrands` DISABLE KEYS */;
INSERT INTO `automatbrands` VALUES (5,'testBrand'),(8,'ünal');
/*!40000 ALTER TABLE `automatbrands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `automatfilters`
--

DROP TABLE IF EXISTS `automatfilters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automatfilters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `filterName` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automatfilters`
--

LOCK TABLES `automatfilters` WRITE;
/*!40000 ALTER TABLE `automatfilters` DISABLE KEYS */;
INSERT INTO `automatfilters` VALUES (4,'testFilter');
/*!40000 ALTER TABLE `automatfilters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `automatmodels`
--

DROP TABLE IF EXISTS `automatmodels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automatmodels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `automatModelName` varchar(150) NOT NULL,
  `automatBrand` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `brandFK` (`automatBrand`),
  CONSTRAINT `brandFK` FOREIGN KEY (`automatBrand`) REFERENCES `automatbrands` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automatmodels`
--

LOCK TABLES `automatmodels` WRITE;
/*!40000 ALTER TABLE `automatmodels` DISABLE KEYS */;
INSERT INTO `automatmodels` VALUES (9,'test',5),(13,'asdsa',5);
/*!40000 ALTER TABLE `automatmodels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `automats`
--

DROP TABLE IF EXISTS `automats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `automatBrandId` int NOT NULL,
  `automatModelId` int NOT NULL,
  `automatSeriNo` varchar(55) NOT NULL,
  `isBuy` varchar(45) NOT NULL,
  `isRented` varchar(45) DEFAULT NULL,
  `automatDocument` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automats`
--

LOCK TABLES `automats` WRITE;
/*!40000 ALTER TABLE `automats` DISABLE KEYS */;
INSERT INTO `automats` VALUES (34,5,9,'13232','Satın alındı','Depoda',NULL),(35,5,9,'13232','Satın alındı','Depoda',NULL);
/*!40000 ALTER TABLE `automats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Füllprodukte'),(2,'Kaffeeautomaten'),(3,'Getränkeautomaten'),(4,'Snackautomaten'),(5,'Wasserspender'),(6,'Siebträger');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `foryou`
--

DROP TABLE IF EXISTS `foryou`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `foryou` (
  `id` int NOT NULL AUTO_INCREMENT,
  `productId` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `productId_UNIQUE` (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foryou`
--

LOCK TABLES `foryou` WRITE;
/*!40000 ALTER TABLE `foryou` DISABLE KEYS */;
INSERT INTO `foryou` VALUES (22,2),(24,4),(27,7);
/*!40000 ALTER TABLE `foryou` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `orderId` varchar(45) NOT NULL,
  `productId` varchar(45) NOT NULL,
  `productAmount` varchar(45) NOT NULL,
  `orderDate` varchar(45) NOT NULL,
  `status` varchar(25) DEFAULT 'pending',
  `paymentName` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (24,55,'551695724886153825','1','4','26.09.2023 - 12:41','pending','Überweisung'),(25,55,'551698835525647551','1','10','01.11.2023 - 11:45','pending','Überweisung');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paymenttypes`
--

DROP TABLE IF EXISTS `paymenttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paymenttypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `paymentName` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paymenttypes`
--

LOCK TABLES `paymenttypes` WRITE;
/*!40000 ALTER TABLE `paymenttypes` DISABLE KEYS */;
INSERT INTO `paymenttypes` VALUES (1,'Bankabbuchung'),(2,'Überweisung'),(3,'Barzahlung'),(4,'Paypal');
/*!40000 ALTER TABLE `paymenttypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periods`
--

DROP TABLE IF EXISTS `periods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `periods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `periodName` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periods`
--

LOCK TABLES `periods` WRITE;
/*!40000 ALTER TABLE `periods` DISABLE KEYS */;
INSERT INTO `periods` VALUES (1,'3 MONTH'),(2,'6 MONTH'),(3,'9 MONTH'),(4,'1 YEAR'),(5,'2 YEAR');
/*!40000 ALTER TABLE `periods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `image` varchar(500) NOT NULL,
  `category` int NOT NULL,
  `sub_category` int NOT NULL,
  `productId` int NOT NULL,
  `desc` varchar(1000) NOT NULL,
  `cartoonAmount` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `productId_UNIQUE` (`productId`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'ILLY ARABICA SELECTION ÄTHIOPIEN','image-1685698994515-illy_Etiopia.jpg',1,1,111,'Sanfter Geschmack Es wird angenommen, dass Kaffee ursprünglich aus Äthiopien (Etiopia) kommt. Der Arabica-Kaffee, der in diesem Land wächst, hat ein delikates Aroma mit Noten von Jasmin, perfektioniert durch unser spezielles Röstprofil.',5),(2,'BIO PURE TEA KAMILLE ','image-1685699373074-pure-tea-bio-kamille.png',1,2,121,'Pure Tea Selection: Den Moment voll auskosten  Je turbulenter es zugeht, desto größer der Wunsch nach genussvollen Auszeiten und dem Gefühl entspannten Zusammenseins. Genau dafür sind die Tees der Pure Tea Selection gedacht und gemacht: hochwertige, natürlich-leichte Tees ganz nach dem Geschmack moderner Genießer.',4),(3,'LAVAZZA ¡TIERRA! SELECTION','image-1685700467742-Lavazza-Tierra-Selection.png',1,3,131,'',3),(4,'MAGGI ITALIENISCHE TOMATENSUPPE','image-1685700534786-maggi-tomatensuppe.png',1,4,141,'Fertig zubereitet, entfaltet dieses Teegetränk mit Schwarztee-Extrakt ein volles Teearoma, verbunden mit einem erfrischenden Zitronengeschmack. Die zitronige Frische kann heiß oder kalt genossen werden.',4),(5,'CAFÉ CRÈME CLASSIQUE','image-1685700584202-TchiboCaffeCremaClassique.jpg',1,5,151,'Für Cafè Crème und Milchkaffee. Café Crème Classique ist eine Komposition ausgewählter Arabica- und vollmundiger Robusta-Bohnen – für eine besonders feine, samtige Crema und ein vollmundiges Aroma.',5),(6,'PIACETTO ESPRESSO TRADIZIONALE','image-1685700684926-Piacetto-Espresso-Tradizionale.jpg',1,6,161,'Speziell ausgewählte Arabica-Bohnen von Rainforest-Alliance-zertifizierten Plantagen ergeben ein süßes und feines Aroma. Ein harmonischer Espresso mit feiner Säure, Noten von Cerealien und einem angenehmen Nachgeschmack von getrockneten Früchten.  Die Rainforest Alliance zertifiziert die Herkunft dieses Kaffees von Plantagen, die hohen Anforderungen an ökologische und soziale Nachhaltigkeit entsprechen und die Bewahrung des Ökosystems, Verbesserung der Produktivität und der Lebensbedingungen der Kaffeebauern vereinen.',3),(7,'EGRO ZERO PLUS QUICK-MILK','image-1685703027293-P_ZERO_PLUS_FRIDGE.jpg',2,7,211,'Kaffee und Heißwasser Kapazitive Benutzeroberfläche mit Touch-Technologie  ',5),(8,'LARHEA V+ DOPPIO&CUP GANZE BOHNE','image-1685703084430-larhea_v-doppio.png',2,8,221,'Mehrwert to go – mehr Platz, mehr Genuss in doppeltem Ausmaß und Angebot. Ob klassisch in der Tasse oder trendy – mit vollautomatischer Abgabe – im Becher, in zwei Getränkegrößen mit zwei Kaffeequalitäten (Bohne und Instant). Erfreuen Sie sich an der Wahlfreiheit leckerer Trend- und Traditionsspezialitäten. Perfektioniert durch die Variplus Technologie',5),(9,'LAVAZZA BLUE LB2600','image-1685703135858-lavazza-LB-2600.png',2,9,231,'Die LB 2600 verzaubert mit italienischen Kaffee-Spezialitäten  Die Lavazza BLUE LB 2600 Kaffeemaschine in stilvollem Design eignet sich ideal für kleine bis mittelgroße Büros und Unternehmen, die sich eine zuverlässige und professionelle Maschine wünschen.  Neben exzellentem Espresso bereitet sie eine Vielfalt köstlicher Kaffee-Spezialitäten sowie heiße Schokolade zu. Dank ihres großen Touchpanels ist sie einfach in der Bedienung und ermöglicht eine intuitive Getränkeauswahl.',5),(10,'NECTA CANTO PLUS','image-1685703196863-Canto-Plus.png',2,10,241,'Durch die Kombination eines klaren, sachlichen Stils mit modernem Understatement entzückt Canto Plus mit schlichter Eleganz. Dank der technischen Innovationen gibt Canto die große Auswahl an Getränken in optimaler Qualität aus. Vom perfekten italienischen Espresso und echtem englischen Tee bis zum Cappuccino mit perfekter Crema und leckerer Schokolade wird jeder individuelle Geschmack befriedigt – ein Beispiel bester italienischer Handwerkskunst.',7),(11,'RHEA BUSINESS LINE GRANDE','image-1685703273755-LaRhea_Cino_Grande.png',2,11,251,'State of the Art – Attribute für große Versprechen, die gehalten werden! Das ganze Coffee Shop Menü über eine sanfte 7‘‘ Touchscreen Funktion für ein ansprechendes und zeitgemäßes Bedienerlebnis, einer immensen Auswahl und extra großem Kaffeebohnenbehälter on top. Mit ganzen Bohnen für Kultgetränke wie Kaffee, Espresso, Cappuccino und Co. Eine Auswahl wie im Coffee Shop. Frisch gemahlen, mit 92°C kurz und gut gebrüht, zaubert unser PressoBean-System mit 9 bar Druck eine feine Crema. Direkter Anschluss an die Wasserleitung – schalten Sie für die bessere Wasserqualität einen Filter zwischen Leitung und Maschine, um ein perfektes Heißgetränk zu erhalten.',6),(12,'SIELAFF SIAMONIE','image-1685703337338-Sieamonie.png',2,12,261,'Grandiose Geschmackserlebnisse  Der Name Sielaff steht für vollendeten Kaffeegenuss verbunden mit herausragendem Design. Mit der stilvollen wie effizienten Verknüpfung von italienischer Kaffee- und deutscher Ingenieurskunst wird die Siamonie zur Ikone exquisiter Kaffeekultur.  Hochwertige Komponenten und innovative Technik garantieren dabei charaktervolle Kaffeekompositionen: ob hochwertige Edelmetalle, akzentuierte Beleuchtung oder intuitive Bedienung und Reinigung.  Die Siamonie Serie bietet Ihnen eine Geschmacksvielfalt internationaler Kaffeespezialitäten vom Ristretto bis zum XXL-Kaffee und ist somit prädestiniert für Hotels, Restaurants und den Cateringbereich.',7),(13,'AIR DRINKS & MORE','image-1685703613509-snack-air.jpg',3,13,311,'Das ultra-softe Liftsystem „air“ bringt beliebte Limonaden aller Art, leckere Smoothies, Joghurt im empfindlichen Becher sowie herrliche Milchshakes, auch aus Glasflaschen, soft zur Ausgabe.  Geschüttelt oder gerührt? Weder noch! Das ultra-softe Liftsystem „air“ bringt beliebte Limonaden aller Art, leckere Smoothies, Joghurt im empfindlichen Becher sowie herrliche Milchshakes, auch aus Glasflaschen, soft zur Ausgabe. Coole Getränke – sorgen zischfrisch, aber spritzfrei für prompte Abkühlung! Bieten Sie ein besonderes Genuss-Programm und Ihre europa snac wird zur begehrten Anlaufstelle, auch nach Feierabend!',6),(14,'NECTA DIESIS 500','image-1685703669002-Diesis500_collage.jpg',3,14,321,'Diesis ist die innovativste Lösung, die derzeit für die Ausgabe von Kaltgetränken in Dosen und Flaschen zur Verfügung steht. Das moderne und elegante Design, sowie die intuitive Bedienoberfläche garantieren eine große Benutzerfreundlichkeit. Trotz der kompakten Abmessungen bietet Diesis 500 ein optimales Fassungsvermögen.  ',5),(15,'Sielaff FS 1500','image-1685703775014-Sielaff-FS-1500.png',3,15,331,'Der FS 1500 bietet trotz seiner schlanken Linie ein vielfältiges Produktangebot.  Serienmäßig im stilvollen EC-Design ist er an jedem Standort ein echtes Highlight.  Ihre Vorteile im Überblick:  Schächte in unterschiedlichen Breiten für Dosen und Flaschen von 02 l bis 2,0 l Höhenverstellbare Edelstahlwarenfächer mit selbstzentrierendem Steckanschluss ohne Kabel – schwenkbar für die bequeme Befüllung der oberen Ebenen Spiralen aus hochglänzendem Edelstahl – verfügbar in 11 unterschiedlichen Größen Optional: Multiflexschieber für den problemlosen Verkauf von größern und stabil stehenden Produkten Geregelte Hochleistungs-Einschubkühlung – optional mit CO2 als Kühlmittel Durchgehendes Edelstahlbedienmodul Auswahl über robuste 12er-Tastatur aus Metall Isolierverglasung aus Verbundsicherheitsglas LED-Innenbeleuchtung',4),(16,'air drinks & more','image-1685704064943-snack-air.jpg',4,16,411,'Das ultra-softe Liftsystem „air“ bringt beliebte Limonaden aller Art, leckere Smoothies, Joghurt im empfindlichen Becher sowie herrliche Milchshakes, auch aus Glasflaschen, soft zur Ausgabe.  Geschüttelt oder gerührt? Weder noch! Das ultra-softe Liftsystem „air“ bringt beliebte Limonaden aller Art, leckere Smoothies, Joghurt im empfindlichen Becher sowie herrliche Milchshakes, auch aus Glasflaschen, soft zur Ausgabe. Coole Getränke – sorgen zischfrisch, aber spritzfrei für prompte Abkühlung! Bieten Sie ein besonderes Genuss-Programm und Ihre europa snac wird zur begehrten Anlaufstelle, auch nach Feierabend!',3),(17,'Necta Festival','image-1685704095991-necta-festival.png',4,17,421,'Festival ist die optimale Lösung für Standorte, die einen 24-Stunden-Kantinen-Service benötigen. Der neue leistungsstarke und flexible Trommel-Verkaufsautomat von Necta bietet eine große Auswahl an Produkten. Der Benutzer kann zwischen Snacks, Getränken, frischen Speisen, Obst und Joghurt wählen. Die fortschrittliche Elektronik sorgt für ein hervorragendes Maschinen- und Produktmanagement. Festival hat einen niedrigen Energieverbrauch und erreicht Energieeffizienzklasse A+ (nach EVA EMP 3.0 Standard). Dieser zuverlässige Automat wird jeder Anforderung zur Ausgabe, Frische und Haltbarkeit von Lebensmitteln gerecht. Genießen Sie mit Festival ein Fest der frischen Lebensmittel!',6),(18,'Sielaff FS 1500','image-1685704154582-Sielaff-FS-1500.png',4,18,431,'Der FS 1500 bietet trotz seiner schlanken Linie ein vielfältiges Produktangebot.  Serienmäßig im stilvollen EC-Design ist er an jedem Standort ein echtes Highlight.  Ihre Vorteile im Überblick:  Schächte in unterschiedlichen Breiten für Dosen und Flaschen von 02 l bis 2,0 l Höhenverstellbare Edelstahlwarenfächer mit selbstzentrierendem Steckanschluss ohne Kabel – schwenkbar für die bequeme Befüllung der oberen Ebenen Spiralen aus hochglänzendem Edelstahl – verfügbar in 11 unterschiedlichen Größen Optional: Multiflexschieber für den problemlosen Verkauf von größern und stabil stehenden Produkten Geregelte Hochleistungs-Einschubkühlung – optional mit CO2 als Kühlmittel Durchgehendes Edelstahlbedienmodul Auswahl über robuste 12er-Tastatur aus Metall Isolierverglasung aus Verbundsicherheitsglas LED-Innenbeleuchtung Kapazität:  Warenfachbreite: 3 oder 4 Spiralen/Ebene Spiralebenen: 4 – 7 (Standard: 6) Max. Anzahl von Schächten: 3 oder 4 Der FS 1500 ist erhältlich in den Ausführungen:',4),(19,'spaqa® PowerSpeed 120','image-1685704306283-power-speed-120.png',5,21,511,' Tafelwasser mit CO2, gekühlt Tafelwasser still, gekühlt Tafelwasser still, ungekühlt Schnell und leistungsstark spaqa® Power Speed, professioneller Trinkwasserspender für Aufstellplätze, mit maximaler Leistungsanforderung. Auf Knopfdruck erhalten Sie bis zu 120 Liter /Std. gekühltes, prickelndes Wasser.  Frische auf die Tische Ideal für den HORECA Bereich, oder Produktionsbetrieb, wo Karaffen und Flaschen abgefüllt werden.  Alles auf Knopfdruck  gekühltes, frisch gefiltertes Wasser mit CO2 gekühltes, frisch gefiltertes Wasser still Ungekühltes, frisch gefiltertes Wasser still Merkmale/Vorteile  optisch sehr ansprechend durch klares, frisches Design in Edelstahl matt, athrazit und weiß mit azurblauer Beleuchtung Rückverkeimsperre in der Getränkeausgabe durch patentiertes aktiv Sauerstoff-System (Activ-Oxygen-System) easy-service für CO2 und Filter Integrierte digitale Wasseruhr zur Überwachung des Wasserfilters spaqa® PowerSpeed 120',3),(20,'ION 400','image-1685704336198-ion-400.png',5,22,521,'ION 400 Wasserspender mit folgenden Eigenschaften:     STILL STILL GEKÜHLT CO2 GEKÜHLT HEISSWASSER',5),(21,'KRYO 65 AT','image-1685704430384-Kryo-65-AT.png',6,19,611,'Die Dosiermühle KRYO 65 entstand mit dem Ziel, neue Qualitätsstandards für das Vermahlen und Dosieren von Espressokaffee zu setzen, die grundlegend sind, um in der Tasse ein qualitativ einwandfreies Ergebnis zu erhalten.  Dazu hat die Technologieabteilung Rancilio LAB ein revolutionäres – mittlerweile patentiertes – System entwickelt, das ein optimales Extrahieren ermöglicht und die für einen vollendeten Espresso charakteristische körperreiche Cremigkeit garantiert.',5),(22,'RANCILIO CLASSE 11 – 2 GRUPPIG','image-1685704481790-Rancilio-CLASSE-11-2-Gruppen-PEARL-WHITE-XCELSIUS.jpg',6,20,621,'Es war eine große Herausforderung, auf dem einheitlichen Markt der Kaffeemaschinen völlig neue Maßstäbe zu setzen. „Ich wollte ein Produkt, das alles Bisherige in den Schatten stellt. Ein Produkt, das Ausdruck und perfekte Umsetzung des digitalen Zeitalters ist.“ Giorgio Rancilio hat die Anforderung klar formuliert: „Wir brauchen etwas Revolutionäres.“ Nach unzähligen, immer wieder verworfenen Ideen hatte sein Entwicklerteam die zündende Idee: Die Classe 11. Mehr als einfach nur eine neue, professionelle Kaffeemaschine von Rancilio. Mit zukunftsweisender Technologie erschafft sie eine völlig neue Interpretation von Kaffeegenuss.',3);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subcategories`
--

DROP TABLE IF EXISTS `subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subcategories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subcategoryName` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subcategories`
--

LOCK TABLES `subcategories` WRITE;
/*!40000 ALTER TABLE `subcategories` DISABLE KEYS */;
INSERT INTO `subcategories` VALUES (1,'ILLY'),(2,'PURE TEA'),(3,'LAVAZZA'),(4,'NESCAFE'),(5,'TCHIBO'),(6,'PIACETTO'),(7,'EGRO KAUTOMAT'),(8,'LARHEA KAUTOMAT'),(9,'LAVAZZA KAUTOMAT'),(10,'NECTA KAUTOMAT'),(11,'RHEA KAUTOMAT'),(12,'SIELAFF KAUTOMAT'),(13,'AIR GAUTOMAT'),(14,'NECTA GAUTOMAT'),(15,'SIELAFF GAUTOMAT'),(16,'AIR SAUTOMAT'),(17,'NECTA SAUTOMAT'),(18,'SIELAFF SAUTOMAT'),(19,'MÜHLEN'),(20,'SIEBTRÄGERMASCHINEN'),(21,'SPAQA WAUTOMAT'),(22,'ION WAUTOMAT');
/*!40000 ALTER TABLE `subcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userautomats`
--

DROP TABLE IF EXISTS `userautomats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userautomats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `automatId` int NOT NULL,
  `automatFilterId` int DEFAULT NULL,
  `periodId` int DEFAULT NULL,
  `filterChangedDate` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userF` (`userId`),
  KEY `automatF` (`automatId`),
  CONSTRAINT `automatF` FOREIGN KEY (`automatId`) REFERENCES `automats` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userF` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userautomats`
--

LOCK TABLES `userautomats` WRITE;
/*!40000 ALTER TABLE `userautomats` DISABLE KEYS */;
/*!40000 ALTER TABLE `userautomats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpaymenttypes`
--

DROP TABLE IF EXISTS `userpaymenttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userpaymenttypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `paymentId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user` (`userId`),
  KEY `payment` (`paymentId`),
  CONSTRAINT `payment` FOREIGN KEY (`paymentId`) REFERENCES `paymenttypes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpaymenttypes`
--

LOCK TABLES `userpaymenttypes` WRITE;
/*!40000 ALTER TABLE `userpaymenttypes` DISABLE KEYS */;
INSERT INTO `userpaymenttypes` VALUES (1,55,1),(2,55,2),(3,55,3),(4,55,4);
/*!40000 ALTER TABLE `userpaymenttypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userproducts`
--

DROP TABLE IF EXISTS `userproducts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userproducts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `productId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `users` (`userId`),
  KEY `productF` (`productId`),
  CONSTRAINT `productF` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `users` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userproducts`
--

LOCK TABLES `userproducts` WRITE;
/*!40000 ALTER TABLE `userproducts` DISABLE KEYS */;
INSERT INTO `userproducts` VALUES (1,55,111);
/*!40000 ALTER TABLE `userproducts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `isAdmin` tinyint DEFAULT '0',
  `isActive` int DEFAULT '1',
  `name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `surname` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `street` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `postNo` int NOT NULL,
  `city` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `country` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `branch` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `companyName` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `contactPerson` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId_UNIQUE` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,55,1,1,'Önder','Çardaklı','01632330584','Lutzowplatz 1',10501,'Berlin','Almanya','onder@snackki.com','Admin','Snackki','','$2b$10$t3XinytwGEwaRhBozf9n0O.l9/tK28cWzr5YBlpmFWTgx8o9WROba');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-01 17:06:37
