-- Thêm cột lưu người tạo phiếu (nhập/xuất) vào bảng invoice
-- Chạy script này trên database inventory_management trước khi build/run lại ứng dụng

ALTER TABLE invoice
    ADD COLUMN CREATE_BY INT NULL AFTER UPDATE_DATE;

ALTER TABLE invoice
    ADD CONSTRAINT fk_invoice_create_by
    FOREIGN KEY (CREATE_BY) REFERENCES users(ID);

-- Các phiếu cũ (đã tạo trước khi có tính năng này) sẽ có CREATE_BY = NULL,
-- giao diện sẽ hiển thị dấu "-" cho những phiếu đó.
