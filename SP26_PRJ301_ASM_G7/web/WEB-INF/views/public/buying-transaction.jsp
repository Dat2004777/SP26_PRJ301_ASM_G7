<%-- 
    Document   : buying-transaction
    Created on : Mar 1, 2026, 8:38:07 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buying Confirmation Page</title>
        <!-- Google Fonts: Inter -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

        <!-- Bootstrap 5 CSS -->
        <link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet">

        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

        <style>
            :root {
                --primary-color: #0d6efd;
                --bs-primary: #1a56db;
                --bs-primary-rgb: 26, 86, 219;
                --bs-font-sans-serif: 'Inter', sans-serif;
                --text-main: #374151;
                --text-muted: #6b7280;
            }

            body {
                background-color: #f9fafb;
                font-family: var(--bs-font-sans-serif);
                color: var(--text-main);
                -webkit-font-smoothing: antialiased;
            }

            .main-content-card {
                background: white;
                padding: 2rem;
                border-radius: 1.5rem;
                border: 1px solid #e5e7eb;
                box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            }
            .selected-badge {
                position: absolute;
                top: -10px;
                right: -10px;
                background: white;
                color: var(--primary-color);
                font-size: 20px;
                line-height: 1;
                border-radius: 50%;
            }
            .pricing-card {
                background: white;
                transition: all 0.3s ease;
                cursor: pointer;
            }
            .pricing-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
            }

            .pricing-card.active {
                border: 2px solid var(--primary-color) !important;
            }
            /* Các bước thực hiện */
            .step-number {
                width: 28px;
                height: 28px;
                background-color: var(--primary-color);
                color: white;
                border-radius: 50%;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                font-size: 14px;
                font-weight: bold;
                margin-right: 12px;
            }

            /* Plan Cards */
            .plan-card {
                border: 1px solid #e5e7eb;
                border-radius: 1rem;
                padding: 1.25rem;
                background: white;
                cursor: pointer;
                transition: all 0.2s ease;
                position: relative;
                height: 100%;
            }

            .plan-card.active {
                border: 2px solid var(--primary-color);
                background-color: #f0f4ff;
            }

            .plan-card .check-icon {
                position: absolute;
                top: 10px;
                right: 10px;
                font-size: 1.25rem;
            }

            .badge-promo {
                position: absolute;
                top: 10px;
                right: 10px;
                background: #dcfce7;
                color: #166534;
                font-size: 11px;
                font-weight: 700;
                padding: 2px 8px;
                border-radius: 1rem;
            }

            /* Map Placeholder */
            .map-box {
                background: #e5e7eb;
                height: 200px;
                display: flex;
                align-items: center;
                justify-content: center;
                background-image: radial-gradient(#cbd5e1 1px, transparent 1px);
                background-size: 15px 15px;
            }

            .site-display-input {
                width: 100%;
                border: none;
                background: #eef2ff;
                padding: 12px 14px;
                border-radius: 0.75rem;
                font-weight: 600;
                color: #1a56db;
                font-size: 0.95rem;
            }

            .site-display-input:focus {
                outline: none;
            }
            /* Biển số xe input */
            #licenseInput {
                letter-spacing: 1px;
            }
            
            /* Custom Responsive */
            @media (max-width: 991.98px) {
                .main-content-card {
                    padding: 1.5rem;
                }
            }
        </style>
    </head>
    <body>
        <!--Header-->
        <%@include file="/WEB-INF/views/layout/header.jsp" %>

        <div class="container my-5">
            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="main-content-card h-100">
                        <header class="mb-4">
                            <h1 class="h3 fw-bold mb-1">Đăng ký vé tháng</h1>
                            <p class="text-muted">Giải pháp đỗ xe dài hạn tiết kiệm và tiện lợi cho phương tiện của bạn.</p>
                        </header>

                        <section class="mb-5">
                            <div class="d-flex align-items-center mb-4">
                                <span class="step-number me-2">1</span>
                                <h5 class="mb-0 fw-bold">Chọn gói vé</h5>
                            </div>

                            <div class="row g-3">
                                <div class="col-md-4">
                                    <div class="pricing-card active h-100 p-3 border rounded-3 position-relative">
                                        <div class="selected-badge"><i class="fa-solid fa-circle-check"></i></div>
                                        <p class="text-secondary small mb-1">Vé tháng</p>
                                        <h4 class="fw-bold">
                                            <span id="price-month">500k</span>
                                            <small class="text-muted fs-6">/tháng</small>
                                        </h4>
                                        <ul class="list-unstyled mt-3 small">
                                            <li class="mb-2 text-success"><i class="fa-solid fa-check me-2"></i>Ra vào tự do
                                            </li>
                                            <li class="text-success"><i class="fa-solid fa-check me-2"></i>Hỗ trợ 24/7</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="pricing-card h-100 p-3 border rounded-3 position-relative">
                                        <span
                                            class="badge bg-success-subtle text-success position-absolute top-0 end-0 m-2">-10%</span>
                                        <p class="text-secondary small mb-1">Vé quý</p>
                                        <h4 class="fw-bold">
                                            <span id="price-quarter">1.350k</span>
                                            <small class="text-muted fs-6">/3 tháng</small>
                                        </h4>
                                        <ul class="list-unstyled mt-3 small">
                                            <li class="mb-2 text-success"><i class="fa-solid fa-check me-2"></i>Tiết kiệm 150k
                                            </li>
                                            <li class="text-success"><i class="fa-solid fa-check me-2"></i>Ra vào tự do</li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="pricing-card h-100 p-3 border rounded-3 position-relative">
                                        <span
                                            class="badge bg-primary-subtle text-primary position-absolute top-0 end-0 m-2 text-uppercase">Best</span>
                                        <p class="text-secondary small mb-1">Vé năm</p>
                                        <h4 class="fw-bold">
                                            <span id="price-year">5.000k</span>
                                            <small class="text-muted fs-6">/năm</small>
                                        </h4>
                                        <ul class="list-unstyled mt-3 small">
                                            <li class="mb-2 text-success"><i class="fa-solid fa-check me-2"></i>Giảm 2 tháng
                                            </li>
                                            <li class="text-success"><i class="fa-solid fa-check me-2"></i>Vị trí ưu tiên</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <section class="mb-5">
                            <h5 class="fw-bold mb-4 d-flex align-items-center"><span class="step-number">2</span> Thông tin đăng ký</h5>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold fs-6">Bãi đỗ xe</label>
                                    <input type="text"  class="site-display-input" value="${site.siteName}" readonly=""/>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold fs-6">Loại phương tiện</label>
                                    <div class="d-flex gap-2">
                                        <c:forEach var="v" items="${vehicles}">
                                            <input type="radio" class="btn-check" name="vtype" value="${v.vehicle.vehicleTypeId}" id="${v.vehicle.vehicleName}" checked>
                                            <label class="btn btn-outline-primary flex-grow-1 py-2" for="${v.vehicle.vehicleName}"><i class="bi bi-car-front me-2"></i>${v.vehicle.vehicleName}</label>
                                            </c:forEach>
                                        <!--                                        <input type="radio" class="btn-check" name="vtype" value="1" id="car" checked>
                                                                                <label class="btn btn-outline-primary flex-grow-1 py-2" for="car"><i class="bi bi-car-front me-2"></i> Ô tô</label>-->

                                        <!--                                        <input type="radio" class="btn-check" name="vtype" value="2" id="bike">
                                                                                <label class="btn btn-outline-primary flex-grow-1 py-2" for="bike"><i class="bi bi-bicycle me-2"></i> Xe máy</label>-->
                                    </div>
                                </div>
                                <div class="col-12 mt-4">
                                    <label class="form-label fw-semibold fs-6">Biển số xe</label>
                                    <input type="text" class="form-control bg-light border-1 py-2 fs-5 text-uppercase fw-bold" placeholder="VÍ DỤ: 51F-123.45">
                                </div>
                            </div>
                        </section>

                        <div class="map-box position-relative overflow-hidden rounded-4">
                            <div class="bg-white px-3 py-2 rounded-pill shadow-sm small fw-medium position-absolute top-50 start-50 translate-middle">
                                <i class="bi bi-geo-alt-fill text-primary me-1"></i> Vị trí bãi xe đã chọn
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="card border-0 shadow-sm rounded-4 overflow-hidden position-sticky" style="top: 20px;">
                        <div class="card-header bg-white border-0 py-3 px-4">
                            <h5 class="fw-bold mb-0 d-flex align-items-center text-dark">
                                <i class="bi bi-cart-fill me-2 text-primary"></i> Tóm tắt đơn hàng
                            </h5>
                        </div>

                        <div class="card-body p-4 pt-0">
                            <div class="summary-info mb-4">
                                <div class="d-flex justify-content-between mb-3">
                                    <span class="text-muted">Gói đăng ký:</span>
                                    <span class="fw-bold text-dark">Vé tháng (1 tháng)</span>
                                </div>
                                <div class="d-flex justify-content-between mb-3">
                                    <span class="text-muted">Biển số xe:</span>
                                    <span class="fw-bold text-dark">51F-123.45</span>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <span class="text-muted">Thời hạn:</span>
                                    <span class="fw-bold text-dark">01/10 - 31/10/2023</span>
                                </div>
                            </div>

                            <hr class="border-secondary opacity-10 mb-4" style="border-style: dashed;">

                            <div class="rounded-3 p-3 mb-4" style="background-color: #f8faff;">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted small">Tạm tính:</span>
                                    <span class="text-dark fw-medium" id="summary-subtotal">500.000đ</span>
                                </div>
                                <div class="d-flex justify-content-between mb-3 border-bottom pb-2">
                                    <span class="text-muted small">Phí dịch vụ:</span>
                                    <span class="text-dark fw-medium">0đ</span>
                                </div>
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <span class="fw-bold text-dark">Tổng cộng:</span>
                                    <span class="fw-bold fs-3 text-primary" id="summary-total">500.000đ</span>
                                </div>
                            </div>

                            <button class="btn btn-primary w-100 py-3 fw-bold rounded-3 shadow-sm d-flex align-items-center justify-content-center"
                                    style="background-color: #1d61e7; border: none;">
                                <i class="bi bi-cash-stack me-2"></i> Thanh toán ngay
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--Footer-->
        <%@ include file="/WEB-INF/views/layout/footer.jsp" %>
    </body>
</html>
