-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 12, 2016 at 09:32 AM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 5.6.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fashionstore`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `search_advanced` (`prod_cat` VARCHAR(100), `prod_name` VARCHAR(100), `prod_pricefrom` INT, `prod_priceto` INT)  BEGIN
select p.id,p.categoryid,p.name,p.describes,p.price,p.image,p.quantity,p.article
from product as p
where p.name like prod_name 
and p.price between prod_pricefrom and prod_priceto 
and p.categoryid=prod_cat;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `balancesource`
--

CREATE TABLE `balancesource` (
  `source` varchar(10) COLLATE utf8_bin NOT NULL,
  `price` int(11) NOT NULL,
  `describes` varchar(50) COLLATE utf8_bin NOT NULL,
  `available` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `balancesource`
--

INSERT INTO `balancesource` (`source`, `price`, `describes`, `available`) VALUES
('TEST1', 100, 'test1', 1),
('TEST2', 200, 'test2', 1),
('TEST3', 300, 'test3', 1),
('TEST4', 400, 'test4', 1);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(30) COLLATE utf8_bin NOT NULL,
  `describes` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `describes`) VALUES
(23, 'Thời trang nam', 'Những trang phục cá tính, hấp dẫn'),
(24, 'Thời trang nữ', ''),
(25, 'Thời trang bé trai', ''),
(26, 'Thời trang bé gái', 'thời trang bé gái'),
(28, 'Thời trang bà bầu', 'Thời trang cho bà bầu'),
(30, 'Thời trang công sở', 'Những bộ trang phục công sở sang trọng, lịch lãm');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `username` varchar(30) COLLATE utf8_bin NOT NULL,
  `fullname` varchar(30) COLLATE utf8_bin NOT NULL,
  `birthday` date NOT NULL,
  `address` varchar(100) COLLATE utf8_bin NOT NULL,
  `phonenumber` varchar(20) COLLATE utf8_bin NOT NULL,
  `balance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `username`, `fullname`, `birthday`, `address`, `phonenumber`, `balance`) VALUES
(16, 'jelly', 'Harry', '1991-07-23', 'Văn Quán', '01656286765', 330),
(17, 'admin', 'HarryWhite', '1991-07-23', 'Văn Quán', '01656286799', 30000),
(18, 'Luke', 'Lucky Luke', '1992-02-25', 'ha noi', '12345678', 341556);

--
-- Triggers `customer`
--
DELIMITER $$
CREATE TRIGGER `delete_customer` AFTER DELETE ON `customer` FOR EACH ROW begin
delete from user where username=old.username;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `title` varchar(145) DEFAULT NULL,
  `content` text,
  `createddate` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `title`, `content`, `createddate`) VALUES
(1, 'Giới thiệu công ty', '<p>abc</p>', '07/03/2014');

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `customerid` int(11) NOT NULL,
  `shiptime` datetime NOT NULL,
  `totalprice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`id`, `customerid`, `shiptime`, `totalprice`) VALUES
(36, 16, '2016-12-12 13:52:00', 670);

-- --------------------------------------------------------

--
-- Table structure for table `orderdetail`
--

CREATE TABLE `orderdetail` (
  `id` int(11) NOT NULL,
  `productid` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `orderid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `orderdetail`
--

INSERT INTO `orderdetail` (`id`, `productid`, `quantity`, `price`, `orderid`) VALUES
(1, 1, 1, 200, 3),
(2, 3, 3, 700, 4),
(4, 3, 4, 3500, 5),
(9, 9, 1, 320, 10),
(10, 1, 2, 400, 11),
(11, 7, 1, 400, 11),
(12, 5, 1, 250, 13),
(13, 10, 1, 135, 17),
(14, 7, 1, 400, 27),
(15, 1, 1, 200, 27),
(16, 9, 2, 640, 28),
(17, 13, 1, 345, 14),
(18, 18, 3, 423, 15),
(19, 14, 1, 510, 16),
(20, 14, 1, 510, 29),
(21, 19, 1, 300, 30),
(22, 9, 1, 320, 36),
(23, 3, 1, 350, 36);

