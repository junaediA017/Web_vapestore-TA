-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for db_vapestore
CREATE DATABASE IF NOT EXISTS `db_vapestore` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_vapestore`;

-- Dumping structure for table db_vapestore.barang
CREATE TABLE IF NOT EXISTS `barang` (
  `id_barang` int unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gambar` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `satuan_barang` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `satuan_harga` int DEFAULT NULL,
  `keterangan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  PRIMARY KEY (`id_barang`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_vapestore.barang: ~3 rows (approximately)
INSERT INTO `barang` (`id_barang`, `nama`, `gambar`, `satuan_barang`, `satuan_harga`, `keterangan`) VALUES
	(11, 'Oatdrip v3', '1690897642_a9e7d7554c2236b1590f.jpg', 'pcs', 70000, 'Oatdrip v3 dengan rasa pisang seral susu memiliki kandungan 15mg nikotin bervolume 30ml cairan dengan pg 50 vg 50'),
	(12, 'Banana Licious', '1690897021_e971132f0db8767a8d44.jpg', 'pcs', 120000, 'Banana Licious dengan rasa pisang cream stroberry bervolume 60ml dengan kandungan 3mg nikotin 30pg 70vg'),
	(14, 'O Rama', '1690897600_4c9b98516df238e36ba3.jpg', 'pcs', 55000, 'O Rama adalah liquid dengan rasa srikaya dengan kandungan 25mg nikotin pg50 dan vg50 yang bervolume 15ml');

-- Dumping structure for table db_vapestore.item_transaksi_keluar
CREATE TABLE IF NOT EXISTS `item_transaksi_keluar` (
  `id_itk` int unsigned NOT NULL AUTO_INCREMENT,
  `id_tk` int unsigned DEFAULT NULL,
  `id_pembeli` int unsigned DEFAULT NULL,
  `id_barang` int unsigned DEFAULT NULL,
  `jumlah` int DEFAULT NULL,
  PRIMARY KEY (`id_itk`),
  KEY `id_pembeli` (`id_pembeli`),
  KEY `id_barang` (`id_barang`),
  KEY `id_tk` (`id_tk`),
  CONSTRAINT `FK_item_transaksi_keluar_barang` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_item_transaksi_keluar_transaksi_keluar` FOREIGN KEY (`id_tk`) REFERENCES `transaksi_keluar` (`id_tk`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_item_transaksi_keluar_user` FOREIGN KEY (`id_pembeli`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_vapestore.item_transaksi_keluar: ~1 rows (approximately)
INSERT INTO `item_transaksi_keluar` (`id_itk`, `id_tk`, `id_pembeli`, `id_barang`, `jumlah`) VALUES
	(16, 7, 11, 11, 1);

-- Dumping structure for table db_vapestore.item_transaksi_masuk
CREATE TABLE IF NOT EXISTS `item_transaksi_masuk` (
  `id_itm` int unsigned NOT NULL AUTO_INCREMENT,
  `id_tm` int unsigned DEFAULT NULL,
  `id_barang` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id_itm`),
  KEY `id_tm` (`id_tm`),
  KEY `id_barang` (`id_barang`),
  CONSTRAINT `FK_item_transaksi_masuk_barang` FOREIGN KEY (`id_barang`) REFERENCES `barang` (`id_barang`),
  CONSTRAINT `FK_item_transaksi_masuk_transaksi_masuk` FOREIGN KEY (`id_tm`) REFERENCES `transaksi_masuk` (`id_tm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_vapestore.item_transaksi_masuk: ~0 rows (approximately)

-- Dumping structure for table db_vapestore.transaksi_keluar
CREATE TABLE IF NOT EXISTS `transaksi_keluar` (
  `id_tk` int unsigned NOT NULL AUTO_INCREMENT,
  `total_bayar` int DEFAULT NULL,
  `status` enum('menunggu','lunas') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `created_at` date NOT NULL,
  PRIMARY KEY (`id_tk`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_vapestore.transaksi_keluar: ~2 rows (approximately)
INSERT INTO `transaksi_keluar` (`id_tk`, `total_bayar`, `status`, `created_at`) VALUES
	(5, 0, 'lunas', '0000-00-00'),
	(6, 0, 'lunas', '0000-00-00'),
	(7, 70000, 'lunas', '0000-00-00');

-- Dumping structure for table db_vapestore.transaksi_masuk
CREATE TABLE IF NOT EXISTS `transaksi_masuk` (
  `id_tm` int unsigned NOT NULL AUTO_INCREMENT,
  `supplier` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `jumlah` int DEFAULT NULL,
  `total_harga_beli` int DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  PRIMARY KEY (`id_tm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_vapestore.transaksi_masuk: ~0 rows (approximately)

-- Dumping structure for table db_vapestore.user
CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `password` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `nama_lengkap` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `alamat` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `jenis_kelamin` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `no_hp` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `level` enum('admin','pelanggan','pemilik') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table db_vapestore.user: ~3 rows (approximately)
INSERT INTO `user` (`id_user`, `username`, `password`, `nama_lengkap`, `email`, `alamat`, `jenis_kelamin`, `no_hp`, `level`) VALUES
	(5, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin', 'admin@gmail.com', 'Magelang', 'Laki-laki', '081', 'admin'),
	(7, 'ganti', 'c67620564d2bbdded755b8e5ca8ec184', 'ganti', 'coba', 'magelang', 'Perempuan', '081', 'pelanggan'),
	(9, 'pemilik', '58399557dae3c60e23c78606771dfa3d', 'pemilik', 'pemilik@gmail.com', 'Magelang', 'Laki-laki', '081111', 'pemilik'),
	(11, 'pelanggan', '7f78f06d2d1262a0a222ca9834b15d9d', 'pelanggan', 'pelanggan', 'kene', 'Perempuan', '000000', 'pelanggan');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
