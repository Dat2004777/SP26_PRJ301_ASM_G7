<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết bãi xe | Smart Parking</title>

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

        <style>
            :root {
                --bs-primary: #2563eb;
                --bg-body: #f8fafc;
                --sidebar-width: 260px;
                --text-main: #334155;
                --text-muted: #64748b;
                --border-color: #e2e8f0;
            }

            body {
                font-family: 'Inter', sans-serif;
                background-color: var(--bg-body);
                color: var(--text-main);
                overflow-x: hidden;
            }

            /* --- Layout --- */
            .sidebar {
                width: var(--sidebar-width);
                background-color: #ffffff;
                border-right: 1px solid var(--border-color);
                height: 100vh;
                position: fixed;
                top: 0; left: 0; z-index: 1040;
                transition: transform 0.3s ease-in-out;
            }
            .main-content {
                margin-left: var(--sidebar-width);
                min-height: 100vh;
                transition: margin-left 0.3s ease-in-out;
            }
            .top-header {
                height: 80px;
                background-color: #ffffff;
                border-bottom: 1px solid var(--border-color);
                display: flex;
                align-items: center;
                padding: 0 2rem;
                position: sticky;
                top: 0; z-index: 1030;
            }
            .content-area {
                padding: 2rem;
                max-width: 950px;
                margin: 0 auto;
                width: 100%;
            }

            /* --- Detail View Styles --- */
            .custom-card {
                background-color: #ffffff;
                border-radius: 12px;
                border: 1px solid var(--border-color);
                box-shadow: 0 1px 2px rgba(0,0,0,0.02);
                padding: 2.5rem;
                margin-bottom: 1.5rem;
            }
            
            .info-group {
                margin-bottom: 1.5rem;
            }
            
            .info-label {
                font-size: 0.8rem;
                font-weight: 600;
                color: var(--text-muted);
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-bottom: 0.4rem;
            }
            
            .info-value {
                font-size: 1.1rem;
                font-weight: 500;
                color: var(--text-main);
            }
            
            .info-value.large {
                font-size: 1.4rem;
                font-weight: 700;
                color: #0f172a;
            }

            .info-value i {
                color: var(--bs-primary);
                margin-right: 8px;
            }

            /* --- Vehicle Config Display (RESPONSIVE) --- */
            .vehicle-card {
                background-color: #f8fafc;
                border: 1px solid #e2e8f0;
                border-radius: 12px;
                margin-bottom: 1.25rem;
            }
            
            .vehicle-icon {
                width: 56px;
                height: 56px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.75rem;
            }

            .vehicle-stat {
                display: flex;
                flex-direction: column;
            }

            .vehicle-stat-label {
                font-size: 0.8rem;
                font-weight: 500;
                color: var(--text-muted);
                margin-bottom: 0.25rem;
            }

            .vehicle-stat-value {
                font-weight: 700;
                color: var(--text-main);
            }

            /* Badges */
            .badge-soft-success {
                background-color: #dcfce7;
                color: #15803d;
                border: 1px solid #bbf7d0;
                padding: 6px 12px;
                border-radius: 20px;
                font-weight: 600;
                font-size: 0.85rem;
                display: inline-block;
            }

            /* Map Placeholder */
            .map-placeholder {
                background-color: #e2e8f0;
                background-image: radial-gradient(circle at 50% 0%, #f1f5f9 0%, transparent 70%);
                border: 1px dashed #cbd5e1;
                border-radius: 12px;
                height: 300px;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                color: #475569;
                position: relative;
                overflow: hidden;
            }

            /* --- Responsive --- */
            #mobileToggle { display: none; }
            
            @media (max-width: 991.98px) {
                .sidebar { transform: translateX(-100%); }
                .sidebar.active { transform: translateX(0); }
                .main-content { margin-left: 0; }
                #mobileToggle {
                    display: block; background: none; border: none; font-size: 1.5rem; color: #0f172a; padding: 0; margin-right: 15px;
                }
                .top-header { padding: 0 1.5rem; }
                .content-area { padding: 1.5rem; }
            }
            
            @media (max-width: 575.98px) {
                .custom-card { padding: 1.5rem; }
                .vehicle-icon {
                    width: 48px;
                    height: 48px;
                    font-size: 1.5rem;
                }
                .vehicle-stat-value {
                    font-size: 0.95rem; /* Thu nhỏ nhẹ text trên mobile */
                }
            }
        </style>
    </head>
    <body>

        <jsp:include page="../../layout/admin-sidebar.jsp">
            <jsp:param name="activepage" value="adminSite" />
        </jsp:include>

        <main class="main-content">
            <header class="top-header">
                <div class="d-flex align-items-center">
                    <button id="mobileToggle" aria-label="Toggle menu">
                        <i class="bi bi-list"></i>
                    </button>
                    <h1 class="page-title m-0 fw-bold fs-4">Thông tin bãi đỗ xe</h1>
                </div>
            </header>

            <div class="content-area">
                <div class="mb-4 d-flex flex-column flex-sm-row justify-content-between align-items-sm-end gap-2">
                    <p class="text-muted m-0">Chi tiết cấu hình và sức chứa của bãi xe hiện tại.</p>
                </div>

                <div class="custom-card">
                    <div class="row g-4">
                        <div class="col-12">
                            <div class="info-group m-0">
                                <div class="info-label">Tên bãi xe</div>
                                <div class="info-value large text-primary text-break">Bãi xe ParkEasy Quận 1</div>
                            </div>
                        </div>

                        <div class="col-12">
                            <div class="info-group m-0">
                                <div class="info-label">Địa chỉ chi tiết</div>
                                <div class="info-value text-break"><i class="bi bi-geo-alt-fill"></i> 123 Đường Lê Lợi, Phường Bến Nghé, Quận 1, TP.HCM</div>
                            </div>
                        </div>

                        <div class="col-12 col-md-4">
                            <div class="info-group m-0">
                                <div class="info-label">Khu vực quản lý</div>
                                <div class="info-value">Quận 1</div>
                            </div>
                        </div>

                        <div class="col-12 col-md-4">
                            <div class="info-group m-0">
                                <div class="info-label">Nhân viên phụ trách</div>
                                <div class="info-value"><i class="bi bi-person-badge"></i> Nguyễn Văn A</div>
                            </div>
                        </div>

                        <div class="col-12 col-md-4">
                            <div class="info-group m-0">
                                <div class="info-label">Trạng thái hiện tại</div>
                                <div><span class="badge-soft-success"><i class="bi bi-check-circle-fill me-1"></i> Đang hoạt động</span></div>
                            </div>
                        </div>
                    </div>

                    <div class="mt-5 pt-4 border-top">
                        <h5 class="fw-bold mb-4" style="font-size: 1.1rem; color: #0f172a;">Cấu hình sức chứa & Bảng giá</h5>
                        
                        <div class="vehicle-card p-3 p-md-4 d-flex flex-column flex-md-row align-items-start align-items-md-center gap-3 gap-md-4">
                            <div class="vehicle-icon flex-shrink-0" style="background-color: #eff6ff; color: #2563eb;">
                                <i class="bi bi-car-front-fill"></i>
                            </div>
                            
                            <div class="vehicle-details flex-grow-1 w-100">
                                <div class="row g-3">
                                    <div class="col-6 col-md-3 vehicle-stat">
                                        <span class="vehicle-stat-label">Loại phương tiện</span>
                                        <span class="vehicle-stat-value fs-5">Ô tô</span>
                                    </div>
                                    <div class="col-6 col-md-3 vehicle-stat">
                                        <span class="vehicle-stat-label">Tổng sức chứa</span>
                                        <span class="vehicle-stat-value">500 chỗ</span>
                                    </div>
                                    <div class="col-6 col-md-3 vehicle-stat">
                                        <span class="vehicle-stat-label">Vé lượt (Giờ)</span>
                                        <span class="vehicle-stat-value text-danger">20.000 VNĐ</span>
                                    </div>
                                    <div class="col-6 col-md-3 vehicle-stat">
                                        <span class="vehicle-stat-label">Vé tháng</span>
                                        <span class="vehicle-stat-value text-danger">1.500.000 VNĐ</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="vehicle-card p-3 p-md-4 d-flex flex-column flex-md-row align-items-start align-items-md-center gap-3 gap-md-4">
                            <div class="vehicle-icon flex-shrink-0" style="background-color: #fef2f2; color: #ef4444;">
                                <i class="bi bi-scooter"></i>
                            </div>
                            
                            <div class="vehicle-details flex-grow-1 w-100">
                                <div class="row g-3">
                                    <div class="col-6 col-md-3 vehicle-stat">
                                        <span class="vehicle-stat-label">Loại phương tiện</span>
                                        <span class="vehicle-stat-value fs-5">Xe máy</span>
                                    </div>
                                    <div class="col-6 col-md-3 vehicle-stat">
                                        <span class="vehicle-stat-label">Tổng sức chứa</span>
                                        <span class="vehicle-stat-value">1,200 chỗ</span>
                                    </div>
                                    <div class="col-6 col-md-3 vehicle-stat">
                                        <span class="vehicle-stat-label">Vé lượt (Giờ)</span>
                                        <span class="vehicle-stat-value text-danger">5.000 VNĐ</span>
                                    </div>
                                    <div class="col-6 col-md-3 vehicle-stat">
                                        <span class="vehicle-stat-label">Vé tháng</span>
                                        <span class="vehicle-stat-value text-danger">150.000 VNĐ</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="mt-5 pt-4 border-top">
                        <div class="info-group m-0">
                            <div class="info-label mb-3">Vị trí trên bản đồ</div>
                            <div class="map-placeholder">
                                <i class="bi bi-pin-map-fill" style="font-size: 3rem; color: #94a3b8; margin-bottom: 10px;"></i>
                                <span class="px-3 text-center">Bản đồ khu vực đang được hiển thị...</span>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>
        </main>

        <script>
            // Xử lý bật/tắt Sidebar trên Mobile
            const mobileToggle = document.getElementById('mobileToggle');
            const sidebar = document.querySelector('.sidebar');

            mobileToggle.addEventListener('click', () => {
                sidebar.classList.toggle('active');
            });
        </script>
    </body>
</html>