--
-- Triggers `orderdetail`
--
DELIMITER $$
CREATE TRIGGER `update_quantity_2` AFTER INSERT ON `orderdetail` FOR EACH ROW begin
declare soluong integer;
set soluong=(select quantity from product where product.id=NEW.productid limit 1);
if (NEW.quantity < soluong) then
update product
set product.quantity=product.quantity-NEW.quantity
where product.id=NEW.productid;
end if;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_quantity_3` AFTER UPDATE ON `orderdetail` FOR EACH ROW begin
declare soluong integer;
set soluong=(select quantity from product where product.id=NEW.productid limit 1);
if (NEW.quantity < soluong) then
update product
set product.quantity=product.quantity-NEW.quantity
where product.id=NEW.productid;
end if;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `categoryid` int(11) NOT NULL,
  `name` varchar(128) COLLATE utf8_bin NOT NULL,
  `describes` text COLLATE utf8_bin,
  `price` int(11) NOT NULL,
  `image` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `article` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `categoryid`, `name`, `describes`, `price`, `image`, `quantity`, `article`) VALUES
(1, 26, 'váy hồng xinh xắn', 'váy hồng cho bé gái 10 tuổi, chất lượng vải đẹp, màu sắc trang nhã', 200, '1.jpg', 2, 'Mua hè này hãy mua cho con bạn những bộ đồ xinh xắn, đi du lịch, đi chơi và trong nhiều hoạt động khác'),
(3, 26, 'váy bò ', 'váy bò xinh xắn cho bé [New]', 350, '2.jpg', 2, NULL),
(5, 26, 'váy hồng có mũ', 'váy hồng có mũ, chất liệu vải cotton', 250, '3.jpg', 12, NULL),
(7, 26, 'váy bò xanh', 'váy bò màu xanh, cá tính', 400, '4.jpg', 8, NULL),
(8, 26, 'váy hồng có hoa', 'váy hồng có hoa, điệu đà cho bé gái', 230, '5.jpg', 5, NULL),
(9, 26, 'váy đỏ có túi', 'váy đỏ, 2 túi, cho bé năng động', 320, '7.jpg', 2, NULL),
(10, 26, 'chân váy hồng', 'váy hồng, xếp tầng, cho bé năng động', 135, '8.jpg', 11, NULL),
(11, 25, ' Bộ đồ sooc áo phông xanh', 'Bộ đồ sooc áo phông xanh [New]', 350, 'trai1.jpg', 5, '<p>test noi dung<img src="tinymce/plugins/emoticons/img/smiley-wink.gif" alt="" /></p>'),
(12, 25, 'Bộ đồ sooc áo 3 lỗ trắng', 'áo ba lỗ trắng viền xanh thẫm, quần đùi chất liệu bò', 500, 'trai2.jpg', 10, '<p>bai viet cho bo do nay</p>'),
(13, 25, 'Bộ sooc áo somi', 'Quần sooc xanh, áo sơ mi cộc tay sọc đỏ trắng', 345, 'trai3.jpg', 10, '<p><span style="color: #333333;">LT_BT037</span><br style="color: #333333;" /><strong><span style="color: #333333;">BỘ B&Eacute; TRAI CHILDRENS (USA)</span></strong><br style="color: #333333;" /><span style="color: #333333;">Size: 18M</span><br style="color: #333333;" /><span style="color: #333333;">Gi&aacute;: 395k</span></p>\r\n<p><span style="color: #333333; font-family: tahoma, arial, helvetica, sans-serif; font-size: small; line-height: 18px;"><strong>Lưu &yacute;</strong>: Để việc mua h&agrave;ng được thuận tiện v&agrave; nhanh ch&oacute;ng. Khi đặt h&agrave;ng Mom vui l&ograve;ng cho shop biết về số tuổi cũng như c&acirc;n nặng của b&eacute; để shop chọn size ph&ugrave; hợp. Hoặc gọi theo <strong>số điện thoại</strong> tr&ecirc;n h&igrave;nh để được tư vấn.</span></p>'),
(14, 25, 'Bộ sooc có quai', 'Bộ sooc có quai, áo sơ mi trắng cho bé nam tự tin, lịch lãm', 510, 'trai4.jpg', 1, '<p><img class="lazy" style="display: inline;" src="http://media3.sendo.vn/img/2013/11_10/bt3_2i3ra3og7t3fn_simg_19a19b_600x497_max.jpg" alt="" data-original="http://media3.sendo.vn/img/2013/11_10/bt3_2i3ra3og7t3fn_simg_19a19b_600x497_max.jpg" /><img class="lazy" style="display: inline;" src="http://media3.sendo.vn/img/2013/11_10/bt3_2_2i3ra4sgn9adg_simg_19a19b_600x497_max.jpg" alt="" data-original="http://media3.sendo.vn/img/2013/11_10/bt3_2_2i3ra4sgn9adg_simg_19a19b_600x497_max.jpg" /><img class="lazy" style="display: inline;" src="http://media3.sendo.vn/img/2013/11_10/bt3_5_2i3ra53s5k8oo_simg_19a19b_600x497_max.jpg" alt="" data-original="http://media3.sendo.vn/img/2013/11_10/bt3_5_2i3ra53s5k8oo_simg_19a19b_600x497_max.jpg" /><img class="lazy" style="display: inline;" src="http://media3.sendo.vn/img/2013/11_10/bt3__size_2i3ra5t56a8r0_simg_19a19b_600x497_max.jpg" alt="" data-original="http://media3.sendo.vn/img/2013/11_10/bt3__size_2i3ra5t56a8r0_simg_19a19b_600x497_max.jpg" /></p>'),
(15, 23, 'Áo thun cá sấu Trắng AT468-1', 'Áo thun cá sấu Trắng AT468-1', 150, 'nam1.jpg', 5, ''),
(16, 23, 'Áo Sơ Mi Nam Tay Dài Caro Xanh D9 - 9142', 'Công sở, Dạo phố, Dự tiệc ', 166, 'nam2.jpg', 11, '<p><strong>&Aacute;O SƠ MI THỜI TRANG NAM</strong></p>\r\n<p>C&aacute;c bạn xem th&ecirc;m sản phẩm của Mini Fashion tại:</p>\r\n<p><a href="http://www.sendo.vn/shop/minifashion">http://www.sendo.vn/shop/minifashion</a></p>\r\n<p><strong>Th&ocirc;ng tin v&agrave; đặc điểm sản phẩm:</strong></p>\r\n<h2><strong>Điểm nổi bật</strong></h2>\r\n<p>&Aacute;o sơ mi nam c&ocirc;ng sở&nbsp;&nbsp;được thiết kế theo&nbsp;phong c&aacute;ch thời trang, d&aacute;ng &ocirc;m s&aacute;t cơ thể, nhằm t&ocirc;n l&ecirc;n sự phong độ, trẻ trung, nam t&iacute;nh của ph&aacute;i mạnh.</p>\r\n<p>- Form d&aacute;ng chuẩn, kết hợp với chi tiết phối m&agrave;u nổi bật.</p>\r\n<p>- Chất liệu vải kate caro cao cấp, mềm mịn v&agrave; th&ocirc;ng tho&aacute;ng tối ưu, lu&ocirc;n tạo cảm gi&aacute;c thoải m&aacute;i khi mặc.</p>\r\n<p>- M&agrave;u sắc nh&atilde; nhặn, dễ d&agrave;ng mix c&ugrave;ng nhiều kiểu quần &acirc;u, jeans, kaki&hellip;</p>\r\n<p>- &Aacute;o sơ mi nam thiết kế tay d&agrave;i, cổ bẻ truyền thống t&ocirc;n l&ecirc;n vẻ lịch l&atilde;m, sang trọng nơi c&ocirc;ng sở.</p>\r\n<p>- Th&iacute;ch hợp mix c&ugrave;ng c&aacute;c kiểu quần &Acirc;u, kaki, jeans&hellip; đến c&ocirc;ng sở</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Hướng dẫn chọn size &aacute;o sơ mi nam:</strong></p>\r\n<p>Size M: 1m55 đến 1m68 (55kg - 62kg)Size L: 1m68 đến 1m75 (62kg - 68kg)Size XL: 1m80 trở xuống (68kg - 75kg)&nbsp;</p>'),
(17, 23, 'Áo polo Evisu Thời trang EVI_01', 'Dự tiệc, Thể thao, Công sở, Dã ngoại, Dạo phố, Mặc nhà ', 140, 'nam3.jpg', 30, ''),
(18, 24, 'Áo Sơ Mi Vai Đính Nút S191', 'Lụa tơ tằm ', 141, 'nu1.jpg', 3, '<p style="margin-top: 0px; margin-bottom: 20px; font-family: Arial, Helvetica, sans-serif; font-size: 12px; text-align: justify;"><span style="font-size: x-large;">Chất liệu: Tơ nhung</span></p>\r\n<p style="margin-top: 0px; margin-bottom: 20px; font-family: Arial, Helvetica, sans-serif; font-size: 12px; text-align: justify;"><span style="font-size: x-large;">M&agrave;u sắc: đen, hồng, đỏ</span></p>\r\n<p style="margin-top: 0px; margin-bottom: 20px; font-family: Arial, Helvetica, sans-serif; font-size: 12px; text-align: justify;"><span style="font-size: x-large;">Chiều d&agrave;i: 65cm</span></p>\r\n<p style="margin-top: 0px; margin-bottom: 20px; font-family: Arial, Helvetica, sans-serif; font-size: 12px; text-align: justify;"><span style="font-size: x-large;">V&ograve;ng ngực: 88- 92cm</span></p>\r\n<p style="margin-top: 0px; margin-bottom: 20px; font-family: Arial, Helvetica, sans-serif; font-size: 12px; text-align: justify;"><span style="font-size: x-large;">Eo: 68-72cm</span></p>\r\n<p style="margin-top: 0px; margin-bottom: 20px; font-family: Arial, Helvetica, sans-serif; font-size: 12px; text-align: justify;"><span style="font-size: x-large;">Ph&ugrave; hợp cho bạn g&aacute;i c&oacute; c&acirc;n nặng: 42-50kg, cao 1m50 trở l&ecirc;n</span></p>'),
(19, 24, 'Đầm 2 Dây Dún Eo M1789', 'Chất liệu:  - Thun Laza và Voan   Kích thước:  - Ngực 88-90cm; Eo 68-70cm; Dài 80cm', 300, 'nu2.jpg', 11, ''),
(20, 24, 'ĐẦM REN TRẮNG XÒE CHÉO LƯNG (E317)', 'ĐẦM REN TRẮNG XÒE CHÉO LƯNG (E317)', 189, 'anh3.jpg', 4, '<p><span style="padding: 0px; margin: 0px; font-size: 12px; vertical-align: baseline; border: 0px; list-style: none; color: #ff0000; line-height: 14.640000343322754px; background: transparent;"><strong>Shop c</strong><strong>huy&ecirc;n cung cấp c&aacute;c mẫu h&agrave;ng chất lượng, sử dụng vải c&acirc;y, kh&ocirc;ng d&ugrave;ng vải kg gi&aacute; rẻ.<br /></strong><br /></span><span style="padding: 0px; margin: 0px; font-size: medium; vertical-align: baseline; border: 0px; list-style: none; color: #0000ff; background: transparent;"><strong>0909.47.10.57 (Hạnh)</strong></span><a href="https://www.facebook.com/hanh.phan.xteenshop" target="_blank" rel="nofollow"><br /><br /><span style="padding: 0px; margin: 0px; font-size: x-large; vertical-align: baseline; color: #ff6600; border: 0px; list-style: none; background-color: transparent;">https://www.facebook.com/hanh.phan.xteenshop</span></a></p>'),
(21, 24, 'Áo sơ mi phối ren tay hoa GS115', 'Chất liệu:  - Voan phối Ren   Kích thước:  - Freesize, dành cho bạn nữ 43-53kg, cao 1m50 trở lên', 200, 'nu4.jpg', 5, '<h2 style="text-align: center;"><span style="font-size: 18px; color: #0000ff;">Thời Trang Năng Động</span></h2>\r\n<p style="text-align: center;"><span style="font-size: 16px;">Địa chỉ: 28/4 Văn Chung, Phường 13, Quận T&acirc;n B&igrave;nh, TP. Hồ Ch&iacute; Minh</span></p>\r\n<p><span style="font-size: 16px;">Điện thoại: <span style="color: #ff0000;"><strong>0982587493</strong></span></span><br /><br /><br /><br /><span style="font-size: 16.0pt; line-height: 115%; font-family: ''Times New Roman'',''serif''; color: #993366;">C&aacute;c bạn ở TP.HCM c&oacute; thể đến trực tiếp Shop v&agrave; mua h&agrave;ng. C&aacute;c bạn ở tỉnh th&igrave; gửi h&agrave;ng qua bưu điện hoặc ch&agrave;nh xe.<br /><br /> Thanh to&aacute;n : chuyển khoản qua ng&acirc;n h&agrave;ng hoặc dịch vụ COD ( giao h&agrave;ng v&agrave; thanh to&aacute;n tiền).<br /></span></p>');

-- --------------------------------------------------------

--
-- Table structure for table `resetpassword`
--

CREATE TABLE `resetpassword` (
  `username` text NOT NULL,
  `token` text NOT NULL,
  `date_expired` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `resetpassword`
--

INSERT INTO `resetpassword` (`username`, `token`, `date_expired`) VALUES
('jelly', 'c5be2d532d66e107e0c85b234bb698dafdd3a8fd1fdf51839a16a5d060ddf57a', '2016-12-13');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `username` varchar(30) COLLATE utf8_bin NOT NULL,
  `pword` varchar(256) COLLATE utf8_bin NOT NULL,
  `role` int(11) NOT NULL,
  `email` varchar(50) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`username`, `pword`, `role`, `email`) VALUES
('Luke', '242b1620250f7f6f3d0d2d273993ffa91adf39e1f3216ad9b6b43db05ec591bb', 2, 'hungkieuptit2010@gmail.com'),
('admin', 'd601b199a9120309982a5933d109dcfd0f3aaa37394e6a8ef5962d5b2922fc46', 1, 'admin@foodstore.vn'),
('hung', '242b1620250f7f6f3d0d2d273993ffa91adf39e1f3216ad9b6b43db05ec591bb', 2, 'hungkieu@gmail.com'),
('jelly', '242b1620250f7f6f3d0d2d273993ffa91adf39e1f3216ad9b6b43db05ec591bb', 2, 'thminh.cseiu@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `balancesource`
--
ALTER TABLE `balancesource`
  ADD PRIMARY KEY (`source`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phonenumber_UNIQUE` (`phonenumber`),
  ADD UNIQUE KEY `username_UNIQUE` (`username`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orderdetail`
--
ALTER TABLE `orderdetail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`);

--
-- Indexes for table `resetpassword`
--
ALTER TABLE `resetpassword`
  ADD UNIQUE KEY `username` (`username`(20));

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`username`),
  ADD UNIQUE KEY `username_UNIQUE` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT for table `orderdetail`
--
ALTER TABLE `orderdetail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
