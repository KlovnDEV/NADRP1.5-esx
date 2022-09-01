CREATE TABLE IF NOT EXISTS `territories` (
  `zone` varchar(50) NOT NULL DEFAULT '',
  `control` varchar(50) NOT NULL DEFAULT '',
  `influence` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Bien ajouté a chaque add dans le config (zone = "Nom de la rue", control = nom du groupe, influence = 100)