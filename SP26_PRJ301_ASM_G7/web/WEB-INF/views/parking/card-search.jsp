<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Tra Cứu Thẻ Và Xe Trong Bãi</title>
    
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        /* --- ROOT & BASE CSS --- */
        :root {
            --bs-body-bg: #f8fafc; /* Màu nền xám nhạt theo thiết kế */
            --bs-primary: #1a56db;
            --bs-primary-rgb: 26, 86, 219;
            --bs-font-sans-serif: 'Inter', sans-serif;
            --text-main: #334155;
            --text-muted: #64748b;
            --navbar-height: 70px;
        }
        body {
            font-family: var(--bs-font-sans-serif);
            color: var(--text-main);
            -webkit-font-smoothing: antialiased;
            background-color: var(--bs-body-bg);
            margin: 0;
            padding-bottom: 50px; /* Dành chỗ cho footer */
        }

        /* --- CUSTOM COMPONENT CSS --- */
        .card-custom {
            border: none;
            border-radius: 12px;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
            background: #fff;
            margin-bottom: 1.5rem;
        }

        /* Tùy chỉnh Tabs */
        .nav-tabs-custom {
            border-bottom: 1px solid #e2e8f0;
            margin-bottom: 1.5rem;
        }
        .nav-tabs-custom .nav-link {
            border: none;
            color: var(--text-muted);
            font-weight: 500;
            padding: 1rem 1.5rem;
            background: transparent;
        }
        .nav-tabs-custom .nav-link:hover {
            color: var(--bs-primary);
        }
        .nav-tabs-custom .nav-link.active {
            color: var(--bs-primary);
            border-bottom: 2px solid var(--bs-primary);
            font-weight: 600;
        }

        /* Search Bar */
        .search-container {
            background: #fff;
            padding: 1.5rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
        }
        .search-input-group {
            background: #f8fafc;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
            padding: 0.25rem;
        }
        .search-input-group input {
            background: transparent;
            border: none;
            box-shadow: none;
            padding-left: 1rem;
        }
        .search-input-group input:focus {
            background: transparent;
        }
        .btn-search {
            border-radius: 6px;
            font-weight: 500;
            padding: 0.6rem 2rem;
        }

        /* Typography cho Label và Value */
        .info-label {
            font-size: 0.75rem;
            text-transform: uppercase;
            color: var(--text-muted);
            letter-spacing: 0.5px;
            margin-bottom: 0.25rem;
            font-weight: 500;
        }
        .info-value {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-main);
        }
        .value-large {
            font-size: 1.4rem;
        }

        /* Badges */
        .badge-soft-success { background-color: #dcfce7; color: #16a34a; font-weight: 500; padding: 6px 12px; border-radius: 20px;}
        .badge-soft-warning { background-color: #ffedd5; color: #ea580c; font-weight: 500; padding: 6px 12px; border-radius: 20px;}
        .badge-outline { border: 1px solid #e2e8f0; background: #f8fafc; color: var(--text-muted); padding: 4px 10px; border-radius: 20px;}

        /* Images */
        .img-container {
            border-radius: 8px;
            overflow: hidden;
            background: #000;
            position: relative;
        }
        .img-container img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            display: block;
        }
        .img-overlay-text {
            position: absolute;
            bottom: 8px;
            right: 8px;
            background: rgba(0,0,0,0.7);
            color: white;
            font-size: 0.7rem;
            padding: 2px 6px;
            border-radius: 4px;
        }

        /* Table custom */
        .table-custom th {
            color: var(--text-muted);
            font-weight: 500;
            font-size: 0.85rem;
            border-bottom-width: 1px;
            padding: 1rem;
        }
        .table-custom td {
            padding: 1rem;
            vertical-align: middle;
            color: var(--text-main);
            border-bottom-color: #f1f5f9;
        }

        /* Topbar / Header giả lập */
        .page-header {
            background: #fff;
            padding: 1rem 2rem;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Footer status bar */
        .footer-status {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            background: #fff;
            border-top: 1px solid #e2e8f0;
            padding: 0.5rem 2rem;
            font-size: 0.8rem;
            display: flex;
            justify-content: space-between;
            color: var(--text-muted);
            z-index: 1000;
        }
    </style>
</head>
<body>

    <header class="page-header">
        <h4 class="mb-0 fw-bold">Tra Cứu Thẻ Và Xe Trong Bãi</h4>
        <div class="d-flex align-items-center gap-3 text-muted">
            <i class="bi bi-bell fs-5"></i>
            <span class="border-start ps-3">14:30 | 25/10/2023</span>
        </div>
    </header>

    <main class="container-fluid py-4" style="max-width: 1200px;">
        
        <ul class="nav nav-tabs nav-tabs-custom" id="searchTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="vehicle-tab" data-bs-toggle="tab" data-bs-target="#vehicle-pane" type="button" role="tab">Tra cứu xe trong bãi</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="card-tab" data-bs-toggle="tab" data-bs-target="#card-pane" type="button" role="tab">Tra cứu thẻ xe</button>
            </li>
        </ul>

        <div class="tab-content" id="searchTabsContent">
            
            <div class="tab-pane show active" id="vehicle-pane" role="tabpanel">
                
                <div class="search-container d-flex gap-2">
                    <div class="input-group search-input-group flex-grow-1">
                        <span class="input-group-text bg-transparent border-0 text-muted"><i class="bi bi-search"></i></span>
                        <input type="text" class="form-control border-0" placeholder="Nhập biển số xe (VD: 30A-123.45)...">
                    </div>
                    <button class="btn btn-primary btn-search"><i class="bi bi-search me-1"></i> Tìm kiếm</button>
                </div>

                <h5 class="fw-bold mb-3 text-primary d-flex align-items-center">
                    <i class="bi bi-bar-chart-fill me-2"></i> Kết quả tra cứu
                </h5>

                <div class="row g-4">
                    <div class="col-lg-8">
                        <div class="card card-custom p-4 mb-4">
                            <div class="row g-4">
                                <div class="col-sm-6">
                                    <div class="info-label">Biển số xe</div>
                                    <div class="info-value value-large">30A-888.88</div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="info-label">Mã thẻ RFID</div>
                                    <div class="info-value value-large">0004561239</div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="info-label">Thời gian vào</div>
                                    <div class="info-value">08:15:30 - 25/10/2023</div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="info-label">Khu vực đang đỗ</div>
                                    <div class="info-value text-success"><i class="bi bi-circle-fill" style="font-size: 0.5rem; vertical-align: middle;"></i> Tầng B1 - Khu A - Vị trí 12</div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="info-label">Loại xe</div>
                                    <div class="info-value">Ô tô 4 chỗ (Vé tháng)</div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="info-label">Trạng thái phí</div>
                                    <div><span class="badge badge-soft-success">Đã đóng (Hạn: 30/11)</span></div>
                                </div>
                            </div>
                        </div>

                        <div class="card card-custom p-4">
                            <h6 class="fw-bold mb-3">Giao dịch gần nhất</h6>
                            <div class="table-responsive">
                                <table class="table table-custom mb-0">
                                    <thead>
                                        <tr>
                                            <th>Thời gian</th>
                                            <th>Hành động</th>
                                            <th>Cổng</th>
                                            <th>Nhân viên</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td colspan="4" class="text-muted text-center py-3 font-italic" style="background: #f8fafc; border-radius: 8px;">
                                                <small>Kết quả tra cứu chi tiết thẻ sẽ hiển thị tại tab 'Tra cứu thẻ xe'</small>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="card card-custom p-3 mb-3">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <div class="info-label mb-0">Ảnh chụp lúc vào (Toàn cảnh)</div>
                                <i class="bi bi-fullscreen text-muted cursor-pointer"></i>
                            </div>
                            <div class="img-container">
                                <img src="https://images.unsplash.com/photo-1506521781263-d8422e82f27a?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Toàn cảnh">
                                <div class="img-overlay-text">CAM-01 | 08:15:30</div>
                            </div>
                        </div>

                        <div class="card card-custom p-3">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <div class="info-label mb-0">Ảnh chụp biển số</div>
                                <i class="bi bi-fullscreen text-muted cursor-pointer"></i>
                            </div>
                            <div class="img-container">
                                <img src="https://images.unsplash.com/photo-1621532400971-55db5264b9d0?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Biển số">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tab-pane" id="card-pane" role="tabpanel">
                
                <div class="search-container d-flex gap-2">
                    <div class="input-group search-input-group flex-grow-1">
                        <span class="input-group-text bg-transparent border-0 text-muted"><i class="bi bi-search"></i></span>
                        <input type="text" class="form-control border-0" placeholder="Nhập mã số thẻ RFID (Ví dụ: 000456...)">
                    </div>
                    <button class="btn btn-primary btn-search"><i class="bi bi-search me-1"></i> Tìm kiếm</button>
                </div>

                <h5 class="fw-bold mb-3 text-primary d-flex align-items-center">
                    <i class="bi bi-credit-card-2-front me-2"></i> Kết quả tra cứu thẻ
                </h5>

                <div class="card card-custom p-4 mb-4">
                    <div class="row g-4">
                        <div class="col-md-4 col-sm-6">
                            <div class="info-label">Mã thẻ RFID</div>
                            <div class="info-value value-large">0004561239</div>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <div class="info-label">Trạng thái</div>
                            <div><span class="badge badge-soft-success">Đang sử dụng</span></div>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <div class="info-label">Loại thẻ</div>
                            <div class="info-value">Vé tháng</div>
                        </div>
                        
                        <div class="col-md-4 col-sm-6">
                            <div class="info-label">Chủ sở hữu</div>
                            <div class="info-value d-flex align-items-center gap-2">
                                <span class="badge-outline">NV</span> Nguyễn Văn B
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <div class="info-label">Biển số đăng ký</div>
                            <div class="info-value">30A-888.88</div>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <div class="info-label">Ngày hết hạn</div>
                            <div class="info-value text-danger">30/11/2023</div>
                        </div>
                    </div>
                </div>

                <div class="card card-custom p-0 overflow-hidden">
                    <div class="d-flex justify-content-between align-items-center p-4 border-bottom">
                        <h6 class="fw-bold mb-0 text-muted"><i class="bi bi-clock-history me-2"></i> Giao dịch gần nhất</h6>
                        <a href="#" class="text-primary text-decoration-none small">Xem tất cả</a>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-custom table-hover mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">Thời gian</th>
                                    <th>Hành động</th>
                                    <th>Cổng</th>
                                    <th class="pe-4">Nhân viên trực</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="ps-4">08:15:30 - 25/10/2023</td>
                                    <td><span class="badge badge-soft-success"><i class="bi bi-box-arrow-in-right"></i> Vào</span></td>
                                    <td>Cổng A - Làn 1</td>
                                    <td class="pe-4">Nguyễn Văn A</td>
                                </tr>
                                <tr>
                                    <td class="ps-4">17:45:12 - 24/10/2023</td>
                                    <td><span class="badge badge-soft-warning"><i class="bi bi-box-arrow-right"></i> Ra</span></td>
                                    <td>Cổng B - Làn 2</td>
                                    <td class="pe-4">Trần Thị C</td>
                                </tr>
                                <tr>
                                    <td class="ps-4">07:50:22 - 24/10/2023</td>
                                    <td><span class="badge badge-soft-success"><i class="bi bi-box-arrow-in-right"></i> Vào</span></td>
                                    <td>Cổng A - Làn 1</td>
                                    <td class="pe-4">Nguyễn Văn A</td>
                                </tr>
                                <tr>
                                    <td class="ps-4">18:05:00 - 23/10/2023</td>
                                    <td><span class="badge badge-soft-warning"><i class="bi bi-box-arrow-right"></i> Ra</span></td>
                                    <td>Cổng B - Làn 2</td>
                                    <td class="pe-4">Trần Thị C</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </main>

    <div class="footer-status">
        <div class="d-flex align-items-center gap-3">
            <span class="text-success fw-medium"><i class="bi bi-circle-fill small me-1"></i> Hệ thống trực tuyến</span>
            <span class="d-none d-sm-inline">Thiết bị: RFID-Reader-04, CAM-Gate-01, CAM-Gate-02</span>
        </div>
        <div>
            Phần mềm Quản lý Bãi xe v2.4.0
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>