CREATE DATABASE IF NOT EXISTS quan_ly_nha_hang
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE quan_ly_nha_hang;

CREATE TABLE nguoi_dung (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ho_ten VARCHAR(100) NOT NULL,
    tai_khoan VARCHAR(50) UNIQUE NOT NULL,
    mat_khau VARCHAR(255) NOT NULL,
    sdt VARCHAR(15),
    email VARCHAR(100),
    vai_tro ENUM('admin','nhanvien','khachhang') DEFAULT 'khachhang',
    trang_thai INT DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE danh_muc (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ten VARCHAR(100) NOT NULL,
    mo_ta TEXT,
    trang_thai INT DEFAULT 1
);

CREATE TABLE mon_an (
    id INT AUTO_INCREMENT PRIMARY KEY,
    danh_muc_id INT,
    ten VARCHAR(100) NOT NULL,
    gia DECIMAL(10,2) NOT NULL,
    mo_ta TEXT,
    hinh_anh VARCHAR(255),
    trang_thai INT DEFAULT 1,
    FOREIGN KEY (danh_muc_id) REFERENCES danh_muc(id)
);

CREATE TABLE ban_an (
    id INT AUTO_INCREMENT PRIMARY KEY,
    so_ban INT NOT NULL,
    suc_chua INT,
    trang_thai ENUM('trong','da_dat','dang_dung') DEFAULT 'trong'
);

CREATE TABLE dat_ban (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ban_id INT NOT NULL,
    nguoi_dat_id INT NOT NULL,
    ngay DATE NOT NULL,
    gio TIME NOT NULL,
    so_nguoi INT,
    ghi_chu TEXT,
    trang_thai ENUM('cho_xac_nhan','da_xac_nhan','da_huy') DEFAULT 'cho_xac_nhan',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ban_id) REFERENCES ban_an(id),
    FOREIGN KEY (nguoi_dat_id) REFERENCES nguoi_dung(id)
);

CREATE TABLE don_order (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dat_ban_id INT NOT NULL,
    tong_tien DECIMAL(10,2) DEFAULT 0,
    trang_thai ENUM('dang_order','da_thanh_toan','da_huy') DEFAULT 'dang_order',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dat_ban_id) REFERENCES dat_ban(id)
);

CREATE TABLE chi_tiet_order (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    mon_an_id INT NOT NULL,
    so_luong INT NOT NULL,
    don_gia DECIMAL(10,2) NOT NULL,
    thanh_tien DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES don_order(id),
    FOREIGN KEY (mon_an_id) REFERENCES mon_an(id)
);

CREATE TABLE hoa_don (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    tong_tien DECIMAL(10,2) NOT NULL,
    phuong_thuc_tt VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES don_order(id)
);

INSERT INTO nguoi_dung (ho_ten, tai_khoan, mat_khau, vai_tro) VALUES
('Quan Ly', 'admin', '123456', 'admin'),
('Duong The Khanh', 'nv01', '123456', 'nhanvien'),
('Nguyen Hoang Le Huy', 'nv02', '123456', 'nhanvien'),
('Nguyen Van B', 'nv03', '123456', 'nhanvien'),
('Nguyen Van A', 'nv04', '123456', 'nhanvien');

INSERT INTO danh_muc (ten) VALUES
('Khai vị'), ('Món chính'), ('Tráng miệng'), ('Đồ uống');

INSERT INTO ban_an (so_ban, suc_chua) VALUES
(1, 4), (2, 4), (3, 6), (4, 6), (5, 8);
INSERT INTO mon_an (danh_muc_id, ten, gia) VALUES
(1, 'Salad tôm hùm cao cấp', 285000),
(1, 'Súp vi cá hầm', 320000),
(1, 'Gỏi ngó sen tôm thịt', 125000),
(1, 'Bánh mì nướng bơ tỏi phomai', 85000),
(2, 'Bò Wagyu áp chảo sốt tiêu đen', 650000),
(2, 'Tôm hùm nướng bơ tỏi', 850000),
(2, 'Cá hồi áp chảo sốt chanh leo', 320000),
(2, 'Sườn bò nướng BBQ kiểu Mỹ', 420000),
(2, 'Mực nhồi thịt sốt cà chua', 185000),
(2, 'Cơm rang hải sản hoàng gia', 145000),
(3, 'Bánh Tiramisu Ý', 95000),
(3, 'Crème Brûlée', 85000),
(3, 'Mousse chanh dây', 75000),
(3, 'Kem gelato 3 vị', 65000),
(4, 'Rượu vang đỏ Pháp (ly)', 185000),
(4, 'Cocktail Mojito', 95000),
(4, 'Nước ép lựu tươi', 65000),
(4, 'Trà hoa cúc mật ong', 55000),
(4, 'Cappuccino', 65000);
