-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 14, 2019 at 01:29 AM
-- Server version: 10.1.36-MariaDB
-- PHP Version: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_kasir`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_barang`
--

CREATE TABLE `tbl_barang` (
  `id_barang` int(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `harga_barang` int(11) NOT NULL,
  `stok_barang` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_barang`
--

INSERT INTO `tbl_barang` (`id_barang`, `nama_barang`, `harga_barang`, `stok_barang`) VALUES
(1, 'Mouse', 20000, 15),
(2, 'Keyboard-Gaming', 30000, 25),
(3, 'Laptop', 40000, 20),
(4, 'Flashdisk', 40000, 45),
(5, 'Kabel Data USB 2', 10000, 100),
(6, 'Kabel Data USB 3', 25000, 50);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_detailpembelian`
--

CREATE TABLE `tbl_detailpembelian` (
  `id_detail` int(11) NOT NULL,
  `id_pembelian` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `jumlah_barang` int(11) NOT NULL,
  `harga_barang` int(11) NOT NULL,
  `sub_total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_detailpembelian`
--

INSERT INTO `tbl_detailpembelian` (`id_detail`, `id_pembelian`, `id_barang`, `jumlah_barang`, `harga_barang`, `sub_total`) VALUES
(63, 31, 2, 10, 30000, 300000),
(64, 31, 4, 15, 40000, 600000);

--
-- Triggers `tbl_detailpembelian`
--
DELIMITER $$
CREATE TRIGGER `pembelian` AFTER INSERT ON `tbl_detailpembelian` FOR EACH ROW BEGIN
update tbl_barang
set tbl_barang.stok_barang = tbl_barang.stok_barang + new.jumlah_barang
where tbl_barang.id_barang = new.id_barang;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_detailpenjualan`
--

CREATE TABLE `tbl_detailpenjualan` (
  `id_detailpenjualan` int(11) NOT NULL,
  `id_penjualan` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `jumlah_barang` int(11) NOT NULL,
  `harga_barang` int(11) NOT NULL,
  `sub_total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_detailpenjualan`
--

INSERT INTO `tbl_detailpenjualan` (`id_detailpenjualan`, `id_penjualan`, `id_barang`, `jumlah_barang`, `harga_barang`, `sub_total`) VALUES
(5, 4, 2, 25, 30000, 750000),
(6, 4, 6, 50, 25000, 1250000);

--
-- Triggers `tbl_detailpenjualan`
--
DELIMITER $$
CREATE TRIGGER `penjualan` AFTER INSERT ON `tbl_detailpenjualan` FOR EACH ROW BEGIN
update tbl_barang
set tbl_barang.stok_barang = tbl_barang.stok_barang - new.jumlah_barang
where tbl_barang.id_barang = new.id_barang;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pembelian`
--

CREATE TABLE `tbl_pembelian` (
  `id_pembelian` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `total_pembelian` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_pembelian`
--

INSERT INTO `tbl_pembelian` (`id_pembelian`, `tanggal`, `total_pembelian`) VALUES
(31, '2019-05-14', 900000);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_penjualan`
--

CREATE TABLE `tbl_penjualan` (
  `id_penjualan` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `total_penjualan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_penjualan`
--

INSERT INTO `tbl_penjualan` (`id_penjualan`, `tanggal`, `total_penjualan`) VALUES
(1, '2019-05-14', 600000),
(2, '2019-05-14', 460000),
(3, '2019-05-14', 460000),
(4, '2019-05-14', 2000000);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_temppembelian`
--

CREATE TABLE `tbl_temppembelian` (
  `id_temp` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `total_barang` int(11) NOT NULL,
  `harga_barang` int(11) NOT NULL,
  `sub_total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_temppembelian`
--

INSERT INTO `tbl_temppembelian` (`id_temp`, `id_barang`, `total_barang`, `harga_barang`, `sub_total`) VALUES
(16, 2, 10, 30000, 300000),
(17, 4, 15, 40000, 600000);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_temppenjualan`
--

CREATE TABLE `tbl_temppenjualan` (
  `id_temppenjualan` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `total_barang` int(11) NOT NULL,
  `harga_barang` int(11) NOT NULL,
  `sub_total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_temppenjualan`
--

INSERT INTO `tbl_temppenjualan` (`id_temppenjualan`, `id_barang`, `total_barang`, `harga_barang`, `sub_total`) VALUES
(3, 2, 25, 30000, 750000),
(4, 6, 50, 25000, 1250000);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `id` int(11) NOT NULL,
  `name_user` varchar(50) NOT NULL,
  `email_user` varchar(50) NOT NULL,
  `password_user` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`id`, `name_user`, `email_user`, `password_user`) VALUES
(1, 'Lukman Arief C', 'lukmanarief985@gmail.com', '12345');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_barang`
--
ALTER TABLE `tbl_barang`
  ADD PRIMARY KEY (`id_barang`);

--
-- Indexes for table `tbl_detailpembelian`
--
ALTER TABLE `tbl_detailpembelian`
  ADD PRIMARY KEY (`id_detail`);

--
-- Indexes for table `tbl_detailpenjualan`
--
ALTER TABLE `tbl_detailpenjualan`
  ADD PRIMARY KEY (`id_detailpenjualan`);

--
-- Indexes for table `tbl_pembelian`
--
ALTER TABLE `tbl_pembelian`
  ADD PRIMARY KEY (`id_pembelian`);

--
-- Indexes for table `tbl_penjualan`
--
ALTER TABLE `tbl_penjualan`
  ADD PRIMARY KEY (`id_penjualan`);

--
-- Indexes for table `tbl_temppembelian`
--
ALTER TABLE `tbl_temppembelian`
  ADD PRIMARY KEY (`id_temp`);

--
-- Indexes for table `tbl_temppenjualan`
--
ALTER TABLE `tbl_temppenjualan`
  ADD PRIMARY KEY (`id_temppenjualan`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_barang`
--
ALTER TABLE `tbl_barang`
  MODIFY `id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_detailpembelian`
--
ALTER TABLE `tbl_detailpembelian`
  MODIFY `id_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `tbl_detailpenjualan`
--
ALTER TABLE `tbl_detailpenjualan`
  MODIFY `id_detailpenjualan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_pembelian`
--
ALTER TABLE `tbl_pembelian`
  MODIFY `id_pembelian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `tbl_penjualan`
--
ALTER TABLE `tbl_penjualan`
  MODIFY `id_penjualan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_temppembelian`
--
ALTER TABLE `tbl_temppembelian`
  MODIFY `id_temp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `tbl_temppenjualan`
--
ALTER TABLE `tbl_temppenjualan`
  MODIFY `id_temppenjualan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
