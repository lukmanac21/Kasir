-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 15, 2018 at 05:51 AM
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
-- Database: `dvd_store`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteUser` (IN `c_email` VARCHAR(255))  BEGIN
	DECLARE c_id INT(10);
    DECLARE c_order INT(10);
    
	SET c_id = (SELECT id_customer FROM tbl_customer WHERE customer_email = c_email);
    SET c_order = (SELECT id_order FROM tbl_order WHERE id_customer = c_id);
    
    DELETE FROM tbl_payment WHERE id_order = c_order;
	DELETE FROM tbl_order WHERE id_customer = c_id AND id_order = c_order;
    DELETE FROM tbl_customer WHERE id_customer = c_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_cart`
--

CREATE TABLE `tbl_cart` (
  `id_cart` int(10) NOT NULL,
  `id_customer` int(11) NOT NULL,
  `id_product` int(10) NOT NULL,
  `quantity` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_customer`
--

CREATE TABLE `tbl_customer` (
  `id_customer` int(10) NOT NULL,
  `id_role` int(11) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_email` varchar(255) NOT NULL,
  `customer_password` varchar(50) NOT NULL,
  `country` text NOT NULL,
  `city` text NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `address` text NOT NULL,
  `image` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_customer`
--

INSERT INTO `tbl_customer` (`id_customer`, `id_role`, `customer_name`, `customer_email`, `customer_password`, `country`, `city`, `phone_number`, `address`, `image`) VALUES
(2, 1, 'lukman arief', 'lukman@gmail.com', 'lukman21', 'bondowoso', 'indonesia', '08912834245', 'bondowoso ex malang', 'foto-profil2.png'),
(3, 1, 'man', 'man@gmail.com', 'man123', 'malang', 'indonesia', '085649806398', 'jl. gadang', 'man.jpg'),
(4, 1, 'Faldi', 'Faldi767@gmail.com', '123', 'Indonesia', 'Malang', '085804805750', 'Sumpil', 'smoke_anonymous_steam_avatars.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_order`
--

CREATE TABLE `tbl_order` (
  `id_order` int(10) NOT NULL,
  `id_customer` int(10) NOT NULL,
  `id_product` int(10) NOT NULL,
  `amount` int(100) NOT NULL,
  `invoice_no` int(100) NOT NULL,
  `quantity` int(10) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `order_status` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_order`
--

INSERT INTO `tbl_order` (`id_order`, `id_customer`, `id_product`, `amount`, `invoice_no`, `quantity`, `order_date`, `order_status`) VALUES
(4, 2, 9, 80000, 964118438, 2, '2018-05-29 20:37:17', 'Complete'),
(5, 2, 13, 74000, 310950471, 2, '2018-05-29 21:03:46', 'Complete'),
(6, 2, 11, 90000, 1943503502, 2, '2018-05-29 21:05:43', 'Complete'),
(10, 4, 3, 150000, 621511351, 3, '2018-07-12 08:15:26', 'Complete');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_payment`
--

CREATE TABLE `tbl_payment` (
  `payment_id` int(10) NOT NULL,
  `id_order` int(10) NOT NULL,
  `payment_mode` text NOT NULL,
  `ref_no` int(11) NOT NULL,
  `payment_date` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_payment`
--

INSERT INTO `tbl_payment` (`payment_id`, `id_order`, `payment_mode`, `ref_no`, `payment_date`) VALUES
(4, 5, 'Bank', 1234, '23052018'),
(5, 6, 'Bank', 533, '23052018'),
(15, 10, 'Bank', 456, '01042018');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_product`
--

CREATE TABLE `tbl_product` (
  `id_product` int(10) NOT NULL,
  `id_cat_p` int(10) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `product_title` text NOT NULL,
  `product_img1` text NOT NULL,
  `product_img2` text NOT NULL,
  `product_img3` text NOT NULL,
  `product_price` int(10) NOT NULL,
  `product_desc` text NOT NULL,
  `product_keyword` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_product`
--

INSERT INTO `tbl_product` (`id_product`, `id_cat_p`, `date`, `product_title`, `product_img1`, `product_img2`, `product_img3`, `product_price`, `product_desc`, `product_keyword`) VALUES
(3, 2, '2018-10-14 04:21:34', 'Aquaman', 'aquaman.jpg', 'aquaman.jpg', 'aquaman.jpg', 50000, 'Arthur Curry learns that he is the heir to the underwater kingdom of Atlantis, and must step forward to lead his people and be a hero to the world.                                                                                                        ', 'aquaman'),
(8, 4, '2018-10-14 04:22:03', 'Rampage', 'rampage.jpg', 'rampage.jpg', 'rampage.jpg', 50000, 'When three different animals become infected with a dangerous pathogen, a primatologist and a geneticist team up to stop them from destroying Chicago.                                                                   ', 'Rampage'),
(9, 3, '2018-10-14 04:22:43', 'Ant Man', 'antman.jpg', 'antman.jpg', 'antman.jpg', 40000, 'As Scott Lang balances being both a Super Hero and a father, Hope van Dyne and Dr. Hank Pym present an urgent new mission that finds the Ant-Man fighting alongside The Wasp to uncover secrets from their past.', 'antman'),
(10, 3, '2018-10-14 04:23:09', 'Deadpool', 'deadpool_2.jpg', 'deadpool_2.jpg', 'deadpool_2.jpg', 40000, 'Foul-mouthed mutant mercenary Wade Wilson (AKA. Deadpool), brings together a team of fellow mutant rogues to protect a young boy with supernatural abilities from the brutal, time-traveling cyborg, Cable.                                                                                                                                             ', 'deadpool'),
(11, 3, '2018-10-14 04:23:59', 'Black Panther', 'blackpanther.jpg', 'blackpanther.jpg', 'blackpanther.jpg', 45000, 'Nico Beamonte,an alcoholic decadent private detective is hired to find the Black Panter by someone calling himself God .', 'blackpanther'),
(12, 4, '2018-10-14 04:24:46', 'The Incredibles', 'icrdibles.jpg', 'icrdibles.jpg', 'icrdibles.jpg', 35000, 'Bob Parr (Mr. Incredible) is left to care for the kids while Helen (Elastigirl) is out saving the world.', 'incredibles'),
(13, 5, '2018-10-14 04:20:46', 'Skycrappers', 'skyscraper.jpg', 'skyscraper.jpg', 'skyscraper.jpg', 37000, 'Construction worker Oswald must save his sweetheart when his boss makes advances toward her', 'skycrappers'),
(14, 5, '2018-10-14 04:25:18', 'Jurasic Park', 'jurasicpark.jpg', 'jurasicpark.jpg', 'jurasicpark.jpg', 38000, 'When the island\'s dormant volcano begins roaring to life, Owen and Claire mount a campaign to rescue the remaining dinosaurs from this extinction-level event.', 'jurasic'),
(15, 5, '2018-10-14 04:43:19', 'Venom', 'venom.jpg', 'venom.jpg', 'venom.jpg', 45000, 'When Eddie Brock acquires the powers of a symbiote, he will have to release his alter-ego \"Venom\" to save his life.', 'venom'),
(16, 4, '2018-10-14 04:42:58', 'The Nun', 'thenun.jpg', 'thenun.jpg', 'thenun.jpg', 50000, ' A priest with a haunted past and a novice on the threshold of her final vows are sent by the Vatican to investigate the death of a young nun in Romania and confront a malevolent force in the form of a demonic nun.', 'the nun'),
(17, 5, '2018-10-14 04:29:28', 'Avenger', 'avenger.jpg', 'avenger.jpg', 'avenger.jpg', 50000, 'The Avengers and their allies must be willing to sacrifice all in an attempt to defeat the powerful Thanos before his blitz of devastation and ruin puts an end to the universe.', 'avenger'),
(18, 5, '2018-10-14 04:33:48', 'First Man', 'firstman.jpg', 'firstman.jpg', 'firstman.jpg', 45000, 'A look at the life of the astronaut, Neil Armstrong, and the legendary space mission that led him to become the first man to walk on the Moon on July 20, 1969.', 'firstman'),
(19, 5, '2018-10-14 04:33:48', 'Goosebumps 2', 'goosebumps2.jpg', 'goosebumps2.jpg', 'goosebumps2.jpg', 50000, 'Two young friends find a magic book that brings a ventriloquist\'s dummy to life.', 'goosebumps two'),
(20, 3, '2018-10-14 04:39:14', 'Bad Time', 'badtime.jpg', 'badtime.jpg', 'badtime.jpg', 50000, 'Seven strangers, each with a secret to bury, meet at Lake Tahoe\'s El Royale, a rundown hotel with a dark past. Over the course of one fateful night, everyone will have a last shot at redemption - before everything goes to hell.', 'bad time'),
(21, 4, '2018-10-14 04:39:14', 'Liyana', 'liyana.jpg', 'liyana.jpg', 'liyana.jpg', 50000, 'Five children in Swaziland dive into their imaginations to create an original African tale about a girl on a dangerous quest.', 'liyana'),
(22, 2, '2018-10-14 04:42:01', 'A Star Is Born', 'astarisborn.jpg', 'astarisborn.jpg', 'astarisborn.jpg', 45000, 'A musician helps a young singer find fame, even as age and alcoholism send his own career into a downward spiral.', 'a star is born'),
(23, 6, '2018-10-14 04:42:01', 'Small Foot', 'smallfoot.jpg', 'smallfoot.jpg', 'smallfoot.jpg', 50000, 'A Yeti is convinced that the elusive creatures known as \"humans\" really do exist.', 'small foot'),
(24, 7, '2018-10-14 04:47:24', 'Crazy Rich Asian', 'crazyrichasian.jpg', 'crazyrichasian.jpg', 'crazyrichasian.jpg', 45000, 'This contemporary romantic comedy, based on a global bestseller, follows native New Yorker Rachel Chu to Singapore to meet her boyfriend\'s family.', 'crazy rich asian'),
(25, 5, '2018-10-14 04:48:20', 'Captain America', 'captainamerica.jpg', 'captainamerica.jpg', 'captainamerica.jpg', 50000, 'Political involvement in the Avengers\' activities causes a rift between Captain America and Iron Man.', 'captain america'),
(26, 7, '2018-10-14 04:50:37', 'Once And Again', 'onceandagain.jpg', 'onceandagain.jpg', 'onceandagain.jpg', 45000, 'A divorced father and a soon-to-be divorced mother meet and begin a romantic courtship which is always complicated by their respective children and their own life problems.', 'once and again'),
(27, 5, '2018-10-14 04:52:52', 'Logan', 'logan.jpg', 'logan.jpg', 'logan.jpg', 45000, 'In the near future, a weary Logan cares for an ailing Professor X, somewhere on the Mexican border. However, Logan\'s attempts to hide from the world, and his legacy, are upended when a young mutant arrives, pursued by dark forces.', 'logan'),
(28, 6, '2018-10-14 04:52:52', 'Coco', 'coco.jpg', 'coco.jpg', 'coco.jpg', 50000, 'Aspiring musician Miguel, confronted with his family\'s ancestral ban on music, enters the Land of the Dead to find his great-great-grandfather, a legendary singer.', 'coco'),
(29, 5, '2018-10-14 04:56:14', 'Blade Runner', 'bladerunner.jpg', 'bladerunner.jpg', 'bladerunner.jpg', 35000, 'A young blade runner\'s discovery of a long-buried secret leads him to track down former blade runner Rick Deckard, who\'s been missing for thirty years.', 'blade runner'),
(30, 2, '2018-10-14 04:56:14', 'La La Land', 'land.jpg', 'land.jpg', 'land.jpg', 38000, 'While navigating their careers in Los Angeles, a pianist and an actress fall in love while attempting to reconcile their aspirations for the future.', 'la la land'),
(31, 7, '2018-10-14 04:58:49', 'Night School', 'nightschool.jpg', 'nightschool.jpg', 'nightschool.jpg', 38000, 'A group of troublemakers are forced to attend night school in hope that they\'ll pass the GED exam to finish high school.', 'night school');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_product_category`
--

CREATE TABLE `tbl_product_category` (
  `id_cat_p` int(10) NOT NULL,
  `cat_p_title` text NOT NULL,
  `cat_p_desc` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_product_category`
--

INSERT INTO `tbl_product_category` (`id_cat_p`, `cat_p_title`, `cat_p_desc`) VALUES
(2, 'Drama', 'Drama movies contain love scene and any romantic scene'),
(3, 'Sci-Fi', 'Sci-Fi Movies test'),
(4, 'Horror', 'Horror genre'),
(5, 'Action', 'Action Movie'),
(6, 'Cartoon', 'Cartoon Movies'),
(7, 'Comedy', 'Comedy movies');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_role`
--

CREATE TABLE `tbl_role` (
  `id_role` int(11) NOT NULL,
  `nama_role` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_role`
--

INSERT INTO `tbl_role` (`id_role`, `nama_role`) VALUES
(1, 'Member'),
(2, 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_slider`
--

CREATE TABLE `tbl_slider` (
  `slide_id` int(10) NOT NULL,
  `slide_name` varchar(255) NOT NULL,
  `slide_images` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_slider`
--

INSERT INTO `tbl_slider` (`slide_id`, `slide_name`, `slide_images`) VALUES
(1, 'slide 1', '1.jpeg'),
(2, 'slide 2', '2.jpeg'),
(3, 'slide 3', '3.jpeg'),
(4, 'slide 4', '4.jpeg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_cart`
--
ALTER TABLE `tbl_cart`
  ADD PRIMARY KEY (`id_cart`),
  ADD KEY `id_product` (`id_product`),
  ADD KEY `id_customer` (`id_customer`),
  ADD KEY `id_product_2` (`id_product`);

--
-- Indexes for table `tbl_customer`
--
ALTER TABLE `tbl_customer`
  ADD PRIMARY KEY (`id_customer`),
  ADD KEY `id_customer` (`id_customer`),
  ADD KEY `id_customer_2` (`id_customer`),
  ADD KEY `id_role` (`id_role`);

--
-- Indexes for table `tbl_order`
--
ALTER TABLE `tbl_order`
  ADD PRIMARY KEY (`id_order`),
  ADD KEY `id_customer` (`id_customer`),
  ADD KEY `id_product` (`id_product`),
  ADD KEY `id_order` (`id_order`);

--
-- Indexes for table `tbl_payment`
--
ALTER TABLE `tbl_payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `id_order` (`id_order`);

--
-- Indexes for table `tbl_product`
--
ALTER TABLE `tbl_product`
  ADD PRIMARY KEY (`id_product`),
  ADD KEY `id_cat_p` (`id_cat_p`);

--
-- Indexes for table `tbl_product_category`
--
ALTER TABLE `tbl_product_category`
  ADD PRIMARY KEY (`id_cat_p`),
  ADD KEY `id_cat_p` (`id_cat_p`);

--
-- Indexes for table `tbl_role`
--
ALTER TABLE `tbl_role`
  ADD PRIMARY KEY (`id_role`);

--
-- Indexes for table `tbl_slider`
--
ALTER TABLE `tbl_slider`
  ADD PRIMARY KEY (`slide_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_cart`
--
ALTER TABLE `tbl_cart`
  MODIFY `id_cart` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_customer`
--
ALTER TABLE `tbl_customer`
  MODIFY `id_customer` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_order`
--
ALTER TABLE `tbl_order`
  MODIFY `id_order` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tbl_payment`
--
ALTER TABLE `tbl_payment`
  MODIFY `payment_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tbl_product`
--
ALTER TABLE `tbl_product`
  MODIFY `id_product` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `tbl_product_category`
--
ALTER TABLE `tbl_product_category`
  MODIFY `id_cat_p` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_role`
--
ALTER TABLE `tbl_role`
  MODIFY `id_role` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_slider`
--
ALTER TABLE `tbl_slider`
  MODIFY `slide_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_cart`
--
ALTER TABLE `tbl_cart`
  ADD CONSTRAINT `tbl_cart_ibfk_1` FOREIGN KEY (`id_product`) REFERENCES `tbl_product` (`id_product`),
  ADD CONSTRAINT `tbl_cart_ibfk_2` FOREIGN KEY (`id_customer`) REFERENCES `tbl_customer` (`id_customer`);

--
-- Constraints for table `tbl_customer`
--
ALTER TABLE `tbl_customer`
  ADD CONSTRAINT `tbl_customer_ibfk_1` FOREIGN KEY (`id_role`) REFERENCES `tbl_role` (`id_role`);

--
-- Constraints for table `tbl_order`
--
ALTER TABLE `tbl_order`
  ADD CONSTRAINT `tbl_order_ibfk_1` FOREIGN KEY (`id_customer`) REFERENCES `tbl_customer` (`id_customer`),
  ADD CONSTRAINT `tbl_order_ibfk_2` FOREIGN KEY (`id_product`) REFERENCES `tbl_product` (`id_product`);

--
-- Constraints for table `tbl_payment`
--
ALTER TABLE `tbl_payment`
  ADD CONSTRAINT `tbl_payment_ibfk_1` FOREIGN KEY (`id_order`) REFERENCES `tbl_order` (`id_order`);

--
-- Constraints for table `tbl_product`
--
ALTER TABLE `tbl_product`
  ADD CONSTRAINT `tbl_product_ibfk_1` FOREIGN KEY (`id_cat_p`) REFERENCES `tbl_product_category` (`id_cat_p`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
