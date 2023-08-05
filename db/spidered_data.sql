CREATE DATABASE spidered_data;
USE spidered_data;
-- spidered_data.battery_piece_price definition

CREATE TABLE `battery_piece_price` (
  `name` varchar(255) DEFAULT NULL COMMENT '材料名称',
  `price_range` varchar(255) DEFAULT NULL COMMENT '价格范围',
  `avg_price` decimal(10,4) DEFAULT NULL COMMENT '均价',
  `up_down_price` decimal(10,4) DEFAULT NULL COMMENT '涨跌',
  `unit` varchar(255) DEFAULT NULL COMMENT '单位',
  `dt` varchar(255) DEFAULT NULL COMMENT '日期',
  `get_dt` varchar(255) DEFAULT NULL COMMENT '采集日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='电池片价格';


-- spidered_data.copper_price definition

CREATE TABLE `copper_price` (
  `name` varchar(255) DEFAULT NULL COMMENT '材料名称',
  `price_range` varchar(255) DEFAULT NULL COMMENT '价格范围',
  `avg_price` decimal(10,4) DEFAULT NULL COMMENT '均价',
  `up_down_price` decimal(10,4) DEFAULT NULL COMMENT '涨跌',
  `unit` varchar(255) DEFAULT NULL COMMENT '单位',
  `dt` varchar(255) DEFAULT NULL COMMENT '日期',
  `get_dt` varchar(255) DEFAULT NULL COMMENT '采集日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- spidered_data.dmc_price definition

CREATE TABLE `dmc_price` (
  `name` varchar(255) DEFAULT NULL COMMENT '材料名称',
  `price_range` varchar(255) DEFAULT NULL COMMENT '价格范围',
  `avg_price` decimal(10,4) DEFAULT NULL COMMENT '均价',
  `up_down_price` decimal(10,4) DEFAULT NULL COMMENT '涨跌',
  `unit` varchar(255) DEFAULT NULL COMMENT '单位',
  `dt` varchar(255) DEFAULT NULL COMMENT '日期',
  `get_dt` varchar(255) DEFAULT NULL COMMENT '采集日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='eva价格';


-- spidered_data.eva_price definition

CREATE TABLE `eva_price` (
  `name` varchar(255) DEFAULT NULL COMMENT '材料名称',
  `price_range` varchar(255) DEFAULT NULL COMMENT '价格范围',
  `avg_price` decimal(10,4) DEFAULT NULL COMMENT '均价',
  `up_down_price` decimal(10,4) DEFAULT NULL COMMENT '涨跌',
  `unit` varchar(255) DEFAULT NULL COMMENT '单位',
  `dt` varchar(255) DEFAULT NULL COMMENT '日期',
  `get_dt` varchar(255) DEFAULT NULL COMMENT '采集日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='eva价格';


-- spidered_data.module_price definition

CREATE TABLE `module_price` (
  `name` varchar(255) DEFAULT NULL COMMENT '材料名称',
  `price_range` varchar(255) DEFAULT NULL COMMENT '价格范围',
  `avg_price` decimal(10,4) DEFAULT NULL COMMENT '均价',
  `up_down_price` decimal(10,4) DEFAULT NULL COMMENT '涨跌',
  `unit` varchar(255) DEFAULT NULL COMMENT '单位',
  `dt` varchar(255) DEFAULT NULL COMMENT '日期',
  `get_dt` varchar(255) DEFAULT NULL COMMENT '采集日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='组件价格';


-- spidered_data.photovoltaic_border_price definition

CREATE TABLE `photovoltaic_border_price` (
  `name` varchar(255) DEFAULT NULL COMMENT '材料名称',
  `price_range` varchar(255) DEFAULT NULL COMMENT '价格范围',
  `avg_price` decimal(10,4) DEFAULT NULL COMMENT '均价',
  `up_down_price` decimal(10,4) DEFAULT NULL COMMENT '涨跌',
  `unit` varchar(255) DEFAULT NULL COMMENT '单位',
  `dt` varchar(255) DEFAULT NULL COMMENT '日期',
  `get_dt` varchar(255) DEFAULT NULL COMMENT '采集日期',
  `site_num` varchar(100) DEFAULT NULL COMMENT '来源网站'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='光伏边框价格';


-- spidered_data.photovoltaic_film_price definition

CREATE TABLE `photovoltaic_film_price` (
  `name` varchar(255) DEFAULT NULL COMMENT '材料名称',
  `price_range` varchar(255) DEFAULT NULL COMMENT '价格范围',
  `avg_price` decimal(10,4) DEFAULT NULL COMMENT '均价',
  `up_down_price` decimal(10,4) DEFAULT NULL COMMENT '涨跌',
  `unit` varchar(255) DEFAULT NULL COMMENT '单位',
  `dt` varchar(255) DEFAULT NULL COMMENT '日期',
  `get_dt` varchar(255) DEFAULT NULL COMMENT '采集日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='光伏胶膜价格';


-- spidered_data.photovoltaic_glass_price definition

CREATE TABLE `photovoltaic_glass_price` (
  `name` varchar(255) DEFAULT NULL COMMENT '材料名称',
  `price_range` varchar(255) DEFAULT NULL COMMENT '价格范围',
  `avg_price` decimal(10,4) DEFAULT NULL COMMENT '均价',
  `up_down_price` decimal(10,4) DEFAULT NULL COMMENT '涨跌',
  `unit` varchar(255) DEFAULT NULL COMMENT '单位',
  `dt` varchar(255) DEFAULT NULL COMMENT '日期',
  `get_dt` varchar(255) DEFAULT NULL COMMENT '采集日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='光伏玻璃价格';


-- spidered_data.poly_silicon_price definition

CREATE TABLE `poly_silicon_price` (
  `name` varchar(255) DEFAULT NULL COMMENT '材料名称',
  `price_range` varchar(255) DEFAULT NULL COMMENT '价格范围',
  `avg_price` decimal(10,4) DEFAULT NULL COMMENT '均价',
  `up_down_price` decimal(10,4) DEFAULT NULL COMMENT '涨跌',
  `unit` varchar(255) DEFAULT NULL COMMENT '单位',
  `dt` varchar(255) DEFAULT NULL COMMENT '日期',
  `get_dt` varchar(255) DEFAULT NULL COMMENT '采集日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='多晶硅价格';


-- spidered_data.pv_gf_market_price definition

CREATE TABLE `pv_gf_market_price` (
  `catalog` varchar(255) DEFAULT NULL,
  `pro_nm` varchar(255) DEFAULT NULL,
  `hight_point` decimal(10,4) DEFAULT NULL,
  `lower_point` decimal(10,4) DEFAULT NULL,
  `avg_price` decimal(10,4) DEFAULT NULL,
  `up_rate_percent` varchar(255) DEFAULT NULL,
  `up_rate_dollar` varchar(255) DEFAULT NULL,
  `next_week_price` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dt` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- spidered_data.silicon_chip_price definition

CREATE TABLE `silicon_chip_price` (
  `name` varchar(255) DEFAULT NULL COMMENT '材料名称',
  `price_range` varchar(255) DEFAULT NULL COMMENT '价格范围',
  `avg_price` decimal(10,4) DEFAULT NULL COMMENT '均价',
  `up_down_price` decimal(10,4) DEFAULT NULL COMMENT '涨跌',
  `unit` varchar(255) DEFAULT NULL COMMENT '单位',
  `dt` varchar(255) DEFAULT NULL COMMENT '日期',
  `get_dt` varchar(255) DEFAULT NULL COMMENT '采集日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='硅片价格';


-- spidered_data.silicon_price definition

CREATE TABLE `silicon_price` (
  `name` varchar(255) DEFAULT NULL COMMENT '材料名称',
  `price_range` varchar(255) DEFAULT NULL COMMENT '价格范围',
  `avg_price` decimal(10,4) DEFAULT NULL COMMENT '均价',
  `up_down_price` decimal(10,4) DEFAULT NULL COMMENT '涨跌',
  `unit` varchar(255) DEFAULT NULL COMMENT '单位',
  `dt` varchar(255) DEFAULT NULL COMMENT '日期',
  `get_dt` varchar(255) DEFAULT NULL COMMENT '采集日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='硅粉价格';


-- spidered_data.silver_paste_price definition

CREATE TABLE `silver_paste_price` (
  `name` varchar(255) DEFAULT NULL COMMENT '材料名称',
  `price_range` varchar(255) DEFAULT NULL COMMENT '价格范围',
  `avg_price` decimal(10,4) DEFAULT NULL COMMENT '均价',
  `up_down_price` decimal(10,4) DEFAULT NULL COMMENT '涨跌',
  `unit` varchar(255) DEFAULT NULL COMMENT '单位',
  `dt` varchar(255) DEFAULT NULL COMMENT '日期',
  `get_dt` varchar(255) DEFAULT NULL COMMENT '采集日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='银浆价格';


-- spidered_data.smm_price definition

CREATE TABLE `smm_price` (
  `name` varchar(255) DEFAULT NULL COMMENT '材料名称',
  `price_range` varchar(255) DEFAULT NULL COMMENT '价格范围',
  `avg_price` decimal(10,4) DEFAULT NULL COMMENT '均价',
  `up_down_price` decimal(10,4) DEFAULT NULL COMMENT '涨跌',
  `unit` varchar(255) DEFAULT NULL COMMENT '单位',
  `dt` varchar(255) DEFAULT NULL COMMENT '日期',
  `get_dt` varchar(255) DEFAULT NULL COMMENT '采集日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='eva价格';



ALTER TABLE battery_piece_price  ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE copper_price  ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE dmc_price  ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE eva_price  ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE module_price  ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE photovoltaic_border_price  ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE photovoltaic_film_price  ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE photovoltaic_glass_price  ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE silicon_price  ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE pv_gf_market_price  ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE silicon_chip_price  ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE poly_silicon_price  ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE silver_paste_price  ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE silver_pirce  ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
ALTER TABLE smm_price  ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;